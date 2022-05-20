#include <errno.h>
#include <syslog.h>
#include <stdio.h>
#include <stdarg.h>
#include <signal.h>

#include <mrd/mrd.h>
#include <mrd/log.h>

enum {
	log_method_attach = 1000
};

static const method_info log_methods[] = {
	{ "attach", "Attaches a new log instance",
		log_method_attach, false, property_def::NEGATE },
	{ 0 }
};

/* dummy stuff */
el_def endl;

enum {
	_LOG_INFO = 1,
	_LOG_WARN = 2,
	_LOG_FATAL = 4
};

base_stream &operator << (base_stream &os, bool b) {
	return os << (b ? "true" : "false");
}

base_stream &operator << (base_stream &os, int val) {
	int k = snprintf(os.req_buffer(16), 16, "%i", val);
	if (k > 16)
		k = 16;
	os.commit_change(k);
	return os;
}

base_stream &operator << (base_stream &os, uint32_t val) {
	int k = snprintf(os.req_buffer(16), 16, "%u", val);
	if (k > 16)
		k = 16;
	os.commit_change(k);
	return os;
}

base_stream &operator << (base_stream &os, uint64_t val) {
	int k = snprintf(os.req_buffer(32), 32, "%llu", val);
	if (k > 32)
		k = 32;
	os.commit_change(k);
	return os;
}

base_stream &operator << (base_stream &os, const char *str) {
	os.append_chunk(str);
	return os;
}

base_stream &operator << (base_stream &os, const std::string &str) {
	return os << str.c_str();
}

base_stream &operator << (base_stream &os, const void *ptr) {
	int k = snprintf(os.req_buffer(32), 32, "%p", ptr);
	if (k > 32)
		k = 32;
	os.commit_change(k);
	return os;
}

base_stream &operator << (base_stream &os, const el_def &dummy) {
	if (os.dec && os.fl)
		os.fl->flushed(os.str(), true);

	os.clear();

	return os;
}

base_stream &operator << (base_stream &os, double val) {
	int k = snprintf(os.req_buffer(16), 16, "%.2lf", val);
	if (k > 16)
		k = 16;
	os.commit_change(k);
	return os;
}

stream_flusher::~stream_flusher() {
}

base_stream::base_stream()
	: fl(0), level(0), dec(true) {
	ptr = 0;
	buffer[0] = 0;
}

base_stream::base_stream(stream_flusher *flusher)
	: fl(flusher), level(0), dec(true) {
	ptr = 0;
	buffer[0] = 0;
}

base_stream::~base_stream() {
}

void base_stream::inc_level() {
	level++;
}

void base_stream::dec_level() {
	level--;
}

void base_stream::spaces(int count) {
	while (count > 0) {
		char tmp[17];

		int c = count > (int)(sizeof(tmp) - 1) ? (sizeof(tmp) - 1) : count;

		memset(tmp, ' ', c);
		tmp[c] = 0;

		append_chunk(tmp);

		count -= c;
	}
}

void base_stream::append_chunk(const char *str) {
	if (dec)
		append_chunk(str, strlen(str));
}

base_stream &base_stream::printf(const char *fmt, ...) {
	if (dec) {
		va_list vl;
		va_start(vl, fmt);

		int k = vsnprintf(req_buffer(192), 192, fmt, vl);
		if (k > 192)
			k = 192;
		commit_change(k);

		va_end(vl);
	}

	return *this;
}

base_stream &base_stream::xprintf(const char *fmt, ...) {
	if (dec) {
		va_list vl;
		va_start(vl, fmt);

		int p = 0, v = 0;

		while (1) {
			if (fmt[p] == '%') {
				append_chunk(fmt + v, p - v);
				p++;
				if (fmt[p] == 's') {
					const char *str = va_arg(vl, const char *);
					append_chunk(str ? str : "(null)");
				} else if (fmt[p] == 'u') {
					commit_change(snprintf(req_buffer(16), 16, "%u", va_arg(vl, uint32_t)));
				} else if (fmt[p] == 'i') {
					commit_change(snprintf(req_buffer(16), 16, "%i", va_arg(vl, int32_t)));
				} else {
					break;
				}
				p++;
				v = p;
			} else if (fmt[p] == '\n') {
				append_chunk(fmt + v, p - v);
				p++;
				v = p;

				if (dec && fl)
					fl->flushed(str(), true);
				clear();
			} else if (!fmt[p]) {
				break;
			} else {
				p++;
			}
		}

		if (v < p) {
			append_chunk(fmt + v, p - v);
		}

		va_end(vl);
	}

	return *this;
}

void base_stream::set_decision(bool b) {
	dec = b;
}

void base_stream::flush() {
	if (dec && fl)
		fl->flushed(str(), false);

	clear();
}

void base_stream::ident_start() {
	int l = level;
	if (l > 20)
		l = 20;

	memset(buffer, ' ', l * 2);

	ptr = l * 2;
}

void base_stream::append_chunk(const char *str, int len) {
	append_chunk(str, len, true);
}

