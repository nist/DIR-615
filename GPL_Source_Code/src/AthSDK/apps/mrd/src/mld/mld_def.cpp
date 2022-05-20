/*
 * Multicast Routing Daemon (MRD)
 *   mld_def.cpp
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
#include <mrd/node.h>
#include <mrdpriv/mld/def.h>
#include <mrdpriv/mld/router.h>

void mldv1::construct(const in6_addr *addr, int _type, mld_intfconf_node *n) {
	memset(this, 0, sizeof(icmp6_hdr));

	icmp6_type = _type;

	/* General Query
	 *   max_response_delay = [Query Response Interval]
	 * Multicast-Address-Specific Query
	 *   max_response_delay = [Last Listener Query Interval] */

	if (IN6_IS_ADDR_UNSPECIFIED(addr))
		icmp6_maxdelay = htons(n->query_response_interval());
	else
		icmp6_maxdelay = htons(n->last_listener_query_interval());

	mcaddr = *addr;
}

void mldv2_query::construct(const in6_addr *addr, int type, mld_intfconf_node *n) {
	mldv1::construct(addr, type, n);

	qrv = n->robustness();
	suppress = 0;
	resv2 = 0;

	uint32_t qis = n->query_interval() / 1000;

	if (qis < 128)
		qqic = qis;
	else {
		int exp = 0;

		while ((qis >> (exp+3)) > 0x1f)
			exp++;

		qis >>= exp+3;
		qis -= 0x10;

		qqic = 0x80 | (exp << 4) | qis;
	}

	nsrcs = 0;
}

