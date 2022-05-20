/*
 * Multicast Routing Daemon (MRD)
 *   snmp.cpp
 *
 * Copyright (C) 2004 Univ. Aveiro, Instituto Telecomunicacoes - Polo Aveiro
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
 * Authors:	Hugo Santos, <hsantos@av.it.pt>
 */

#include <snmp/snmp.h>
#include <snmp/snmp_primitives.h>

#include <iostream>
#include <iomanip>
#include <algorithm>

#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <unistd.h>

#include <arpa/inet.h>

namespace snmp {

static uint8_t buffer[8192];

agent::agent() {
	sock = -1;
}

agent::~agent() {
}

bool agent::check_startup() {
	sock = socket(AF_INET, SOCK_STREAM, 0);
	if (sock < 0)
		return false;

	sockaddr_in sin;
	memset(&sin, 0, sizeof(sin));

	inet_pton(AF_INET, "127.0.0.1", &sin.sin_addr);
	
	sin.sin_family = AF_INET;
	sin.sin_port = htons(199);

	int one = 1;
	setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));

	if (connect(sock, (sockaddr *)&sin, sizeof(sin)) < 0) {
		close(sock);
		return false;
	}

	smux_simple_open_pdu pdu;

	pdu.identity = asn::oid("1.3.6.1.4.1.23.23");
	pdu.description = "mrd6";

	asn::static_encoding_buffer buf(buffer, sizeof(buffer));
	if (!pdu.encode(buf)) {
		close(sock);
		return false;
	}

	send(sock, buffer, buf.get_pointer(), 0);

	return true;
}

void agent::shutdown() {
	if (sock > 0) {
		close(sock);
		sock = -1;
	}
}

void agent::closed(int) {
}

void agent::registration_result(const asn::oid &oid, int res) {
	// XXX
}

void agent::data_available() {
	int res;

	sockaddr_in from;
	socklen_t fromlen = sizeof(from);

	if ((res = recvfrom(sock, buffer, sizeof(buffer), 0, (sockaddr *)&from, &fromlen)) < 0) {
		return;
	}

	asn::static_encoding_buffer buf(buffer, res);

	pdu pdu;

	if (pdu.decode(buf)) {
		switch (pdu->get_type()) {
		case 0x41:
			closed(((smux_close_pdu &)*pdu));
			return;
		case 0x43:
			if (!register_stack.empty()) {
				registration_result(register_stack.top(), ((smux_rrsp_pdu &)*pdu));
				register_stack.pop();
			}
			break;
		case 0xa0:
		case 0xa1:
			handle_get(pdu->get_type() == 0xa1, (const set_get_msg &)*pdu);
			break;
		case 0xa5:
			handle_bulk_get((const set_get_msg &)*pdu);
			break;
		default:
			break;
		}
	} else {
		// XXX
	}
}

bool agent::register_mib(const asn::oid &oid) {
	smux_rreq_pdu pdu;

	pdu.subtree = oid;
	pdu.priority = 5;
	pdu.operation = 1;

	asn::static_encoding_buffer buf(buffer, sizeof(buffer));

	if (pdu.encode(buf) && send(sock, buffer, buf.get_pointer(), 0) > 0) {
		register_stack.push(oid);
		return true;
	}

	return false;
}

void agent::handle_get(bool next, const set_get_msg &msg) {
	if (msg.get_error_status() == 0 && msg.get_error_index() == 0) {
		set_get_msg resppdu(0xa2);

		resppdu.get_request_id() = msg.get_request_id();

		const std::vector<varbind> &varbinds = msg.get_varbinds();

		for (std::vector<varbind>::const_iterator i = varbinds.begin(); i != varbinds.end(); i++) {
			resppdu.get_varbinds().push_back(varbind(i->get_oid()));

			handle_get(resppdu, next, *i, resppdu.get_varbinds().back());
		}

		asn::static_encoding_buffer buf(buffer, sizeof(buffer));

		if (!resppdu.encode(buf)) {
			return;
		}

		send(sock, buffer, buf.get_pointer(), 0);
	}
}

