/*
 * Multicast Routing Daemon (MRD)
 *   snmp_module.cpp
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

#include <mrdpriv/snmp/snmp_module.h>

#include <mrd/interface.h>

class snmp_interface_table : public snmp::mib_table {
public:
	snmp_interface_table();

	bool first_row(index &) const;
	bool next_row(index &) const;

	void get_value(const index &, int, snmp::any &) const;
};

static snmp::mib_static_table mrdinfo;
static snmp_interface_table intftable;

module_entry(snmp, snmp_module);

snmp_module::snmp_module(mrd *m, void *dlh)
	: mrd_module(m, dlh), node(m, "snmp"),
		sock_handle("snmp socket", this, std::mem_fun(&snmp_module::snmp_data_available)) {
}

bool snmp_module::check_startup() {
	if (!snmp::reg_agent::check_startup())
		return false;

	sock_handle.register_fd(sock);

	mrdinfo[1].instantiate_with<asn::octet_string>(std::string("IPv6 Multicast Router"));
	mrdinfo[2].instantiate_with<asn::integer>(1);

	if (!register_mib(asn::oid("1.3.6.1.4.1.23.23.1"), &mrdinfo))
		return false;

	if (!register_mib(asn::oid("1.3.6.1.4.1.23.23.2.1"), &intftable))
		return false;

	g_mrd->add_child(this);

	return true;
}

void snmp_module::snmp_data_available(uint32_t) {
	snmp::agent::data_available();
}

void snmp_module::shutdown() {
	sock_handle.unregister(false);

	snmp::reg_agent::shutdown();
}

void snmp_module::closed(int reason) {
	m_mrd->log().warn() << "(SNMP) closed SMUX connection, reason: " << reason << endl;
	m_mrd->remove_module(this);
}

snmp_interface_table::snmp_interface_table() {
	columns.insert(1);
	columns.insert(2);
	columns.insert(3);

	indexes.push_back(0x2);
}

bool snmp_interface_table::first_row(index &ndx) const {
	if (g_mrd->m_intflist.empty())
		return false;

	if (!ndx.empty())
		return false;

	ndx.push_back(snmp::any());
	return ndx.back().instantiate_with<asn::integer>(g_mrd->m_intflist.begin()->first);
}

bool snmp_interface_table::next_row(index &ndx) const {
	if (ndx.size() != 1 || ndx.back()->get_type() != 0x2)
		return false;

	int index = ndx.back().value<const asn::integer>();

	mrd::interface_list::const_iterator k = g_mrd->m_intflist.find(index);
	if (k == g_mrd->m_intflist.end())
		return false;
	k++;
	if (k == g_mrd->m_intflist.end())
		return false;

	ndx.back().value<asn::integer>() = k->first;

	return true;
}

void snmp_interface_table::get_value(const index &ndx, int col, snmp::any &value) const {
	if (ndx.size() != 1 || ndx.back()->get_type() != 0x2)
		return;

	mrd::interface_list::const_iterator k = g_mrd->m_intflist.find(ndx.back().value<asn::integer>());

	if (k != g_mrd->m_intflist.end()) {
		const interface *intf = k->second;

		switch (col) {
		case 1:
			value.instantiate_with<asn::octet_string>(intf->name());
			break;
		case 2:
			value.instantiate_with<asn::octet_string>(asn::octet_string(&intf->primary_addr(), 16));
			break;
		case 3:
			value.instantiate_with<asn::integer>(intf->conf()->get_property_bool("enable") ? 1 : 2);
			break;
		}
	}
}


