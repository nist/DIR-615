/*
 * Multicast Routing Daemon (MRD)
 *   address_set.h
 *
 * Copyright (C) 2004, 2005
 *   Universidade de Aveiro, Instituto Telecomunicacoes - Polo Aveiro
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

#ifndef _mrd_address_set_h_
#define _mrd_address_set_h_

#include <mrd/address.h>
#include <mrd/log.h>

#include <map>
#include <set>
#include <algorithm>

/*!
 * \class address_set mrd/address_set.h
 * \brief implements an address list.
 */
class address_set : public std::set<in6_addr> {
public:
	address_set();
	address_set(const in6_addr &);
	address_set(const inet6_addr &);
	address_set(const address_set &);

	address_set &union_with(const address_set &);
	address_set &union_with(const address_set &, address_set &diff);
	address_set &diff_with(const address_set &);
	address_set &diff_with(const address_set &, address_set &diff);
	address_set &intersect_with(const address_set &);
	address_set &intersect_with(const address_set &, address_set &diff);

	address_set &assign_with(const address_set &, address_set &added, address_set &remove);

	bool has_addr(const in6_addr &) const;

	bool remove(const in6_addr &);

	address_set &operator += (const in6_addr &);

	address_set operator + (const address_set &addrs) const {
		return address_set(*this).union_with(addrs);
	}

	address_set operator - (const address_set &addrs) const {
		return address_set(*this).diff_with(addrs);
	}

	address_set operator * (const address_set &addrs) const {
		return address_set(*this).intersect_with(addrs);
	}

	friend base_stream &operator << (base_stream &, const address_set &);
};

// inlines

inline address_set::address_set() { }
inline address_set::address_set(const in6_addr &addr)
	{ insert(end(), addr); }
inline address_set::address_set(const inet6_addr &addr)
	{ insert(end(), addr.address()); }
inline address_set::address_set(const address_set &orig)
	: std::set<in6_addr>(orig) { }

inline bool address_set::has_addr(const in6_addr &addr) const {
	return find(addr) != end();
}

inline address_set &address_set::operator += (const in6_addr &addr) {
	insert(end(), addr);
	return *this;
}

#endif

