/*
 * Multicast Routing Daemon (MRD)
 *   bsd_mfa.cpp
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

#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <mrd/address.h>
#include <mrd/interface.h>
#include <mrd/mrd.h>
#include <mrd/router.h>
#include <mrdpriv/bsd/mfa.h>
#include <net/bpf.h>
#include <net/if.h>
#include <netinet/icmp6.h>
#include <netinet/ip6.h>
#ifdef __FreeBSD__
#include <net/if_var.h>
#else
#include <net/route.h>
#endif
#include <netinet6/ip6_mroute.h>
#include <netinet6/in6_var.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>

#ifdef _NETBSD_SOURCE
#include <net/if_ether.h>
#else
#include <net/ethernet.h>
#endif

bsd_mfa_group_source::bsd_mfa_group_source(bsd_mfa_group *grp, const in6_addr &addr,
						uint32_t flags, action *acts)
	: m_owner(grp), m_addr(addr) {

	instowner = 0;

	m_flags = flags;

	m_interest_flags = 0;

	for (int i = 0; i < event_count; i++)
		change_flags(1 << i, acts[i]);

	m_iif = 0;

	memset(&m_bsd_state, 0, sizeof(m_bsd_state));

	m_bsd_state.mf6cc_origin = m_addr.as_sockaddr();
	m_bsd_state.mf6cc_mcastgrp = m_owner->addr().as_sockaddr();
}

bsd_mfa_group_source::~bsd_mfa_group_source() {
	((bsd_mfa *)g_mrd->mfa())->commit(&m_bsd_state, true);
}

void bsd_mfa_group_source::get_input_counter(uint64_t &val) const {
	((bsd_mfa *)g_mrd->mfa())->get_input_counter(this, val);
}

void bsd_mfa_group_source::get_forwarding_counter(uint64_t &val) const {
	((bsd_mfa *)g_mrd->mfa())->get_forwarding_counter(this, val);
}

void bsd_mfa_group_source::set_iif(interface *iif) {
	m_iif = iif;

	m_bsd_state.mf6cc_parent = iif ? ((bsd_mfa *)g_mrd->mfa())->vif(iif) : 0;

	((bsd_mfa *)g_mrd->mfa())->commit(&m_bsd_state);
}

void bsd_mfa_group_source::release_iif(interface *iif) {
	if (m_iif == iif) {
		set_iif(0);
	}
}

void bsd_mfa_group_source::add_oif(interface *oif) {
	int vif = ((bsd_mfa *)g_mrd->mfa())->vif(oif);

	if (vif < 0)
		return;

	if (!has_oif(oif)) {
		m_oifs.push_back(oif);
	}

	IF_SET(vif, &m_bsd_state.mf6cc_ifset);

	((bsd_mfa *)g_mrd->mfa())->commit(&m_bsd_state);
}

void bsd_mfa_group_source::release_oif(interface *oif) {
	for (oifs::iterator k = m_oifs.begin(); k != m_oifs.end(); ++k) {
		if (*k == oif) {
			m_oifs.erase(k);

			int vif = ((bsd_mfa *)g_mrd->mfa())->vif(oif);

			if (vif >= 0) {
				IF_CLR(vif, &m_bsd_state.mf6cc_ifset);
				((bsd_mfa *)g_mrd->mfa())->commit(&m_bsd_state);
			}

			return;
		}
	}
}

void bsd_mfa_group_source::change_flags(uint32_t flags, action act) {
	if (act == no_action) {
		m_interest_flags &= ~flags;
	} else {
		m_interest_flags |= flags;
	}
}

static void output(base_stream &out, const std::vector<interface *> &ifs) {
	out << "{ ";
	for (std::vector<interface *>::const_iterator i = ifs.begin();
						i != ifs.end(); ++i) {
		if (i != ifs.begin())
			out << ", ";
		out << (*i)->name();
	}
	out << " }";
}

void bsd_mfa_group_source::output_info(base_stream &out) const {
	base_stream &osi = out << "Iif: ";
	if (m_iif)
		osi << m_iif->name();
	else
		osi << "(None)";
	osi << endl;
	base_stream &oso = out << "Oifs: ";
	output(oso, m_oifs);
	oso << endl;
}

bsd_mfa_group::bsd_mfa_group(router *owner, const inet6_addr &id)
	: mfa_group(owner), m_addr(id) {
	instowner = 0;

	bsd_mfa *m = (bsd_mfa *)g_mrd->mfa();

	m_flags = m->m_grpflags;
	for (int i = 0; i < mfa_group_source::event_count; i++)
		m_actions[i] = m->m_grpactions[i];

	m_state = pending;
}

void bsd_mfa_group::activate(bool accept) {
	if (accept && m_state == running)
		return;

	if (!accept) {
		m_state = denied;
	} else {
		m_state = running;
	}

	if (!accept) {
		((bsd_mfa *)g_mrd->mfa())->release_group(this);
	}
}

mfa_group_source *bsd_mfa_group::create_source_state(const in6_addr &addr, void *instowner) {
	mfa_group_source *src = get_source_state(addr);

	if (!src) {
		src = new bsd_mfa_group_source(this, addr, m_flags, m_actions);
		if (src) {
			g_mrd->log().info(NORMAL) << "BSD-MFA: created source state for "
						<< addr << endl;
			m_sources[addr] = (bsd_mfa_group_source *)src;
		}
	}

	if (src)
		src->instowner = instowner;

	return src;
}

mfa_group_source *bsd_mfa_group::get_source_state(const in6_addr &addr) const {
	return match_source(addr);
}

void bsd_mfa_group::release_source_state(mfa_group_source *_src) {
	bsd_mfa_group_source *src = (bsd_mfa_group_source *)_src;

	for (sources::iterator i = m_sources.begin();
					i != m_sources.end(); ++i) {
		if (src == i->second) {
			delete src;
			m_sources.erase(i);

			return;
		}
	}
}

void bsd_mfa_group::change_default_flags(uint32_t flags,
					mfa_group_source::action act) {
	for (int i = mfa_group_source::any_incoming;
			i < mfa_group_source::event_count; i++) {
		if (flags & (1 << i))
			m_actions[i] = act;
	}
}

void bsd_mfa_group::output_info(base_stream &out) const {
	for (sources::const_iterator i = m_sources.begin();
					i != m_sources.end(); ++i) {
		out << i->first << endl;
		out.inc_level();
		i->second->output_info(out);
		out.dec_level();
	}
}

void bsd_mfa::change_group_default_flags(uint32_t flags,
					mfa_group_source::action act) {
	for (int i = mfa_group_source::any_incoming;
			i < mfa_group_source::event_count; i++) {
		if (flags & (1 << i))
			m_grpactions[i] = act;
	}
}

mfa_group *bsd_mfa::create_group(router *r, const inet6_addr &id, void *instowner) {
	mfa_group *grp = get_group(id);

	if (!grp) {
		grp = new bsd_mfa_group(r, id);
		if (grp) {
			g_mrd->log().info(NORMAL) << "BSD-MFA: created state for group "
							<< id << endl;
			m_groups[id] = (bsd_mfa_group *)grp;
		}
	}

	if (grp)
		grp->instowner = instowner;

	return grp;
}

mfa_group *bsd_mfa::get_group(const inet6_addr &id) const {
	groups::const_iterator k = m_groups.find(id);

	if (k == m_groups.end())
		return 0;

	return k->second;
}

void bsd_mfa::release_group(mfa_group *grp) {
	for (groups::iterator i = m_groups.begin(); i != m_groups.end(); ++i) {
		if (grp == i->second) {
			delete i->second;

			m_groups.erase(i);

			return;
		}
	}
}

bsd_mfa::bsd_mfa()
	: m_sock("kernel sock", this, std::mem_fun(&bsd_mfa::kernel_data_pending)) {
	m_icmpsock = -1;
	m_grpflags = 0;
	for (int i = 0; i < mfa_group_source::event_count; i++)
		m_grpactions[i] = mfa_group_source::no_action;
}

bool bsd_mfa::pre_startup() {
	if (!mfa_core::pre_startup())
		return false;

	if (!data_plane_sourcedisc.check_startup())
		return false;

	m_icmpsock = socket(PF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
	if (m_icmpsock < 0) {
		g_mrd->log().warn() << "(MFA) Failed to create ICMPv6 socket: " << strerror(errno) << endl;
		return false;
	}

	int vers = 1;

	if (setsockopt(m_icmpsock, IPPROTO_IPV6, MRT6_INIT, &vers, sizeof(vers)) < 0) {
		g_mrd->log().warn() << "BSD-MFA: MRD6_INIT Failed: " << strerror(errno) << endl;
	} else {
		g_mrd->log().info(NORMAL) << "BSD-MFA: MRD6_INIT" << endl;
	}

#if 0
	if (setsockopt(m_icmpsock, IPPROTO_IPV6, MRT6_PIM, &vers, sizeof(vers)) < 0) {
		g_mrd->log().info(NORMAL) << "BSD-MFA: MRD6_PIM Failed: " << strerror(errno) << endl;
	}
#endif

	m_sock.register_fd(m_icmpsock);

	return g_mrd->register_source_discovery("data-plane",
						&data_plane_sourcedisc);
}

bool bsd_mfa::check_startup() {
	return true;
}

void bsd_mfa::shutdown() {
	setsockopt(m_icmpsock, IPPROTO_IPV6, MRT6_DONE, 0, 0);

	if (m_icmpsock > 0) {
		close(m_icmpsock);
	}

	g_mrd->register_source_discovery("data-plane", 0);
}

void bsd_mfa::forward(interface *intf, ip6_hdr *hdr, uint16_t len) const {
	g_mrd->log().warn() << "BSD-MFA: Failed to dispatch" << endl;
}

void bsd_mfa::send_icmpv6_toobig(interface *intf, ip6_hdr *hdr, uint16_t len) {
	const in6_addr *src = &hdr->ip6_src;
	const in6_addr *dst = &hdr->ip6_dst;

	if (m_icmpsock < 0) {
		g_mrd->log().info(NORMAL) << "Packet too big from " << *src
			<< " to " << *dst << ", dropping." << endl;
		return;
	}

	if (IN6_IS_ADDR_UNSPECIFIED(src) || IN6_IS_ADDR_MULTICAST(src))
		return;

	sockaddr_in6 dstaddr;
	memset(&dstaddr, 0, sizeof(dstaddr));
	dstaddr.sin6_family = AF_INET6;
	dstaddr.sin6_addr = *src;

	uint8_t buffer[1280];

	icmp6_hdr *icmphdr = (icmp6_hdr *)buffer;
	icmphdr->icmp6_type = ICMP6_PACKET_TOO_BIG;
	icmphdr->icmp6_code = 0;
	icmphdr->icmp6_cksum = 0;
	icmphdr->icmp6_mtu = htonl(intf->mtu());

	int howmuch = len > (1280 - sizeof(ip6_hdr) - sizeof(icmp6_hdr)) ?
			(1280 - sizeof(ip6_hdr) - sizeof(icmp6_hdr)) : len;

	memcpy(buffer + sizeof(icmp6_hdr), hdr, howmuch);

	sendto(m_icmpsock, buffer, howmuch + sizeof(icmphdr), 0,
			(const sockaddr *)&dstaddr, sizeof(dstaddr));
}

bool bsd_mfa::output_info(base_stream &out, const std::vector<std::string> &args) const {
	for (groups::const_iterator i = m_groups.begin();
				i != m_groups.end(); ++i) {
		out << i->first << endl;
		out.inc_level();
		i->second->output_info(out);
		out.dec_level();
	}

	return true;
}

void bsd_mfa::added_interface(interface *intf) {
	for (int vif = 1; vif < MAXMIFS; vif++) {
		if (rev_vifs.find(vif) == rev_vifs.end()) {
			mif6ctl mc;
			mc.mif6c_mifi = vif;
			mc.mif6c_flags = 0;
			mc.mif6c_pifi = intf->index();

			if (setsockopt(m_icmpsock, IPPROTO_IPV6, MRT6_ADD_MIF, &mc, sizeof(mc)) < 0) {
				g_mrd->log().warn() << "BSD-MFA: failed to MRT6_ADD_MIF: "
						<< strerror(errno) << endl;
			} else {
				vifs[intf] = vif;
				rev_vifs[vif] = intf;

				g_mrd->log().info(NORMAL) << "BSD-MFA: Added interface "
					<< intf->name() << " with vif " << vif << endl;
			}

			return;
		}
	}

	g_mrd->log().warn() << "BSD-MFA: failed to MRT6_ADD_MIF: No available MIFs" << endl;
}

void bsd_mfa::removed_interface(interface *intf) {
	g_mrd->log().info(NORMAL) << "BSD-MFA: removed interface " << intf->name() << endl;

	std::map<interface *, int>::iterator i = vifs.find(intf);
	if (i != vifs.end()) {
		uint16_t index = i->second;

		vifs.erase(i);

		rev_vifs.erase(rev_vifs.find(index));

		setsockopt(m_icmpsock, IPPROTO_IPV6, MRT6_DEL_MIF, &index, sizeof(index));
	}
}

int bsd_mfa::vif(interface *iif) const {
	std::map<interface *, int>::const_iterator i = vifs.find(iif);
	if (i != vifs.end())
		return i->second;
	return -1;
}

void bsd_mfa::commit(mf6cctl *msg, bool remove) {
	if (IN6_IS_ADDR_UNSPECIFIED(&msg->mf6cc_origin.sin6_addr))
		return;

	g_mrd->log().info(NORMAL) << "BSD-MFA: commit MFC" << endl;
	g_mrd->log().info(NORMAL) << " src: " << msg->mf6cc_origin.sin6_addr << endl;
	g_mrd->log().info(NORMAL) << " dst: " << msg->mf6cc_mcastgrp.sin6_addr << endl;

	if (setsockopt(m_icmpsock, IPPROTO_IPV6,
		       remove ? MRT6_DEL_MFC : MRT6_ADD_MFC,
		       msg, sizeof(*msg)) < 0) {
		g_mrd->log().info(NORMAL) << "Failed: " << strerror(errno) << endl;
	}
}

static uint8_t buf[2048];

void bsd_mfa::kernel_data_pending(uint32_t) {
	g_mrd->log().info(NORMAL) << "bsd_mfa::kernel_data_pending entry\n";
	sockaddr_in6 from;
	socklen_t slen = sizeof(from);

	int len = recvfrom(m_icmpsock, buf, sizeof(buf), 0, (sockaddr *)&from, &slen);

	if (len > 0) {
		icmp6_hdr *hdr = (icmp6_hdr *)buf;

		if (hdr->icmp6_type == 0) {
			mrt6msg *msg = (mrt6msg *)hdr;

			std::map<int, interface *>::const_iterator i = rev_vifs.find(msg->im6_mif);
			if (i == rev_vifs.end()) {
				return;
			}

			if (msg->im6_msgtype == MRT6MSG_NOCACHE) {

#if 1
				g_mrd->log().info(NORMAL) << "Cache miss mif "
					<< i->second->name() << " src " << msg->im6_src
					<< " dst " << msg->im6_dst << endl;
#endif

				discovered_source(i->second->index(), msg->im6_dst, msg->im6_src);
			} else if (msg->im6_msgtype == MRT6MSG_WRONGMIF) {
				bsd_mfa_group *grp = (bsd_mfa_group *)get_group(msg->im6_dst);
				if (grp) {
					grp->owner()->mfa_notify(
							grp->get_source_state(msg->im6_src),
							msg->im6_dst, msg->im6_src,
							mfa_group_source::f_wrong_iif,
							mfa_group_source::notify_no_copy,
							i->second, 0, 0, 0);
				}
			} else if (msg->im6_msgtype == MRT6MSG_WHOLEPKT) {
				/* we don't use BSD PIM tunnels */
			}
		}
	}
	g_mrd->log().info(NORMAL) << "bsd_mfa::kernel_data_pending exit\n";
}

void bsd_mfa::discovered_source(int ifindex, const inet6_addr &grp,
				const inet6_addr &src) {
	g_mrd->log().info(NORMAL) << "bsd_mfa::discovered_source entry\n";
	data_plane_sourcedisc.discovered_source(ifindex, grp, src);
	g_mrd->log().info(NORMAL) << "bsd_mfa::discovered_source exit\n";
}

void bsd_mfa::get_source_counters(const bsd_mfa_group_source *src, sioc_sg_req6 *r) {
	r->src = src->m_addr.as_sockaddr();
	r->grp = src->m_owner->addr().as_sockaddr();

	if (ioctl(m_icmpsock, SIOCGETSGCNT_IN6, r) < 0) {
		r->pktcnt = 0;
		r->bytecnt = 0;
		r->wrong_if = 0;
	}
}

void bsd_mfa::get_input_counter(const bsd_mfa_group_source *src, uint64_t &val) {
	sioc_sg_req6 r;

	get_source_counters(src, &r);

	val = r.bytecnt;
}

void bsd_mfa::get_forwarding_counter(const bsd_mfa_group_source *src, uint64_t &val) {
	sioc_sg_req6 r;

	get_source_counters(src, &r);

	val = r.bytecnt - r.wrong_if;
}

