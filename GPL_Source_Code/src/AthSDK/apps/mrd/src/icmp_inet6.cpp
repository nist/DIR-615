/*
 * Multicast Routing Daemon (MRD)
 *   icmp_inet6.cpp
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
#include <mrd/address.h>
#include <mrd/interface.h>
#include <mrd/group.h>

#include <mrdpriv/icmp_inet6.h>

#include <errno.h>
#include <cstring>

#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>
#include <netinet/in.h>
#include <netinet/ip6.h>
#include <netinet/icmp6.h>
#include <arpa/inet.h>
#include <net/if.h>

#include <sys/ioctl.h>

/* Not every system has inet6_option_xxx */
#ifdef NO_INET6_OPTION
int inet6_option_space(int nbytes);
int inet6_option_init(void *bp, struct cmsghdr **cmsgp, int type);
int inet6_option_append(struct cmsghdr *cmsg, const uint8_t *typep,
			int multx, int plusy);
#endif /* NO_INET6_OPTION */



#define IP6OPT_PAD1 0

#define IP6OPT_PADN 1



struct _ip6_ext {
	uint8_t ip6e_nxt;
	uint8_t ip6e_len;
};



static in6_addr mld_all_routers;
static in6_addr all_routers;

struct ip6_rta {
	uint8_t type;
	uint8_t length;
	uint16_t value;
} __attribute__ ((packed));

icmp_inet6::icmp_inet6()
	: m_icmpsock("icmpv6", this, std::mem_fun(&icmp_inet6::data_available)) {

	mld_all_routers = inet6_addr("ff02::16").address();
	all_routers = inet6_addr("ff02::2").address();
}

static uint8_t buffer[8192];