void agent::handle_bulk_get(const set_get_msg &msg) {
	set_get_msg resppdu(0xa2);

	resppdu.get_request_id() = msg.get_request_id();

	const std::vector<varbind> &varbinds = msg.get_varbinds();

	for (std::vector<varbind>::const_iterator i = varbinds.begin(); i != varbinds.end(); i++) {
		// in this context, get_error_index = max-repetitions
		handle_bulk_get(resppdu, *i, msg.get_error_index());
	}

	asn::static_encoding_buffer buf(buffer, sizeof(buffer));

	if (!resppdu.encode(buf)) {
		return;
	}

	send(sock, buffer, buf.get_pointer(), 0);
}

void agent::handle_get(set_get_msg &, bool next, const varbind &req, varbind &resp) const {
	resp.get_value().instantiate(0x80);
}

int agent::handle_bulk_get(set_get_msg &msg, const varbind &req, int max) const {
	msg.get_varbinds().push_back(varbind(req.get_oid()));
	msg.get_varbinds().back().get_value().instantiate(0x80);

	return 1;
}

bool mib_static_table::handle_get(set_get_msg &msg, const asn::oid &reqbase, bool next, const asn::oid &req, varbind &resp) const {
	const std::vector<int> &reqoid = reqbase;

	if (values.empty() || reqoid.size() > 1)
		return false;
	
	if (!next && reqoid.empty())
		return false;

	std::map<int, any>::const_iterator k;

	if (next) {
		if (reqoid.empty()) {
			k = values.begin();
			((std::vector<int> &)resp.get_oid()).push_back(k->first);
		} else {
			k = values.find(*reqoid.begin());
			k++;
			if (k == values.end()) {
				msg.get_error_status() = set_get_msg::err_no_such_name;
				msg.get_error_index() = *reqoid.begin();
				return true;
			}
			((std::vector<int> &)resp.get_oid()).back() = k->first;
		}
	} else {
		k = values.find(*reqoid.begin());
	}
	
	if (k == values.end())
		return false;

	resp.get_value().set_to(k->second->clone());

	return true;
}

bool mib_single_table::handle_get(set_get_msg &msg, const asn::oid &reqbase, bool next, const asn::oid &req, varbind &resp) const {
	const std::vector<int> &reqoid = reqbase;

	if (columns.empty() || reqoid.size() > 1)
		return false;
	
	if (!next && reqoid.empty())
		return false;

	std::set<int>::const_iterator k;

	if (next) {
		if (reqoid.empty()) {
			k = columns.begin();
			((std::vector<int> &)resp.get_oid()).push_back(*k);
		} else {
			k = std::find(columns.begin(), columns.end(), *reqoid.begin());
			k++;
			if (k == columns.end()) {
				msg.get_error_status() = set_get_msg::err_no_such_name;
				msg.get_error_index() = *reqoid.begin();
				return true;
			}
			((std::vector<int> &)resp.get_oid()).back() = *k;
		}
	} else {
		k = std::find(columns.begin(), columns.end(), *reqoid.begin());
	}
	
	if (k == columns.end())
		return false;

	get_value(*k, resp.get_value());

	return true;
}

bool mib_table::handle_get(set_get_msg &msg, const asn::oid &reqbase, bool next, const asn::oid &req, varbind &resp) const {
	const std::vector<int> &_reqoid = reqbase;
	std::deque<int> reqoid = std::deque<int>(_reqoid.begin(), _reqoid.end());

	if (columns.empty() || indexes.empty())
		return false;

	std::set<int>::const_iterator col;
	index ndx;

	if (next) {
		int plen = reqoid.size();

		if (reqoid.empty()) {
			col = columns.begin();
		} else {
			col = std::find(columns.begin(), columns.end(), *reqoid.begin());
			if (col == columns.end())
				return false;
			reqoid.pop_front();
		}

		if (!parse_index(reqoid, ndx))
			return false;

		if (ndx.size() != indexes.size()) {
			if (!first_row(ndx)) {
				return false;
			}
		} else {
			if (!next_row(ndx)) {
				ndx.clear();
				if (!first_row(ndx))
					return false;
				col++;
				if (col == columns.end()) {
			//		msg.get_error_status() = set_get_msg::err_no_such_name;
			//		msg.get_error_index() = *reqoid.begin();
			//		return true;
					return false;
				}
			}
		}

		std::vector<int> &newoid = resp.get_oid();

		while (plen--)
			newoid.pop_back();

		newoid.push_back(*col);

		index::iterator j = ndx.begin();
		while (j != ndx.end()) {
			any &tok = *j;
			j++;
			if (!tok->encode_index(newoid, j != ndx.end()))
				return false;
		}
	} else {
		col = std::find(columns.begin(), columns.end(), reqoid[0]);
		reqoid.pop_front();

		if (!parse_index(reqoid, ndx))
			return false;
	}

	if (col == columns.end()) {
		return false;
	}

	get_value(ndx, *col, resp.get_value());

	return true;
}

