/*
 * Multicast Routing Daemon (MRD)
 *   snmp.h
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

#ifndef _snmp_h_
#define _snmp_h_

#include "asn1.h"

#include <sys/socket.h>
#include <sys/types.h>

#include <map>
#include <set>
#include <stack>

#include <snmp/snmp_primitives.h>

namespace snmp {

class agent {
public:
	agent();
	virtual ~agent();

	virtual bool check_startup();
	virtual void shutdown();

	void data_available();

protected:
	virtual void closed(int reason);

	virtual void registration_result(const asn::oid &, int res);
	
	bool register_mib(const asn::oid &);

	void handle_get(bool next, const set_get_msg &);
	void handle_bulk_get(const set_get_msg &);
	virtual void handle_get(set_get_msg &, bool next, const varbind &, varbind &) const;
	virtual int handle_bulk_get(set_get_msg &, const varbind &, int) const;

	int sock;

	std::stack<asn::oid> register_stack;
};

class mib_handler {
public:
	virtual ~mib_handler() {}

	virtual bool handle_get(set_get_msg &msg, const asn::oid &base, bool next, const asn::oid &, varbind &) const = 0;
};

class mib_static_table : public mib_handler {
public:
	any &operator [] (int index) { return values[index]; }

	bool handle_get(set_get_msg &, const asn::oid &reqoid, bool next, const asn::oid &, varbind &) const;
private:
	std::map<int, any> values;
};

class mib_single_table : public mib_handler {
public:

protected:
	bool handle_get(set_get_msg &, const asn::oid &reqoid, bool next, const asn::oid &, varbind &) const;
	virtual void get_value(int, any &) const = 0;

	std::set<int> columns;
};

class mib_table : public mib_handler {
public:

protected:
	bool handle_get(set_get_msg &, const asn::oid &, bool next, const asn::oid &, varbind &) const;

	typedef std::vector<any> index;

	bool parse_index(std::deque<int> &, index &) const;

	virtual void get_value(const index &, int, any &) const = 0;

	virtual bool first_row(index &) const = 0;
	virtual bool next_row(index &) const = 0;

	std::set<int> columns;
	std::vector<int> indexes;
};

class reg_agent : public agent {
public:
	bool register_mib(const asn::oid &, mib_handler *);

protected:
	mib_handler *match_handler(const asn::oid &, asn::oid &) const;

	virtual void handle_get(set_get_msg &, bool next, const varbind &, varbind &) const;
	virtual int handle_bulk_get(set_get_msg &, const varbind &, int) const;

	struct treenode {
		std::map<int, struct treenode *> childs;
		mib_handler *handler;
	};
	treenode snmp_root;
};

} // namespace snmp

#endif

