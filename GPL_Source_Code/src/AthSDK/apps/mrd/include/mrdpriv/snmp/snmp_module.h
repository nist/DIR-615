/*
 * Multicast Routing Daemon (MRD)
 *   snmp_module.h
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

#ifndef _mrd_snmp_module_h_
#define _mrd_snmp_module_h_

#include <mrd/mrd.h>
#include <mrd/node.h>
#include <snmp/snmp.h>

#include <map>

class snmp_module : public mrd_module, public node, public snmp::reg_agent {
public:
	snmp_module(mrd *m, void *);

	bool check_startup();
	void shutdown();

private:
	void closed(int);

	void snmp_data_available(uint32_t);

	socket0<snmp_module> sock_handle;
};

#endif