bool mib_table::parse_index(std::deque<int> &reqoid, index &ndx) const {
	size_t i = 0;

	while (!reqoid.empty() && i < indexes.size()) {
		ndx.push_back(any());
		any &tok = ndx.back();
		if (!tok.instantiate(indexes[i]))
			return false;
		i++;
		if (!tok->decode_index(reqoid, i != indexes.size()))
			return false;
	}

	return reqoid.empty();
}

bool reg_agent::register_mib(const asn::oid &id, mib_handler *handler) {
	const std::vector<int> &oidv = id;
	treenode *node = &snmp_root;

	if (oidv.size() < 2)
		return false;

	if (oidv[0] != 1 || oidv[1] != 3)
		return false;

	if (!agent::register_mib(id))
		return false;

	for (std::vector<int>::const_iterator i = oidv.begin() + 2; i != oidv.end(); i++) {
		std::map<int, treenode *>::iterator k = node->childs.find(*i);
		if (k == node->childs.end()) {
			treenode *newnode = new treenode();
			if (!newnode)
				return false;
			newnode->handler = 0;
			node->childs[*i] = newnode;
			node = newnode;
		} else {
			node = k->second;
		}
	}

	if (!node || node->handler)
		return false;

	node->handler = handler;

	return true;
}

mib_handler *reg_agent::match_handler(const asn::oid &reqoid, asn::oid &rest) const {
	const std::vector<int> &oidv = reqoid;

	const treenode *node = &snmp_root;
	mib_handler *handler = 0;

	std::vector<int> &curroid = rest;
	std::vector<int>::const_iterator i = oidv.begin() + 2;

	for (; i != oidv.end(); i++) {
		std::map<int, treenode *>::const_iterator k = node->childs.find(*i);
		if (k != node->childs.end()) {
			curroid.push_back(*i);

			node = k->second;
			if (node->handler) {
				curroid.clear();
				handler = node->handler;
			}
		} else {
			break;
		}
	}

	for (; i != oidv.end(); i++) {
		curroid.push_back(*i);
	}

	return handler;
}

void reg_agent::handle_get(set_get_msg &msg, bool next, const varbind &req, varbind &resp) const {
	asn::oid curr;

	mib_handler *handler = match_handler(req.get_oid(), curr);

	if (!handler || !handler->handle_get(msg, curr, next, req.get_oid(), resp))
		agent::handle_get(msg, next, req, resp);
}

int reg_agent::handle_bulk_get(set_get_msg &msg, const varbind &req, int max) const {
	asn::oid curr;

	asn::oid curr_req = req.get_oid();

	int i;

	for (i = 0; i < max; i++) {
		varbind resp(curr_req);

		((std::vector<int> &)curr).clear();

		mib_handler *handler = match_handler(curr_req, curr);

		if (!handler || !handler->handle_get(msg, curr, true, curr_req, resp)) {
			break;
		}

		msg.get_varbinds().push_back(resp);
		
		curr_req = resp.get_oid();
	}

	return i;
}

asn::object *pdu::instantiate(int type) const {
	switch (type) {
	case 0x60:
		return new smux_simple_open_pdu();
	case 0x41:
		return new smux_close_pdu();
	case 0x62:
		return new smux_rreq_pdu();
	case 0x43:
		return new smux_rrsp_pdu();
	case 0x44:
		return new smux_sout_pdu();
	case 0xa0:
	case 0xa1:
	case 0xa2:
	case 0xa3:
	case 0xa5:
		return new set_get_msg(type);
	default:
		return asn::choice::instantiate(type);
	}
}

message::message() {
	version = 1;
}

int message::get_length() const {
	return version.get_object_length()
		+ community.get_object_length()
		+ innerpdu.get_object_length();
}

