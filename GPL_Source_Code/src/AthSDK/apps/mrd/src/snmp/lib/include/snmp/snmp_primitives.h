/*
 * Multicast Routing Daemon (MRD)
 *   snmp_primitives.h
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

#ifndef _snmp_primitives_h_
#define _snmp_primitives_h_

#include "asn1.h"

namespace snmp {

class pdu : public asn::choice {
public:
	bool instantiate(int type) { return asn::choice::instantiate(type); }

private:
	asn::object *instantiate(int) const;
};

class message : public asn::sequence {
public:
	message();

	int get_length() const;
	bool encode(asn::encoding_buffer &) const;

	bool decode_content(asn::encoding_buffer &, int len);

	int get_version() const { return version; }
	asn::octet_string &get_community() { return community; }
	const std::string get_community() const { return community.as_string(); }

	const pdu &get_pdu() const { return innerpdu; }
	pdu &get_pdu() { return innerpdu; }
	
private:
	asn::integer version;
	asn::octet_string community;
	pdu innerpdu;
};

class smux_simple_open_pdu : public asn::sequence {
public:
	smux_simple_open_pdu();

	int get_length() const;
	bool encode(asn::encoding_buffer &) const;
	bool decode_content(asn::encoding_buffer &, int len);

	asn::integer version;
	asn::oid identity;
	asn::octet_string description;
	asn::octet_string password;
};

class smux_close_pdu : public asn::integer {
public:
	smux_close_pdu();
};

class smux_rreq_pdu : public asn::sequence {
public:
	smux_rreq_pdu();

	int get_length() const;
	bool encode(asn::encoding_buffer &) const;
	bool decode_content(asn::encoding_buffer &, int len);

	asn::oid subtree;
	asn::integer priority;
	asn::integer operation;
};

class smux_rrsp_pdu : public asn::integer {
public:
	smux_rrsp_pdu();
};

class smux_sout_pdu : public asn::integer {
public:
	smux_sout_pdu();
};

class any : public asn::any {
public:
	any() : asn::any() {}
	any(const any &base) : asn::any(base) {}

	bool instantiate(int type) { return asn::any::instantiate(type); }

	template<class T, class V>
	bool instantiate_with(const V &v) {
		return asn::any::instantiate_with<T, V>(v); }

	template<class T> T &value() { return (T &)*contained; }
	template<class T> const T &value() const { return (const T &)*contained; }
	
private:
	asn::object *instantiate(int) const;
};

class varbind : public asn::sequence {
public:
	varbind();
	varbind(const asn::oid &);
	varbind(const varbind &);

	int get_length() const;
	bool encode(asn::encoding_buffer &) const;
	bool decode_content(asn::encoding_buffer &, int len);

	const asn::oid &get_oid() const { return varoid; }
	asn::oid &get_oid() { return varoid; }
	any &get_value() { return value; }

	varbind &operator = (const varbind &);
	
private:
	asn::oid varoid;
	any value;
};

class set_get_msg : public asn::sequence {
public:
	set_get_msg(uint8_t);

	enum {
		err_no_error = 0,
		err_too_big = 1,
		err_no_such_name = 2,
		err_bad_value = 3,
		err_read_only = 4,
		err_gen_err = 5
	};

	int get_length() const;
	bool encode(asn::encoding_buffer &) const;
	bool decode_content(asn::encoding_buffer &, int len);

	int get_request_id() const { return reqid; }
	int &get_request_id() { return reqid; }
	int get_error_status() const { return error_status; }
	int &get_error_status() { return error_status; }
	int get_error_index() const { return error_index; }
	int &get_error_index() { return error_index; }
	const std::vector<varbind> &get_varbinds() const { return varbinds; }
	std::vector<varbind> &get_varbinds() { return varbinds; }

private:
	asn::integer reqid;
	asn::integer error_status;
	asn::integer error_index;
	asn::sequence_of<varbind> varbinds;
};

class nosuchobj : public asn::object {
public:
	nosuchobj() : asn::object(0x80) {}
};

} // namespace snmp

#endif

