/*
 *  OpenVPN -- An application to securely tunnel IP networks
 *             over a single TCP/UDP port, with support for SSL/TLS-based
 *             session authentication and key exchange,
 *             packet encryption, packet authentication, and
 *             packet compression.
 *
 *  Copyright (C) 2002-2008 Telethra, Inc. <sales@openvpn.net>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License version 2
 *  as published by the Free Software Foundation.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program (see the file COPYING included with this
 *  distribution); if not, write to the Free Software Foundation, Inc.,
 *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/*
 * Support routines for adding/deleting network routes.
 */

#ifndef ROUTE_H
#define ROUTE_H

#include "tun.h"
#include "misc.h"

#define MAX_ROUTES 100

#ifdef WIN32
/*
 * Windows route methods
 */
#define ROUTE_METHOD_ADAPTIVE  0  /* try IP helper first then route.exe */
#define ROUTE_METHOD_IPAPI     1  /* use IP helper API */
#define ROUTE_METHOD_EXE       2  /* use route.exe */
#define ROUTE_METHOD_MASK      3
#endif

/*
 * Route add flags (must stay clear of ROUTE_METHOD bits)
 */
#define ROUTE_DELETE_FIRST  4

struct route_bypass
{
# define N_ROUTE_BYPASS 8
  int n_bypass;
  in_addr_t bypass[N_ROUTE_BYPASS];
};

struct route_special_addr
{
  in_addr_t remote_endpoint;
  bool remote_endpoint_defined;
  in_addr_t net_gateway;
  bool net_gateway_defined;
  in_addr_t remote_host;
  bool remote_host_defined;
  struct route_bypass bypass;
  int default_metric;
  bool default_metric_defined;
};

struct route_option {
  const char *network;
  const char *netmask;
  const char *gateway;
  const char *metric;
};

/* redirect-gateway flags */
#define RG_ENABLE         (1<<0)
#define RG_LOCAL          (1<<1)
#define RG_DEF1           (1<<2)
#define RG_BYPASS_DHCP    (1<<3)
#define RG_BYPASS_DNS     (1<<4)

struct route_option_list {
  int n;
  unsigned int flags;
  struct route_option routes[MAX_ROUTES];
};

struct route {
  bool defined;
  const struct route_option *option;
  in_addr_t network;
  in_addr_t netmask;
  in_addr_t gateway;
  bool metric_defined;
  int metric;
};

struct route_list {
  bool routes_added;
  struct route_special_addr spec;
  unsigned int flags;
  bool did_redirect_default_gateway;
  int n;
  struct route routes[MAX_ROUTES];
};

#if P2MP
/* internal OpenVPN route */
struct iroute {
  in_addr_t network;
  int netbits;
  struct iroute *next;
};
#endif

struct route_option_list *new_route_option_list (struct gc_arena *a);

struct route_list *new_route_list (struct gc_arena *a);

void add_route (struct route *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es);

void add_route_to_option_list (struct route_option_list *l,
			       const char *network,
			       const char *netmask,
			       const char *gateway,
			       const char *metric);

void clear_route_list (struct route_list *rl);

bool init_route_list (struct route_list *rl,
		      const struct route_option_list *opt,
		      const char *remote_endpoint,
		      int default_metric,
		      in_addr_t remote_host,
		      struct env_set *es);

void add_routes (struct route_list *rl,
		 const struct tuntap *tt,
		 unsigned int flags,
		 const struct env_set *es);

void delete_routes (struct route_list *rl,
		    const struct tuntap *tt,
		    unsigned int flags,
		    const struct env_set *es);

void setenv_routes (struct env_set *es, const struct route_list *rl);

bool is_special_addr (const char *addr_str);

#if AUTO_USERID
bool get_default_gateway_mac_addr (unsigned char *macaddr);
#endif

#ifdef ENABLE_DEBUG
void print_route_options (const struct route_option_list *rol,
			  int level);
#endif

void print_routes (const struct route_list *rl, int level);

#ifdef WIN32

void show_routes (int msglev);
bool test_routes (const struct route_list *rl, const struct tuntap *tt);
bool add_route_ipapi (const struct route *r, const struct tuntap *tt);
bool del_route_ipapi (const struct route *r, const struct tuntap *tt);

#else
static inline bool test_routes (const struct route_list *rl, const struct tuntap *tt) { return true; }
#endif

bool netmask_to_netbits (const in_addr_t network, const in_addr_t netmask, int *netbits);

static inline in_addr_t
netbits_to_netmask (const int netbits)
{
  const int addrlen = sizeof (in_addr_t) * 8;
  in_addr_t mask = 0;
  if (netbits > 0 && netbits <= addrlen)
    mask = ~0 << (addrlen-netbits);
  return mask;
}

#endif