bool message::encode(asn::encoding_buffer &b) const {
	if (!asn::object::encode(b))
		return false;
	//if (!asn_sequence::encode(b))
	//	return false;
	if (!version.encode(b))
		return false;
	if (!community.encode(b))
		return false;
	return innerpdu.encode(b);
}

bool message::decode_content(asn::encoding_buffer &b, int len) {
	//if (!asn_sequence::decode_content(b, len))
	//	return false;
	if (!version.decode(b))
		return false;
	if (!community.decode(b))
		return false;
	return innerpdu.decode(b);
}

smux_simple_open_pdu::smux_simple_open_pdu()
	: asn::sequence(0x60), version(0) {
}

int smux_simple_open_pdu::get_length() const {
	return version.get_object_length() + identity.get_object_length()
		+ description.get_object_length() + password.get_object_length();
}

bool smux_simple_open_pdu::encode(asn::encoding_buffer &buff) const {
	return asn::object::encode(buff) &&
		version.encode(buff) &&
		identity.encode(buff) &&
		description.encode(buff) &&
		password.encode(buff);
}

bool smux_simple_open_pdu::decode_content(asn::encoding_buffer &buff, int len) {
	return version.decode(buff) &&
		identity.decode(buff) &&
		description.decode(buff) &&
		password.decode(buff);
}

smux_close_pdu::smux_close_pdu()
	: asn::integer(0x41) {}

smux_rreq_pdu::smux_rreq_pdu()
	: asn::sequence(0x62) {}

int smux_rreq_pdu::get_length() const {
	return subtree.get_object_length() + priority.get_object_length() + operation.get_object_length();
}

bool smux_rreq_pdu::encode(asn::encoding_buffer &buff) const {
	return asn::object::encode(buff) && subtree.encode(buff) && priority.encode(buff) && operation.encode(buff);
}

bool smux_rreq_pdu::decode_content(asn::encoding_buffer &buff, int len) {
	return subtree.decode(buff) && priority.decode(buff) && operation.decode(buff);
}

smux_rrsp_pdu::smux_rrsp_pdu()
	: asn::integer(0x43) {}

smux_sout_pdu::smux_sout_pdu()
	: asn::integer(0x44) {}

asn::object *any::instantiate(int type) const {
	switch (type) {
	case 0x80:
		return new nosuchobj();
	default:
		return asn::any::instantiate(type);
	}
}

varbind::varbind()
	: asn::sequence() {
}

varbind::varbind(const asn::oid &baseoid)
	: varoid(baseoid) {
}

varbind::varbind(const varbind &base)
	: varoid(base.varoid) {

	value.set_to(base.value->clone());
}

varbind &varbind::operator =(const varbind &base) {
	varoid = base.varoid;

	value.set_to(base.value->clone());

	return *this;
}

int varbind::get_length() const {
	return varoid.get_object_length() + value.get_object_length();
}

bool varbind::encode(asn::encoding_buffer &b) const {
	if (!asn::object::encode(b))
		return false;
	if (!varoid.encode(b))
		return false;
	return value.encode(b);
}

bool varbind::decode_content(asn::encoding_buffer &b, int len) {
	if (!varoid.decode(b))
		return false;

	if (!value.decode(b))
		return false;

	return true;
}

set_get_msg::set_get_msg(uint8_t type)
	: asn::sequence(type) {
	error_status = 0;
	error_index = 0;
}

int set_get_msg::get_length() const {
	return reqid.get_object_length() 
		+ error_status.get_object_length()
		+ error_index.get_object_length()
		+ varbinds.get_object_length();
}

bool set_get_msg::encode(asn::encoding_buffer &b) const {
	if (!asn::object::encode(b))
		return false;

	if (!reqid.encode(b))
		return false;

	if (!error_status.encode(b))
		return false;

	if (!error_index.encode(b))
		return false;

	return varbinds.encode(b);
}

bool set_get_msg::decode_content(asn::encoding_buffer &b, int len) {
	//if (!asn_sequence::decode_content(b, len))
	//	return false;

	if (!reqid.decode(b))
		return false;

	if (!error_status.decode(b))
		return false;
	if (!error_index.decode(b))
		return false;

	if (!varbinds.decode(b))
		return false;

	return true;
}

} // namespace snmp

