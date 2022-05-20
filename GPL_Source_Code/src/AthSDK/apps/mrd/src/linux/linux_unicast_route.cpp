/*
 * Multicast Routing Daemon (MRD)
 *   linux_unicast_route.cpp
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

#include <mrdpriv/linux/unicast_route.h>

#include <mrd/mrd.h>
#include <mrd/interface.h>

#include <net/if.h>
#include <net/if_arp.h>

#include <unistd.h>

#ifndef ARPHRD_NONE
#define ARPHRD_NONE 0xfffe
#endif

static const char *accept_kernel_routes = "kernel-or-boot-routes";

struct netlink_msg {
	nlmsghdr n;
	rtmsg r;

	void build(int type) {
		memset(this, 0, sizeof(*this));

		n.nlmsg_len = NLMSG_LENGTH(sizeof(rtmsg));
		n.nlmsg_flags = NLM_F_REQUEST;
		n.nlmsg_type = type;

		memset(&r, 0, sizeof(r));
		r.rtm_family = AF_INET6;
	}

	void addattr(uint32_t attr, const void *data, int len) {
		int rlen = RTA_LENGTH(len);
		rtattr *rta = (rtattr *)(((uint8_t *)&n) + NLMSG_ALIGN(n.nlmsg_len));
		rta->rta_type = attr;
		rta->rta_len = rlen;
		memcpy(RTA_DATA(rta), data, len);
		n.nlmsg_len = NLMSG_ALIGN(n.nlmsg_len) + rlen;
	}

	size_t length() const {
		return n.nlmsg_len;
	}

	static void parse_rtatable(rtattr *tb[], int max, rtattr *rta, int len) {
		for (; RTA_OK(rta, len); rta = RTA_NEXT(rta, len)) {
			if (rta->rta_type <= max)
				tb[rta->rta_type] = rta;
		}
	}
};

linux_unicast_router::linux_unicast_router()
	: rt_bcast_sock("linux netlink routing msgs", this,
			 std::mem_fun(&linux_unicast_router::data_available)) {
	rt_sock = -1;
	rt_nlseq = 0;

	bufferlen = instantiate_property_u("netlink-buffer", 0xffff);
	buffer = 0;

	instantiate_property_b(accept_kernel_routes, false);

	rt_dumping = false;
}

linux_unicast_router::~linux_unicast_router() {
	delete [] buffer;
	buffer = 0;
}

bool linux_unicast_router::check_startup() {
	if (!rib_def::check_startup())
		return false;

	if (!bufferlen)
		return false;

	buffer = new uint8_t[bufferlen->get_unsigned()];
	if (!buffer)
		return false;

	rt_sock = socket(PF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	if (rt_sock < 0) {
		g_mrd->log().fatal() << "failed to establish kernel"
			<< " connection for unicast routing" << endl;
		return false;
	}

	int bcast_sock = socket(PF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	if (bcast_sock < 0) {
		close(rt_sock);
		g_mrd->log().fatal() << "failed to establish kernel"
			<< " connection for unicast routing [2]" << endl;
		return false;
	}

	sockaddr_nl localaddr;
	memset(&localaddr, 0, sizeof(localaddr));
	localaddr.nl_family = AF_NETLINK;
	localaddr.nl_groups = ~RTMGRP_TC;

	if (bind(bcast_sock, (sockaddr*)&localaddr, sizeof(localaddr)) < 0) {
		close(rt_sock);
		close(bcast_sock);
		return false;
	}

	rt_bcast_sock.register_fd(bcast_sock);

	return true;
}

struct interface_desc {
	int index;
	std::string name;
	int mtu, flags, type;
	bool up;
};

static std::vector<interface_desc> _interfaces;

static int _conv_intf(int type, int flags) {
	switch (type) {
	case ARPHRD_LOOPBACK:
		return interface::Loopback;
	case ARPHRD_ETHER:
	case ARPHRD_EETHER:
		return interface::Ethernet;
	case ARPHRD_PPP:
		return interface::PPP;
#ifdef ARPHRD_IEEE1394
	case ARPHRD_IEEE1394:
		return interface::IEEE1394;
#endif
	case ARPHRD_TUNNEL:
	case ARPHRD_TUNNEL6:
	case ARPHRD_SIT:
	case ARPHRD_IPGRE:
		return interface::Tunnel;
	case ARPHRD_IEEE80211:
		return interface::IEEE802_11;
	case ARPHRD_NONE:
		if (flags & IFF_POINTOPOINT)
			return interface::TUN;
	default:
		return interface::None;
	}
}

static void _install_interface(const interface_desc &d) {
	bool had = (g_mrd->get_interface_by_index(d.index) != 0);

	interface *intf =
		g_mrd->found_interface(d.index, d.name.c_str(),
				       d.type, d.mtu, d.flags);

	if (intf) {
		if (!had) {
			((linux_unicast_router &)g_mrd->rib()).do_dump(RTM_GETADDR);
		}

		intf->change_state(d.up ? interface::Up : interface::Down);
	}
}

void linux_unicast_router::check_initial_interfaces() {
	do_dump(RTM_GETLINK);

	for (std::vector<interface_desc>::const_iterator i = _interfaces.begin();
			i != _interfaces.end(); ++i) {
		_install_interface(*i);
	}

	_interfaces.clear();

	do_dump(RTM_GETROUTE);

	update_all();
}

void linux_unicast_router::do_dump(int id) {
	rt_dumping = true;

	dump_request(id);

	while (process_message() > 0);

	rt_dumping = false;
}

void linux_unicast_router::dump_request(int type) {
	struct {
		nlmsghdr n;
		rtgenmsg g;
	} r;

	memset(&r, 0, sizeof(r));

	r.n.nlmsg_len = NLMSG_LENGTH(sizeof(r.g));
	r.n.nlmsg_flags = NLM_F_ROOT|NLM_F_MATCH|NLM_F_REQUEST;
	r.n.nlmsg_type = type;
	r.n.nlmsg_seq = rt_nlseq++;
//	r.g.rtgen_family = AF_INET6;
	r.g.rtgen_family = 0;

	send(rt_bcast_sock.fd(), &r, sizeof(r), 0);
}

void linux_unicast_router::shutdown() {
	if (rt_sock > 0) {
		close(rt_sock);
		rt_sock = -1;
	}

	rt_bcast_sock.unregister();

	rib_def::shutdown();
}

bool linux_unicast_router::set_property(const char *name, const char *value) {
	if (!strcmp(name, "netlink-buffer")) {
		char *end;
		int val = strtol(value, &end, 10);
		if (*end || val < 2048)
			return false;
		uint8_t *tmp = new uint8_t[val];
		if (!tmp)
			return false;

		delete [] buffer;
		buffer = tmp;
	}

	return node::set_property(name, value);
}

void linux_unicast_router::data_available(uint32_t) {
	process_message();
}

#define NLMSG_OK2(nlh,len)	((len) >= (int)sizeof(struct nlmsghdr) && \
				 (nlh)->nlmsg_len >= sizeof(struct nlmsghdr) && \
				 (int)(nlh)->nlmsg_len <= (len))

int linux_unicast_router::process_message() {
	int len = recv(rt_bcast_sock.fd(), buffer, bufferlen->get_unsigned(),
		       MSG_DONTWAIT | MSG_NOSIGNAL);

	if (len < 0) {
		return -1;
	}

	for (nlmsghdr *hd = (struct nlmsghdr *)buffer; NLMSG_OK2(hd, len);
			hd = NLMSG_NEXT(hd, len)) {
		if (hd->nlmsg_type == NLMSG_DONE)
			return 0;
		else if (hd->nlmsg_type == NLMSG_ERROR)
			return -1;

		if (hd->nlmsg_len == 0)
			break;

		switch (hd->nlmsg_type) {
		case RTM_NEWROUTE:
		case RTM_DELROUTE:
			handle_route_event(hd->nlmsg_type == RTM_NEWROUTE, hd);
			break;
		case RTM_NEWLINK:
		case RTM_DELLINK:
			handle_intf_event(hd->nlmsg_type != RTM_DELLINK, hd);
			break;
		case RTM_NEWADDR:
		case RTM_DELADDR:
			handle_addr_event(hd->nlmsg_type != RTM_DELADDR, hd);
			break;
		case RTM_NEWNEIGH:
		case RTM_DELNEIGH:
			handle_neigh_event(hd->nlmsg_type != RTM_DELNEIGH, hd);
			break;
		default:
			break;
		}
	}

	return 1;
}

void linux_unicast_router::handle_route_event(bool isnew, nlmsghdr *hdr) {
	rtattr *tb[RTA_MAX + 1];
	memset(tb, 0, sizeof(tb));

	netlink_msg *msg = (netlink_msg *)hdr;

	if (msg->r.rtm_family != AF_INET6 || (msg->r.rtm_flags & RTM_F_CLONED) == RTM_F_CLONED) {
		return;
	}

	netlink_msg::parse_rtatable(tb, RTA_MAX, RTM_RTA(NLMSG_DATA(hdr)),
				hdr->nlmsg_len - NLMSG_LENGTH(sizeof(rtmsg)));

	if (tb[RTA_DST]) {
		lookup_result res;

		parse_prefix_rec(tb, msg->r.rtm_dst_len,
				 msg->r.rtm_protocol, res);

		g_mrd->log().info(NORMAL) << "(NETLINK) route event: "
			<< (isnew ? "new" : "lost") << " route for " << res.dst
			<< " with dev " << res.dev << " gw " << res.nexthop
			<< " prefsrc " << res.source << " protocol "
			<< res.protocol << " metric " << res.metric
			<< " table " << msg->r.rtm_table << " scope "
			<< msg->r.rtm_scope << endl;

		if (res.protocol == RTPROT_UNSPEC || res.protocol == RTPROT_REDIRECT)
			return;

		if (res.protocol == RTPROT_BOOT || res.protocol == RTPROT_KERNEL) {
			if (!get_property_bool(accept_kernel_routes))
				return;
		}

		prefix_changed(isnew, res);
	}
}

void linux_unicast_router::handle_intf_event(bool isnew, nlmsghdr *hdr) {
	ifinfomsg *ifi = (ifinfomsg *)NLMSG_DATA(hdr);

	if (isnew) {
		rtattr *tb[IFLA_MAX + 1];
		memset(tb, 0, sizeof(tb));

		netlink_msg::parse_rtatable(tb, IFLA_MAX, IFLA_RTA(ifi), IFLA_PAYLOAD(hdr));

		if (tb[IFLA_IFNAME] && tb[IFLA_MTU]) {
			interface_desc desc;

			desc.index = ifi->ifi_index;
			desc.name = (const char *)RTA_DATA(tb[IFLA_IFNAME]);
			desc.mtu = *(int *)RTA_DATA(tb[IFLA_MTU]);
			desc.flags = ifi->ifi_flags;
			desc.type = _conv_intf(ifi->ifi_type, ifi->ifi_flags);
			desc.up = ((ifi->ifi_flags & IFF_UP) == IFF_UP);

			if (rt_dumping) {
				_interfaces.push_back(desc);
			} else {
				_install_interface(desc);
			}
		}
	} else {
		g_mrd->lost_interface(ifi->ifi_index);
	}
}

void linux_unicast_router::handle_addr_event(bool isnew, nlmsghdr *hdr) {
	ifaddrmsg *ifa = (ifaddrmsg *)NLMSG_DATA(hdr);

	if (ifa->ifa_family == AF_INET6) {
		rtattr *tb[IFA_MAX + 1];
		memset(tb, 0, sizeof(tb));

		netlink_msg::parse_rtatable(tb, IFA_MAX, IFA_RTA(ifa),
			hdr->nlmsg_len - NLMSG_LENGTH(sizeof(*ifa)));

		rtattr *arta = tb[IFA_LOCAL];
		if (!arta)
			arta = tb[IFA_ADDRESS];
		if (arta) {
			inet6_addr addr;
			memcpy(&addr.addr, RTA_DATA(arta), RTA_PAYLOAD(arta));
			addr.prefixlen = ifa->ifa_prefixlen;

			if (addr.type() & (inet6_addr::multicast | inet6_addr::network))
				return;

			if (addr.is_any())
				return;

			interface *intf = g_mrd->get_interface_by_index(ifa->ifa_index);
			if (intf) {
				intf->address_added_or_removed(isnew, addr);
			}
		}
	}
}

void linux_unicast_router::handle_neigh_event(bool isnew, nlmsghdr *hdr) {
	ndmsg *ndm = (ndmsg *)NLMSG_DATA(hdr);

	if (ndm->ndm_family == AF_INET6) {
		rtattr *tb[NDA_MAX + 1];
		memset(tb, 0, sizeof(tb));

		netlink_msg::parse_rtatable(tb, NDA_MAX, NDA_RTA(ndm),
				hdr->nlmsg_len - NLMSG_LENGTH(sizeof(*ndm)));

		if (tb[NDA_DST] && tb[NDA_LLADDR]) {
#if 0
			interface *intf = g_mrd->get_interface_by_index(ndm->ndm_ifindex);

			if (intf) {
				intf->neighbour_event(isnew, RTA_DATA(tb[NDA_LLADDR]),
				RTA_PAYLOAD(tb[NDA_LLADDR]), (in6_addr *)RTA_DATA(tb[NDA_DST]));
			}
#endif
		}
	}
}

bool linux_unicast_router::lookup_prefix(const in6_addr &addr, lookup_result &reply) const {
	/* Not fully inited yet */
	if (rt_bcast_sock.fd() < 0)
		return false;

	netlink_msg *msg = (netlink_msg *)buffer;

	msg->build(RTM_GETROUTE);
	msg->addattr(RTA_DST, &addr, sizeof(in6_addr));
	msg->r.rtm_dst_len = 128;

	reply.dev = -1;

	if (send_nlmsg(msg, msg)) {
		if (msg->r.rtm_family != AF_INET6)
			return false;

		rtattr *tb[RTA_MAX + 1];
		memset(tb, 0, sizeof(tb));

		msg->parse_rtatable(tb, RTA_MAX, RTM_RTA(NLMSG_DATA(&msg->n)),
				msg->length() - NLMSG_LENGTH(sizeof(rtmsg)));

		parse_prefix_rec(tb, msg->r.rtm_dst_len,
				 msg->r.rtm_protocol, reply);

		return true;
	}

	return false;
}

