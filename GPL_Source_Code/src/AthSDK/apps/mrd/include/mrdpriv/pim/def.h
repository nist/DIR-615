/*
 * Multicast Routing Daemon (MRD)
 *   pim/def.h
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

#ifndef _mrd_pim_h_
#define _mrd_pim_h_

#include <mrd/address.h>
#include <mrd/address_set.h>

#include <netinet/in.h>
#include <netinet/ip6.h>

class base_stream;

#if BYTE_ORDER != LITTLE_ENDIAN && BYTE_ORDER != BIG_ENDIAN
#	error "Your system's endianess is not supported."
#endif

enum pim_msg_type {
	pim_msg_hello = 0,
	pim_msg_register,
	pim_msg_register_stop,
	pim_msg_joinprune,
	pim_msg_bootstrap,
	pim_msg_assert,
	pim_msg_graft,
	pim_msg_graft_ack,
	pim_msg_candidate_rp_adv
};

/*!
 * \brief base PIM message header.
 */
struct pim_message {
	uint8_t vt;

	pim_msg_type type() const { return (pim_msg_type)(vt & 0xf); }
	const char *type_name() const;

	uint8_t resv1;
	uint16_t checksum;

	void construct(pim_msg_type t);

	void build_checksum(const in6_addr &, const in6_addr &, int);
	bool has_valid_checksum(const in6_addr &, const in6_addr &, int len);

} __attribute__ ((packed));

struct pim_hello_option {
	enum {
		holdtime = 1,
		lan_prune_delay = 2,
		dr_priority = 19,
		genid = 20,
		addrlist = 24
	};

	uint16_t type;
	uint16_t length;

	void construct(uint16_t type, uint16_t length);

	void add_uint16(uint16_t type, uint16_t value);
	void add_uint16pair(uint16_t type, uint16_t v1, uint16_t v2);
	void add_uint32(uint16_t type, uint32_t value);

	pim_hello_option *next() const;
	void *data();
} __attribute__ ((packed));

/*!
 * \brief PIM Hello message.
 */
struct pim_hello_message : pim_message {
	void construct();

	pim_hello_option *options();
} __attribute__ ((packed));

/*!
 * \brief PIM Register message.
 */
struct pim_register_message : pim_message {
	uint32_t nb;

	void construct(bool);

	ip6_hdr *ip6packet();

	bool null() const;

} __attribute__ ((packed));

enum pim_addr_type {
	// we only care about IPv6
	pim_addr_reserved = 0,
	pim_addr_ip6 = 2
};

struct pim_encoded_unicast_address {
	uint8_t family;
	uint8_t type;
	in6_addr addr;

	void construct(const in6_addr *ma);
	void construct(const inet6_addr &);
} __attribute__ ((packed));

struct pim_encoded_group_address {
	uint8_t family;
	uint8_t type;
#if BYTE_ORDER == LITTLE_ENDIAN
	uint8_t z : 1, resv : 6, b : 1;
#elif BYTE_ORDER == BIG_ENDIAN
	uint8_t b : 1, resv : 6, z : 1;
#endif
	uint8_t masklen;
	in6_addr addr;

	void construct(const inet6_addr &);
} __attribute__ ((packed));

struct pim_encoded_source_address {
	uint8_t family;
	uint8_t type;
	uint8_t flags;
	uint8_t masklen;
	in6_addr addr;

	bool space() const { return flags & 0x4; }
	bool wc() const { return flags & 0x2; }
	bool rpt() const { return flags & 0x1; }

	void construct(const inet6_addr &, bool w, bool r);
} __attribute__ ((packed));

/*!
 * \brief PIM Register Stop message.
 */
struct pim_register_stop_message : pim_message {
	pim_encoded_group_address gaddr;
	pim_encoded_unicast_address uaddr;

	void construct(const inet6_addr &, const inet6_addr &);
} __attribute__ ((packed));

struct pim_joinprune_group {
	pim_encoded_group_address maddr;
	uint16_t njoins;
	uint16_t nprunes;

	uint16_t join_count() const { return ntohs(njoins); }
	uint16_t prune_count() const { return ntohs(nprunes); }

	pim_encoded_source_address *addrs() const;
	void construct(const inet6_addr &addr, uint16_t js, uint16_t ps);
	uint16_t length() const;

	address_set &pruned_addrs(address_set &) const;
	bool has_prune_addr(const inet6_addr &) const;

	pim_joinprune_group *next() const;
} __attribute__ ((packed));

/*!
 * \brief PIM Join/Prune message.
 */
struct pim_joinprune_message : pim_message {
	pim_encoded_unicast_address upstream_neigh;
	uint8_t resv1;
	uint8_t ngroups;
	uint16_t holdtime;

