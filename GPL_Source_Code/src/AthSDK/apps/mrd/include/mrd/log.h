/*
 * Multicast Routing Daemon (MRD)
 *   log.h
 *
 * Copyright (C) 2004, 2005
 *   Universidade de Aveiro, Instituto Telecomunicacoes - Polo Aveiro
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 * Authors:	Hugo Santos <hsantos@av.it.pt>
 */

#ifndef _mrd_log_h_
#define _mrd_log_h_

#include <string>
#include <mrd/node.h>

class stream_flusher {
public:
	virtual ~stream_flusher();

	virtual void flushed(const char *buffer, bool newline) = 0;
};

struct el_def {};
extern el_def endl;

/*!
 * base log stream
 */
class base_stream {
public:
	base_stream();
	base_stream(stream_flusher *);
	~base_stream();

	/*! appends a new string chunk to the stream buffer */
	void append_chunk(const char *);
	void append_chunk(const char *, int);
	/*! requests a buffer part of minimal size n for direct writing.
	 * if there isn't enough space, returns NULL */
	char *req_buffer(int n);
	/*! after directly accessing the buffer, must commit changes
	 * of n characters */
	void commit_change(int n);
	/*! clears the stream buffer */
	void clear();
	/*! returns a null-terminated string pointer to the stream buffer */
	const char *str() const;

	/*! provides printf-like semantics to base_stream */
	base_stream &printf(const char *, ...);

	/*! method (hopefully better performant) that provides a very
	 * simple printf-like semantics to base_stream */
	base_stream &xprintf(const char *, ...);

	/*! increase indenting level */
	void inc_level();
	/*! decrease indenting level */
	void dec_level();

	/*! produce n spaces of output */
	void spaces(int n);

	/*!
	 * controls whether a stream flush distributes the buffer
	 * for logging or not
	 */
	void set_decision(bool);

	/*!
	 * flushes the stream buffer. if decision=true, all log_nodes
	 * are notified and prompted to log
	 */
	void flush();

	friend base_stream &operator << (base_stream &, const el_def &);

protected:
	void ident_start();
	void append_chunk(const char *, int, bool);
	char *req_buffer(int, bool);

	stream_flusher *fl;
	int level;
	bool dec;

	char buffer[256];
	int ptr;
};

base_stream &operator << (base_stream &, bool);
base_stream &operator << (base_stream &, int);
base_stream &operator << (base_stream &, uint32_t);
base_stream &operator << (base_stream &, uint64_t);
base_stream &operator << (base_stream &, const char *);
base_stream &operator << (base_stream &, const std::string &);
base_stream &operator << (base_stream &, const void *);
base_stream &operator << (base_stream &, double);

class log_base;

/*!
 * log nodes are notified by log_base whenever there is info to be
 * logged. i.e. after a base_stream::flush
 */
class log_node : public node {
public:
	log_node(log_base *, const char *name, int infolevel);

	bool check_startup();

	void set_level(const char *);
	bool set_property(const char *, const char *);

	static bool parse_infolevel(const char *, int &);

	/*! method called by log_base with logging info */
	virtual void log(int, int, const char *, bool newline) = 0;

protected:
	bool will_log(int, int) const;

	property_def *infolevel;

	friend class log_base;
};

/*! syslog based log_node */
class syslog_log_node : public log_node {
public:
	syslog_log_node(log_base *, const char *, int);
	~syslog_log_node();

	bool check_startup();
	void log(int, int, const char *, bool newline);
};

class tb_log_node : public log_node {
public:
	tb_log_node(log_base *, const char *name, int infolevel);

	const char *now_s();

	char _fbuf[64];
	time_t _lnow;
};

/*! file based log_node (also supports stderr) */
class file_log_node : public tb_log_node {
public:
	file_log_node(log_base *, const char *, int, const char *, bool flush);
	file_log_node(log_base *, const char *, int, FILE *);
	~file_log_node();

	bool check_startup();
	void log(int, int, const char *, bool newline);

	void event(int, void *);

	FILE *_fp;
	std::string _base_filename;
	property_def *_flush, *_detailed;
};

enum {
	QUIET = 1,
	NORMAL = 5,
	VERBOSE = 10,
	DEBUG = 15,
	EXTRADEBUG = 20,
	MESSAGE_ERR = 25,
	MESSAGE_SIG = 40,
	MESSAGE_CONTENT = 60,
	INTERNAL_FLOW = 250,
	LOG_ALL = 1000000
};

/*!
 * provides the architecture's logging interface
 */
class log_base : public node, public stream_flusher {
public:
	log_base(node *);
	~log_base();

	const char *description() const;

	bool check_startup();

	/*! starts a info-level logging context with specified level */
	base_stream &info(int level);
	base_stream &warn();
	base_stream &fatal();

	/*! returns true if would log at the specified level */
	bool would_log(int level) const;

	/*! simulates POSIX's perror using the internal logging mechanism */
	void perror(const char *);

	/*! attaches a new logging node to the architecture */
	bool attach_node(log_node *);
	void dettach_node(log_node *);

	bool call_method(int, base_stream &,
			 const std::vector<std::string> &);
	bool negate_method(int, base_stream &,
			   const std::vector<std::string> &);

	enum {
		ReloadEvent = 'R',
	};

	void reload_logs();

protected:
	void flushed(const char *, bool);

	void remove_child_node(node *);

	bool attach_node(const std::vector<std::string> &);

	int _current, _level;

	base_stream _base;
};

#endif