bool linux_unicast_router::send_nlmsg(const netlink_msg *msg, netlink_msg *reply) const {
	if (send(rt_sock, msg, msg->length(), 0) < 0)
		return false;

	int res = recv(rt_sock, buffer, bufferlen->get_unsigned(), 0);
	if (res < 0)
		return false;

	for (nlmsghdr *hd = (nlmsghdr *)buffer; NLMSG_OK(hd, (uint32_t)res);
				hd = NLMSG_NEXT(hd, res)) {
		if (hd->nlmsg_type == NLMSG_ERROR)
			return false;
		memmove(reply, hd, hd->nlmsg_len);
		return true;
	}

	return false;
}

void linux_unicast_router::parse_prefix_rec(rtattr *tb[], int plen, int protocol,
					    lookup_result &reply) const {
	reply.dst = inet6_addr(in6addr_any, plen);
	reply.dev = -1;
	reply.protocol = protocol;
	reply.metric = 0xffffffff;
	reply.nexthop = in6addr_any;
	reply.source = in6addr_any;

	if (tb[RTA_DST])
		reply.dst.addr = *(in6_addr *)RTA_DATA(tb[RTA_DST]);
	if (tb[RTA_OIF])
		reply.dev = *(int *)RTA_DATA(tb[RTA_OIF]);
	if (tb[RTA_GATEWAY])
		memcpy(&reply.nexthop, RTA_DATA(tb[RTA_GATEWAY]), sizeof(in6_addr));
	if (tb[RTA_PREFSRC])
		memcpy(&reply.source, RTA_DATA(tb[RTA_PREFSRC]), sizeof(in6_addr));
	if (tb[RTA_PRIORITY])
		reply.metric = *(uint32_t *)RTA_DATA(tb[RTA_PRIORITY]);
}