	pim_joinprune_group *groups() const;
	void construct(const inet6_addr &, uint8_t groups, uint16_t holdtime);

	uint16_t length() const;
} __attribute__ ((packed));

struct pim_bootstrap_rp_record {
	pim_encoded_unicast_address addr;
	uint16_t holdtime;
	uint8_t priority;
	uint8_t resv;
} __attribute__ ((packed));

struct pim_bootstrap_group_def {
	pim_encoded_group_address grpaddr;
	uint8_t rpcount, fragrp;
	uint16_t resv;

	pim_bootstrap_rp_record *rps() const;

	pim_bootstrap_group_def *next() const;

	uint16_t length() const;
} __attribute__ ((packed));

/*!
 * \brief PIM Bootstrap message.
 */
struct pim_bootstrap_message : pim_message {
	uint16_t fragment;
	uint8_t hash_masklen, bsr_priority;
	pim_encoded_unicast_address bsr_address;

	void construct(uint16_t, uint8_t, uint8_t, const inet6_addr &);
	pim_bootstrap_group_def *grps() const;
} __attribute__ ((packed));

/*!
 * \brief PIM Candidate RP Adv message.
 */
struct pim_candidate_rp_adv_message : pim_message {
	uint8_t prefixcount;
	uint8_t priority;
	uint16_t holdtime;
	pim_encoded_unicast_address rp_addr;

	void construct(uint8_t, uint8_t, uint16_t, const inet6_addr &);

	pim_encoded_group_address *grps() const;

	uint16_t length() const;
} __attribute__ ((packed));

/*!
 * \brief PIM Assert message.
 */
struct pim_assert_message : pim_message {
	pim_encoded_group_address gaddr;
	pim_encoded_unicast_address saddr;
	uint32_t metric_pref;
	uint32_t metric;

	void construct(const inet6_addr &, const inet6_addr &, bool, uint32_t, uint32_t);
} __attribute__ ((packed));

void _debug_pim_dump(base_stream &, const pim_joinprune_message &);
void _debug_pim_dump(base_stream &, const pim_assert_message &msg);

/// INLINES

inline void pim_hello_option::construct(uint16_t t, uint16_t l) {
	t = htons(t);
	l = htons(l);

	/* to prevent un-aligned accesses */
	memcpy(&type, &t, 2);
	memcpy(&length, &l, 2);
}

inline void pim_hello_option::add_uint16(uint16_t type, uint16_t value) {
	construct(type, 2);

	value = htons(value);

	memcpy(data(), &value, 2);
}

inline void pim_hello_option::add_uint16pair(uint16_t type, uint16_t v1,
					     uint16_t v2) {
	construct(type, 4);

	uint16_t *d = (uint16_t *)data();

	v1 = htons(v1);
	v2 = htons(v2);

	memcpy(d, &v1, 2);
	memcpy(d + 1, &v2, 2);
}

inline void pim_hello_option::add_uint32(uint16_t type, uint32_t value) {
	construct(type, 4);

	value = htonl(value);

	memcpy(data(), &value, 4);
}

inline pim_hello_option *pim_hello_option::next() const {
	return (pim_hello_option *)(((uint8_t *)this) + sizeof(*this) + ntohs(length));
}

inline void *pim_hello_option::data() {
	return (((uint8_t *)this) + sizeof(*this));
}

inline void pim_hello_message::construct() {
	pim_message::construct(pim_msg_hello);
}

inline pim_hello_option *pim_hello_message::options() {
	return (pim_hello_option *)(((uint8_t *)this) + sizeof(*this));
}

inline void pim_register_message::construct(bool null) {
	pim_message::construct(pim_msg_register);
	nb = null ? htonl(0x40000000) : 0;
}

inline ip6_hdr *pim_register_message::ip6packet() {
	return (ip6_hdr *)(((uint8_t *)this) + sizeof(*this));
}

inline bool pim_register_message::null() const {
	return (ntohl(nb) & 0x40000000) != 0;
}

inline void pim_encoded_unicast_address::construct(const in6_addr *ma) {
	family = pim_addr_ip6;
	type = 0;
	addr = *ma;
}

inline void pim_encoded_unicast_address::construct(const inet6_addr &ma) {
	construct(ma.address_p());
}

inline void pim_encoded_group_address::construct(const inet6_addr &ma) {
	family = pim_addr_ip6;
	type = 0;
	b = 0;
	resv = 0;
	z = 0;
	masklen = ma.prefixlen;
	addr = ma.address();
}

inline void pim_encoded_source_address::construct(const inet6_addr &ma, bool w, bool r) {
	family = pim_addr_ip6;
	type = 0;
	flags = 0x4 | (w ? 0x2 : 0x0) | (r ? 0x1 : 0x0);
	masklen = ma.prefixlen;
	addr = ma.address();
}