void base_stream::append_chunk(const char *str, int len, bool first) {
	if (dec) {
		if (first && ptr == 0) {
			ident_start();
		}

		int x;

		if ((len + ptr) > (int)(sizeof(buffer)-1)) {
			x = sizeof(buffer) - ptr - 1;
		} else {
			x = len;
		}

		strncpy(buffer + ptr, str, x);
		/* if sizeof(char) = 1 byte..
		memcpy(buffer + ptr, str, x);*/

		ptr += x;

		buffer[ptr] = 0;

		if (x < len) {
			flush();

			append_chunk(str + x, len - x, false);
		}
	}
}

char *base_stream::req_buffer(int n) {
	return req_buffer(n, true);
}

char *base_stream::req_buffer(int n, bool first) {
	if (n > (int)(sizeof(buffer)-1))
		return 0;

	if (first && ptr == 0)
		ident_start();

	/* must flush */
	if ((n + ptr) > (int)(sizeof(buffer)-1)) {
		/* prevent loops */
		if (!first)
			return 0;

		flush();

		return req_buffer(n, false);
	}

	return buffer + ptr;
}

void base_stream::commit_change(int n) {
	ptr += n;
}

void base_stream::clear() {
	ptr = 0;
	buffer[0] = 0;
}

const char *base_stream::str() const {
	return buffer;
}

log_node::log_node(log_base *parent, const char *name, int level)
	: node(parent, name) {
	infolevel = instantiate_property_i("infolevel", level);
}

bool log_node::check_startup() {
	return node::check_startup() && infolevel != 0;
}

void log_node::set_level(const char *l) {
	set_property("infolevel", l);
}

bool log_node::set_property(const char *name, const char *value) {
	if (!strcmp(name, "infolevel")) {
		int level;
		if (!parse_infolevel(value, level))
			return false;
		/* very stupid'ish */
		char buf[32];
		snprintf(buf, sizeof(buf), "%i", level);

		return node::set_property(name, buf);
	}

	return node::set_property(name, value);
}

bool log_node::will_log(int type, int level) const {
	return type != _LOG_INFO || level <= infolevel->get_integer();
}

syslog_log_node::syslog_log_node(log_base *parent, const char *name, int infolevel)
	: log_node(parent, name, infolevel) {
}

syslog_log_node::~syslog_log_node() {
	closelog();
}

bool syslog_log_node::check_startup() {
	if (!log_node::check_startup())
		return false;

	openlog("mrd", LOG_PID, LOG_DAEMON);

	return true;
}

static inline int type_as_syslog_priority(int t) {
	switch (t) {
	case _LOG_INFO:
		return LOG_INFO;
	case _LOG_WARN:
		return LOG_WARNING;
	case _LOG_FATAL:
		return LOG_CRIT;
	default:
		return LOG_ERR;
	}
}

void syslog_log_node::log(int type, int level, const char *msg, bool) {
	syslog(type_as_syslog_priority(type), msg);
}

tb_log_node::tb_log_node(log_base *parent, const char *name, int level)
	: log_node(parent, name, level), _lnow(0) {}

const char *tb_log_node::now_s() {
	time_t nowt = time(NULL);

	if (nowt > _lnow) {
		struct tm tmp;
		strftime(_fbuf, sizeof(_fbuf), "%b %d %H:%M:%S ", localtime_r(&nowt, &tmp));
		_lnow = nowt;
	}

	return _fbuf;
}

file_log_node::file_log_node(log_base *parent, const char *name, int level,
			     const char *filename, bool flush)
	: tb_log_node(parent, name, level) {

	_base_filename = filename;

	_fp = fopen(filename, "a");

	_flush = instantiate_property_b("flush", flush);
	_detailed = instantiate_property_b("detailed", false);
}

file_log_node::file_log_node(log_base *parent, const char *name, int level,
			     FILE *param)
	: tb_log_node(parent, name, level), _fp(param) {

	_flush = instantiate_property_b("flush", false);
	_detailed = instantiate_property_b("detailed", false);
}

file_log_node::~file_log_node() {
	if (_fp && _fp != stderr) {
		fclose(_fp);
		_fp = 0;
	}
}

bool file_log_node::check_startup() {
	if (!log_node::check_startup())
		return false;
	return _flush != 0 && _detailed != 0 && _fp != 0;
}

void file_log_node::log(int type, int level, const char *msg, bool newline) {
	if (!_fp)
		return;

	if (_detailed->get_bool()) {
		if (type == _LOG_INFO) {
			fprintf(_fp, "%sINFO(%i) %s", now_s(), level, msg);
		} else {
			fprintf(_fp, "%s%s %s", now_s(), type == _LOG_WARN ? "WARN" : "FATAL", msg);
		}
	} else {
		fputs(now_s(), _fp);
		fputs(msg, _fp);
	}

	if (newline)
		fputc('\n', _fp);

	if (newline && _flush->get_bool())
		fflush(_fp);
}

void file_log_node::event(int ev, void *ptr) {
	if (ev == log_base::ReloadEvent) {
		if (_fp != stderr) {
			fclose(_fp);
			_fp = fopen(_base_filename.c_str(), "a");
		}
	} else {
		tb_log_node::event(ev, ptr);
	}
}