bool icmp_inet6::check_startup() {
	int sock = socket(PF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
	if (sock < 0) {
		g_mrd->log().perror("MLD-ICMP: Failed to create ICMPv6 socket");
		return false;
	}

	if (!m_icmpsock.register_fd(sock)) {
		close(sock);
		return false;
	}

	if (!m_icmpsock.enable_mc_loop(false))
		return false;

	return true;
}

void icmp_inet6::shutdown() {
	m_icmpsock.unregister();
}

bool icmp_inet6::apply_icmp_filter() {
#ifdef ICMP6_FILTER
	icmp6_filter filter;
	ICMP6_FILTER_SETBLOCKALL(&filter);

	for (handlers::const_iterator i =
		m_handlers.begin(); i != m_handlers.end(); ++i) {
		ICMP6_FILTER_SETPASS(i->first, &filter);
	}

	if (setsockopt(m_icmpsock.fd(), IPPROTO_ICMPV6, ICMP6_FILTER,
				&filter, sizeof(filter)) < 0) {
		g_mrd->log().warn() << "[ICMPv6] failed to install ICMP filter in socket." << endl;

		return false;
	}
#endif

	return true;
}

void icmp_inet6::registration_changed() {
	apply_icmp_filter();
}

void icmp_inet6::data_available(uint32_t) {
	int recvlen = m_icmpsock.recvfrom(buffer, sizeof(buffer));

	if (recvlen < 0)
		return;

	sockaddr_in6 dst;
	int index;

	if (!m_icmpsock.destination_address(dst, index))
		return;

	if (index == 0)
		return;

	const sockaddr_in6 &from = m_icmpsock.source_address();

	g_mrd->log().info(NORMAL) << "[ICMP] ICMPv6 message from "
		<< from.sin6_addr << " to " << dst.sin6_addr << " dev " << index << endl;

	interface *intf = g_mrd->get_interface_by_index(index);
	if (!intf)
		return;

	icmp_message_available(intf, from.sin6_addr, dst.sin6_addr,
			       (icmp6_hdr *)buffer, recvlen);
}

static void
inet6_insert_padopt(uint8_t *p, int len)
{
        switch(len) {
         case 0:
                 return;
         case 1:
                 p[0] = IP6OPT_PAD1;
                 return;
         default:
                 p[0] = IP6OPT_PADN;
                 p[1] = len - 2;
                 memset(&p[2], 0, len - 2);
                 return;
        }
}


/*
 * This function is called once per ancillary data object that will
 * contain either Hop-by-Hop or Destination options.  It returns 0 on
 * success or -1 on an error.
 */
int
inet6_option_init(void *bp, struct cmsghdr **cmsgp, int type)
{
        register struct cmsghdr *ch = (struct cmsghdr *)bp;

        /* argument validation */
        if (type != IPV6_HOPOPTS && type != IPV6_DSTOPTS)
                return(-1);

        ch->cmsg_level = IPPROTO_IPV6;
        ch->cmsg_type = type;
        ch->cmsg_len = CMSG_LEN(0);

        *cmsgp = ch;
        return(0);
}

/*
 * This function returns the number of bytes required to hold an option
 * when it is stored as ancillary data, including the cmsghdr structure
 * at the beginning, and any padding at the end (to make its size a
 * multiple of 8 bytes).  The argument is the size of the structure
 * defining the option, which must include any pad bytes at the
 * beginning (the value y in the alignment term "xn + y"), the type
 * byte, the length byte, and the option data.
 */
int
inet6_option_space(int nbytes)
{
        nbytes += 2;        /* we need space for nxt-hdr and length fields */
        return(CMSG_SPACE((nbytes + 7) & ~7));
}

/*
 * This function appends a Hop-by-Hop option or a Destination option
 * into an ancillary data object that has been initialized by
 * inet6_option_init().  This function returns 0 if it succeeds or -1 on
 * an error.
 * multx is the value x in the alignment term "xn + y" described
 * earlier.  It must have a value of 1, 2, 4, or 8.
 * plusy is the value y in the alignment term "xn + y" described
 * earlier.  It must have a value between 0 and 7, inclusive.
 */
int
inet6_option_append(struct cmsghdr *cmsg, const uint8_t *typep, int multx, int plusy)
{
        int padlen, optlen, off;
        register u_char *bp = (u_char *)cmsg + cmsg->cmsg_len;
        struct _ip6_ext *eh = (struct _ip6_ext *)CMSG_DATA(cmsg);

        /* argument validation */
        if (multx != 1 && multx != 2 && multx != 4 && multx != 8)
                return(-1);
        if (plusy < 0 || plusy > 7)
                return(-1);
	/*
        if (typep[0] > 255)
                return(-1);
	*/

        /*
         * If this is the first option, allocate space for the
         * first 2 bytes(for next header and length fields) of
         * the option header.
         */
        if (bp == (u_char *)eh) {
                bp += 2;
                cmsg->cmsg_len += 2;
        }

        /* calculate pad length before the option. */
        off = bp - (u_char *)eh;
        padlen = (((off % multx) + (multx - 1)) & ~(multx - 1)) -
                (off % multx);
        padlen += plusy;
        padlen %= multx;        /* keep the pad as short as possible */
        /* insert padding */
        inet6_insert_padopt(bp, padlen);
        cmsg->cmsg_len += padlen;
        bp += padlen;

        /* copy the option */
        if (typep[0] == IP6OPT_PAD1)
                optlen = 1;
        else
                optlen = typep[1] + 2;
        memcpy(bp, typep, optlen);
        bp += optlen;
        cmsg->cmsg_len += optlen;

        /* calculate pad length after the option and insert the padding */
        off = bp - (u_char *)eh;
        padlen = ((off + 7) & ~7) - off;
        inet6_insert_padopt(bp, padlen);
        bp += padlen;
        cmsg->cmsg_len += padlen;

        /* update the length field of the ip6 option header */
        eh->ip6e_len = ((bp - (u_char *)eh) >> 3) - 1;

        return(0);
}

bool icmp_inet6::send_icmp(const interface *intf, const in6_addr &src,
			   const in6_addr &to, icmp6_hdr *hdr, uint16_t len) const {
	sockaddr_in6 dst, from;
	g_mrd->log().info(NORMAL) << "icmp_inet6::send_icmp entry" << endl;
	memset(&dst, 0, sizeof(sockaddr_in6));
	memset(&from, 0, sizeof(sockaddr_in6));

	dst.sin6_family = AF_INET6;
	dst.sin6_addr = to;

	from.sin6_family = AF_INET6;
	from.sin6_addr = src;

	if (IN6_IS_ADDR_LINKLOCAL(&src))
		from.sin6_scope_id = intf->index();

	ip6_rta rta;

	rta.type = 5;
	rta.length = sizeof(rta.value);
	rta.value = 0;

	cmsghdr *msg = m_icmpsock.next_cmsghdr();

	if (msg) {
		if (inet6_option_init(msg, &msg, IPV6_HOPOPTS) == 0) {
			if (inet6_option_append(msg, (uint8_t *)&rta, 1, 0) == 0) {
				if (m_icmpsock.sendto(hdr, len, &dst, &from,
						inet6_option_space(sizeof(ip6_rta))) > 0) {
					return true;
				} else {
					g_mrd->log().info(NORMAL)
						<< "icmp_inet6::send_icmp Failed to send ICMPv6 message from "
						<< src << " to " << to << ": "
						<< strerror(errno) << endl;
					return false;
				}
			}
		}
	}

	g_mrd->log().info(NORMAL) << "icmp_inet6::send_icmp Failed to send ICMPv6 message: wasn't able to construct message" << endl;

	return false;
}

void icmp_inet6::internal_require_mgroup(const in6_addr &mgroup, bool include) {
	mrd::interface_list::const_iterator i = g_mrd->intflist().begin();

	for (; i != g_mrd->intflist().end(); ++i) {
		if (!i->second->up())
			continue;

		if (include)
			m_icmpsock.join_mc(i->second, mgroup);
		else
			m_icmpsock.leave_mc(i->second, mgroup);
	}
}

void icmp_inet6::added_interface(interface *intf) {
	for (mgroups::const_iterator i =
		m_mgroups.begin(); i != m_mgroups.end(); ++i) {
		m_icmpsock.join_mc(intf, i->first);
	}
}

void icmp_inet6::removed_interface(interface *intf) {
	for (mgroups::const_iterator i =
		m_mgroups.begin(); i != m_mgroups.end(); ++i) {
		m_icmpsock.leave_mc(intf, i->first);
	}
}