inline void pim_register_stop_message::construct(const inet6_addr &ga, const inet6_addr &sa) {
	pim_message::construct(pim_msg_register_stop);

	gaddr.construct(ga);
	uaddr.construct(sa);
}

inline pim_encoded_source_address *pim_joinprune_group::addrs() const {
	return (pim_encoded_source_address *)(((uint8_t *)this) + sizeof(*this));
}

inline void pim_joinprune_group::construct(const inet6_addr &addr, uint16_t js, uint16_t ps) {
	maddr.construct(addr);

	js = htons(js);
	ps = htons(ps);

	memcpy(&njoins, &js, 2);
	memcpy(&nprunes, &ps, 2);
}

inline uint16_t pim_joinprune_group::length() const {
	return sizeof(*this) + (ntohs(njoins) + ntohs(nprunes)) * sizeof(pim_encoded_source_address);
}

inline address_set &pim_joinprune_group::pruned_addrs(address_set &as) const {
	pim_encoded_source_address *pa = addrs() + ntohs(njoins);
	for (uint16_t i = 0; i < ntohs(nprunes); i++, pa++) {
		as += pa->addr;
	}

	return as;
}

inline bool pim_joinprune_group::has_prune_addr(const inet6_addr &addr) const {
	pim_encoded_source_address *pa = addrs() + ntohs(njoins);
	for (uint16_t i = 0; i < ntohs(nprunes); i++, pa++) {
		if (addr == inet6_addr(pa->addr))
			return true;
	}
	return false;
}

inline pim_joinprune_group *pim_joinprune_group::next() const {
	return (pim_joinprune_group *)(((uint8_t *)this) + length());
}

inline pim_joinprune_group *pim_joinprune_message::groups() const {
	return (pim_joinprune_group *)(((uint8_t *)this) + sizeof(*this));
}

inline void pim_joinprune_message::construct(const inet6_addr &neigh, uint8_t groups, uint16_t time) {
	pim_message::construct(pim_msg_joinprune);
	upstream_neigh.construct(neigh);
	resv1 = 0;
	ngroups = groups;

	time = htons(time);

	memcpy(&holdtime, &time, 2);
}

inline uint16_t pim_joinprune_message::length() const {
	uint16_t len = sizeof(*this);
	pim_joinprune_group *grp = groups();
	for (uint8_t i = 0; i < ngroups; i++, grp = grp->next()) {
		len += grp->length();
	}
	return len;
}

inline pim_bootstrap_rp_record *pim_bootstrap_group_def::rps() const {
	return (pim_bootstrap_rp_record *)(((uint8_t *)this) + sizeof(*this));
}

inline uint16_t pim_bootstrap_group_def::length() const {
	return sizeof(*this) + fragrp * sizeof(pim_bootstrap_rp_record);
}

inline pim_bootstrap_group_def *pim_bootstrap_group_def::next() const {
	return (pim_bootstrap_group_def *)(((uint8_t *)this) + length());
}

inline void pim_bootstrap_message::construct(uint16_t frag, uint8_t ml, uint8_t prio, const inet6_addr &addr) {
	pim_message::construct(pim_msg_bootstrap);

	frag = htons(frag);
	memcpy(&fragment, &frag, 2);

	hash_masklen = ml;
	bsr_priority = prio;
	bsr_address.construct(addr);
}

inline pim_bootstrap_group_def *pim_bootstrap_message::grps() const {
	return (pim_bootstrap_group_def *)(((uint8_t *)this) + sizeof(*this));
}

inline void pim_candidate_rp_adv_message::construct(uint8_t pfxct, uint8_t prio, uint16_t ht, const inet6_addr &addr) {
	pim_message::construct(pim_msg_candidate_rp_adv);

	prefixcount = pfxct;
	priority = prio;

	ht = htons(ht);
	memcpy(&holdtime, &ht, 2);

	rp_addr.construct(addr);
}

inline pim_encoded_group_address *pim_candidate_rp_adv_message::grps() const {
	return (pim_encoded_group_address *)(((uint8_t *)this) + sizeof(*this));
}

inline uint16_t pim_candidate_rp_adv_message::length() const {
	return sizeof(*this) + prefixcount * sizeof(pim_encoded_group_address);
}

inline void pim_assert_message::construct(const inet6_addr &grp, const inet6_addr &src, bool _rpt, uint32_t metpref, uint32_t met) {
	pim_message::construct(pim_msg_assert);

	gaddr.construct(grp);
	saddr.construct(src);

	metpref &= 0x7fffffff;
	if (_rpt)
		metpref |= 0x80000000;

	metpref = htonl(metpref);
	met = htonl(met);

	memcpy(&metric_pref, &metpref, 4);
	memcpy(&metric, &met, 4);
}

#endif

