/*
 * Multicast Routing Daemon (MRD)
 *   icmp.cpp
 *
 * Copyright (C) 2004, 2005
 *  Universidade de Aveiro, Instituto Telecomunicacoes - Polo Aveiro
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

#include <mrd/mrd.h>
#include <mrd/icmp.h>
#include <mrd/rib.h>

bool icmp_base::register_handler(int type, icmp_handler *h) {
	handlers::iterator i = m_handlers.find(type);

	if (!h) {
		if (i != m_handlers.end())
			m_handlers.erase(i);
		else
			return false;
	} else {
		if (i != m_handlers.end())
			return false;

		m_handlers[type] = h;
	}

	registration_changed();

	return true;
}

void icmp_base::registration_changed() {
}

bool icmp_base::send_icmp(const in6_addr &dst, icmp6_hdr *hdr, uint16_t len) const {
	g_mrd->log().info(NORMAL) << "icmp_base::send_icmp before 4 entry\n";
	interface *intf = g_mrd->rib().path_towards(dst);
	if (!intf)
		return false;
	g_mrd->log().info(NORMAL) << "icmp_base::send_icmp after 4 return\n";
	return send_icmp(intf, dst, hdr, len);
}

bool icmp_base::send_icmp(const interface *intf, const in6_addr &dst,
			  icmp6_hdr *hdr, uint16_t len) const {
	g_mrd->log().info(NORMAL) << "icmp_base::send_icmp 5 entry\n";
	if (IN6_IS_ADDR_LINKLOCAL(&dst) || IN6_IS_ADDR_MC_LINKLOCAL(&dst)){
		g_mrd->log().info(NORMAL) << "icmp_base::send_icmp 5 if entry\n";
		return send_icmp(intf, *intf->linklocal(), dst, hdr, len);
	}else {
		g_mrd->log().info(NORMAL) << "icmp_base::send_icmp 5 else entry\n";
		if (intf->globals().empty()) {
			g_mrd->log().info(NORMAL) << "icmp_base::send_icmp 5 [ICMPv6] Failed to send "
				<< " ICMPv6 message to " << dst
				<< ", no global address" << endl;
			return false;
		}
		g_mrd->log().info(NORMAL) << "icmp_base::send_icmp 5 return\n";
		return send_icmp(intf, *intf->globals().begin(), dst, hdr, len);
	}
}

void icmp_base::icmp_message_available(interface *intf, const in6_addr &src,
				       const in6_addr &dst, icmp6_hdr *hdr,
				       int len) {
	handlers::iterator i = m_handlers.find((int)hdr->icmp6_type);
	if (i != m_handlers.end()) {
		i->second->icmp_message_available(intf, src, dst, hdr, len);
	} else {
		g_mrd->log().info(NORMAL) << "[ICMPv6] No handler for type "
			<< (int)hdr->icmp6_type << endl;
	}
}

void icmp_base::require_mgroup(const in6_addr &mgroup, bool include) {
	mgroups::iterator i = m_mgroups.find(mgroup);

	if (include) {
		if (i == m_mgroups.end()) {
			m_mgroups[mgroup] = 1;
			internal_require_mgroup(mgroup, true);
		} else {
			i->second ++;
		}
	} else {
		if (i != m_mgroups.end()) {
			i->second --;
			if (i->second == 0) {
				m_mgroups.erase(i);
				internal_require_mgroup(mgroup, false);
			}
		}
	}
}