static void _handle_log_reload(int) {
	g_mrd->log().reload_logs();
}

log_base::log_base(node *parent)
	: node(parent, "log"), _base(this) {
}

log_base::~log_base() {
	signal(SIGHUP, SIG_IGN);

	clear_childs();
}

void log_base::remove_child_node(node *n) {
	delete (log_node *)n;
}

const char *log_base::description() const {
	return "Logging facilities";
}

bool log_base::check_startup() {
	if (!node::check_startup())
		return false;

	signal(SIGHUP, _handle_log_reload);

	import_methods(log_methods);

	return true;
}

void log_base::reload_logs() {
	broadcast_event(ReloadEvent, 0);
}

bool log_base::would_log(int level) const {
	/* is any of the child log nodes interested in this level of message? */

	for (properties::const_iterator i = m_properties.begin();
			i != m_properties.end(); ++i) {
		if (!i->second.is_child())
			continue;
		if (((log_node *)i->second.get_node())->will_log(_LOG_INFO, level))
			return true;
	}

	return false;
}

base_stream &log_base::info(int level) {
	_current = _LOG_INFO;
	_level = level;

	_base.set_decision(would_log(level));

	return _base;
}

base_stream &log_base::warn() {
	_current = _LOG_WARN;
	_level = 0;

	_base.set_decision(true);

	return _base;
}

base_stream &log_base::fatal() {
	_current = _LOG_FATAL;
	_level = 0;

	_base.set_decision(true);

	return _base;
}

void log_base::perror(const char *str) {
	fatal() << str << ":" << strerror(errno) << endl;
}

bool log_base::attach_node(log_node *n) {
	if (!n || !n->check_startup()) {
		delete n;
		return false;
	}

	node *was = get_child(n->name());

	if (was) {
		remove_child(was->name());
	}

	add_child(n);

	return true;
}

void log_base::dettach_node(log_node *n) {
	if (n)
		remove_child(n->name());
}

bool log_base::call_method(int id, base_stream &out,
			   const std::vector<std::string> &args) {
	switch (id) {
	case log_method_attach:
		return attach_node(args);
	}

	return node::call_method(id, out, args);
}

bool log_base::negate_method(int id, base_stream &out,
			     const std::vector<std::string> &args) {
	if (id == log_method_attach) {
		if (args.empty())
			return false;

		log_node *n = (log_node *)get_child(args[0].c_str());

		if (n) {
			remove_child(args[0].c_str());
		}

		return true;
	}

	return node::negate_method(id, out, args);
}

void log_base::flushed(const char *str, bool newline) {
	for (properties::const_iterator i = m_properties.begin();
			i != m_properties.end(); ++i) {
		if (!i->second.is_child())
			continue;

		log_node *n = (log_node *)i->second.get_node();

		if (n->will_log(_current, _level))
			n->log(_current, _level, str, newline);
	}
}

static inline bool _as_int(const char *v, int &value) {
	char *end;
	value = strtol(v, &end, 10);
	if (*end)
		return false;
	return true;
}

bool log_node::parse_infolevel(const char *v, int &value) {
	if (!strcmp(v, "all")) {
		value = LOG_ALL;
	} else if (!strcmp(v, "internal_flow")) {
		value = INTERNAL_FLOW;
	} else if (!strcmp(v, "message_content")) {
		value = MESSAGE_CONTENT;
	} else if (!strcmp(v, "message_sig")) {
		value = MESSAGE_SIG;
	} else if (!strcmp(v, "message_err")) {
		value = MESSAGE_ERR;
	} else if (!strcmp(v, "extradebug")) {
		value = EXTRADEBUG;
	} else if (!strcmp(v, "debug")) {
		value = DEBUG;
	} else if (!strcmp(v, "verbose")) {
		value = VERBOSE;
	} else if (!strcmp(v, "normal")) {
		value = NORMAL;
	} else if (!strcmp(v, "quiet")) {
		value = QUIET;
	} else {
		return _as_int(v, value);
	}

	return true;
}

bool log_base::attach_node(const std::vector<std::string> &args) {
	if (args.empty())
		return false;

	log_node *n = 0;
	int val = 5;

	if (args[0] == "syslog") {
		if (args.size() > 1) {
			if (!log_node::parse_infolevel(args[1].c_str(), val))
				return false;
		}
		n = new syslog_log_node(this, "syslog", val);
	} else if (args[0] == "stderr") {
		if (args.size() > 1) {
			if (!log_node::parse_infolevel(args[1].c_str(), val))
				return false;
		}
		n = new file_log_node(this, "stderr", val, stderr);
	} else if (args.size() > 1) {
		bool flush = true;
		if (args.size() > 2) {
			if (!log_node::parse_infolevel(args[2].c_str(), val))
				return false;
			if (args.size() > 3) {
				if (args[3] == "no-flush")
					flush = true;
				else
					return false;
			}
		}
		n = new file_log_node(this, args[0].c_str(), val,
				      args[1].c_str(), flush);
	}

	if (!n)
		return false;

	attach_node(n);

	return true;
}

