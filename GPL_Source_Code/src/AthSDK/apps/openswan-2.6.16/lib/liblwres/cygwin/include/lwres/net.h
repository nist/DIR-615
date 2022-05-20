/*
 * Copyright (C) 2004  Internet Systems Consortium, Inc. ("ISC")
 * Copyright (C) 2000, 2001  Internet Software Consortium.
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND ISC DISCLAIMS ALL WARRANTIES WITH
 * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS.  IN NO EVENT SHALL ISC BE LIABLE FOR ANY SPECIAL, DIRECT,
 * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
 * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
 * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 * PERFORMANCE OF THIS SOFTWARE.
 */

/* $Id: net.h,v 1.1 2008/10/01 02:21:27 ken_chiang Exp $ */

#ifndef LWRES_NET_H
#define LWRES_NET_H 1

/*****
 ***** Module Info
 *****/

/*
 * Basic Networking Types
 *
 * This module is responsible for defining the following basic networking
 * types:
 *
 *		struct in_addr
 *		struct in6_addr
 *		struct sockaddr
 *		struct sockaddr_in
 *		struct sockaddr_in6
 *
 * It ensures that the AF_ and PF_ macros are defined.
 *
 * It declares ntoh[sl]() and hton[sl]().
 *
 * It declares lwres_net_aton(), lwres_net_ntop(), and lwres_net_pton().
 *
 * It ensures that INADDR_LOOPBACK, INADDR_ANY and IN6ADDR_ANY_INIT
 * are defined.
 */

/***
 *** Imports.
 ***/

#include <sys/types.h>
#include <netinet/in.h>

#ifndef AF_UNSPEC
#define AF_UNSPEC       0
#endif

#ifndef AF_INET6
#define AF_INET6        23              /* IP version 6 */
#endif

#ifndef PF_INET6
#define PF_INET6        23              /* IP version 6 */
#endif

#include <lwres/ipv6.h>
#include <lwres/platform.h>	/* Required for LWRES_PLATFORM_*. */

#include <isc/ipv6.h>

#include <lwres/lang.h>

#ifndef INADDR_LOOPBACK
#define INADDR_LOOPBACK 0x7f000001UL
#endif

LWRES_LANG_BEGINDECLS

const char *
lwres_net_ntop(int af, const void *src, char *dst, size_t size);

int
lwres_net_pton(int af, const char *src, void *dst);

int
lwres_net_aton(const char *cp, struct in_addr *addr);

LWRES_LANG_ENDDECLS

#endif /* LWRES_NET_H */
