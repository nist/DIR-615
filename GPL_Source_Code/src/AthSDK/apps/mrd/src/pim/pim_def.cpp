/*
 * Multicast Routing Daemon (MRD)
 *   pim_def.cpp
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

#include <mrd/interface.h>
#include <mrd/mrd.h>
#include <mrdpriv/pim/def.h>

void pim_message::construct(pim_msg_type t) {
	vt = 0x20 | t;
	resv1 = 0;
	checksum = 0;
}

const char *pim_message::type_name() const {
	switch (type()) {
	case pim_msg_hello:
		return "HELLO";
	case pim_msg_register:
		return "REGISTER";
	case pim_msg_register_stop:
		return "REGISTER-STOP";
	case pim_msg_joinprune:
		return "JOIN/PRUNE";
	case pim_msg_bootstrap:
		return "BOOTSTRAP";
	case pim_msg_assert:
		return "ASSERT";
	case pim_msg_candidate_rp_adv:
		return "CANDIDATE-RP-ADV";
	default:
		return "UNKNOWN";
	}
}

void pim_message::build_checksum(const in6_addr &src, const in6_addr &dst, int len) {
	checksum = 0;

#if 0
	g_mrd->log().info(15) << "build_checksum debug [type: " << (int)(vt & 0xf)
		<< " src " << src << ", dst " << dst << " ptr: " << this << " len: " << len << "]" << endl;

	base_stream &os = g_mrd->log().info(15);
	uint8_t *ptr = (uint8_t *)this;

	for (int i = 0; i < len; i++) {
		os.printf("%02x ", ptr[i]);
		if ((i % 16) == 15)
			os << endl;
	}

	os << endl;
#endif

	checksum = ipv6_checksum(IPPROTO_PIM, src, dst, this, len);
}

bool pim_message::has_valid_checksum(const in6_addr &src, const in6_addr &dst, int len) {
	uint16_t cksum = checksum;
	checksum = 0;

	uint16_t calc = ipv6_checksum(IPPROTO_PIM, src, dst, this, len);

	checksum = cksum;

	return checksum == calc;
}

void _debug_pim_dump(base_stream &os, const pim_joinprune_message &msg) {
	os << "PIM J/P for " << msg.upstream_neigh.addr
	   << " with holdtime " << ntohs(msg.holdtime) << endl;

	int i, j;
	pim_joinprune_group *grp = msg.groups();

	os.inc_level();

	for (i = 0; i < msg.ngroups; i++, grp = grp->next()) {
		os << inet6_addr(grp->maddr.addr, grp->maddr.masklen) << endl;

		os.inc_level();

		pim_encoded_source_address *addr = grp->addrs();

		for (j = 0; j < ntohs(grp->njoins); j++, addr++) {
			os << "Join: " << inet6_addr(addr->addr, addr->masklen);
			if (addr->rpt())
				os << " RPT";
			if (addr->wc())
				os << " WC";
			os << endl;
		}

		for (j = 0; j < ntohs(grp->nprunes); j++, addr++) {
			os << "Prune: " << inet6_addr(addr->addr, addr->masklen);
			if (addr->rpt())
				os << " RPT";
			if (addr->wc())
				os << " WC";
			os << endl;
		}

		os.dec_level();
	}

	os.dec_level();
}

void _debug_pim_dump(base_stream &os, const pim_assert_message &msg) {
	os << "PIM Assert for (" << msg.saddr.addr << ", " << msg.gaddr.addr
	   << ")" << ((ntohl(msg.metric_pref) & 0x80000000) ? " RPT" : "")
	   << " Pref " << (ntohl(msg.metric_pref) & 0x7fffffff)
	   << " Metric " << ntohl(msg.metric) << endl;
}

