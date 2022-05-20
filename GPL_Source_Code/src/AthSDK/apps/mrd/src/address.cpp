/*
 * Multicast Routing Daemon (MRD)
 *   address.cpp
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

#include <mrd/address.h>
#include <mrd/log.h>

#include <sys/socket.h>
#include <arpa/inet.h>

#include <cstdio>

base_stream &operator << (base_stream &os, const inet6_addr &addr) {
	os.commit_change(addr.print_string(os.req_buffer(64), 64));
	return os;
}

base_stream &operator << (base_stream &os, const in6_addr &addr) {
	char *buf = os.req_buffer(64);
	inet_ntop(AF_INET6, &addr, buf, 64);
	os.commit_change(strlen(buf));
	return os;
}

inet6_addr::inet6_addr()
	: addr(in6addr_any), prefixlen(0) {
}

inet6_addr::inet6_addr(const in6_addr &addr)
	: addr(addr), prefixlen(128) {
}

inet6_addr::inet6_addr(const in6_addr &address, uint8_t plen)
	: addr(address), prefixlen(plen) {
}

inet6_addr::inet6_addr(const inet6_addr &addr)
	: addr(addr.addr), prefixlen(addr.prefixlen) {
}

inet6_addr::inet6_addr(const std::string &addr) {
	set(addr);
}

inet6_addr::inet6_addr(const std::vector<char> &_addr) {
	if (_addr.size() == 16) {
		in6_addr addr;
		for (int i = 0; i < 16; i++)
			addr.s6_addr[i] = _addr[i];
		set(addr, 128);
	} else {
		set(in6addr_any, 0);
	}
}

unsigned inet6_addr::type() const {
	unsigned val = 0;

	if (IN6_IS_ADDR_MULTICAST(&addr))
		val |= multicast;
	if (addr.s6_addr[15] == 0)
		val |= network;

	return val;
}

bool inet6_addr::operator < (const inet6_addr &address) const {
	if (prefixlen < address.prefixlen)
		return true;
	return memcmp(addr.s6_addr, address.addr.s6_addr, sizeof(in6_addr)) < 0;
}

bool inet6_addr::operator > (const inet6_addr &address) const {
	if (prefixlen > address.prefixlen)
		return true;
	else if (prefixlen < address.prefixlen)
		return false;
	return memcmp(addr.s6_addr, address.addr.s6_addr, sizeof(in6_addr)) > 0;
}

bool inet6_addr::operator == (const inet6_addr &address) const {
	if (prefixlen != address.prefixlen)
		return false;
	return IN6_ARE_ADDR_EQUAL(&addr, &address.addr);
}

std::string inet6_addr::as_string() const {
	char buf[64];

	print_string(buf, sizeof(buf));

	return std::string(buf);
}

int inet6_addr::print_string(char *buf, int len) const {
	inet_ntop(AF_INET6, &addr, buf, len);
	int l = strlen(buf);
	if (prefixlen < 128) {
		len -= l;
		if (len > 4) {
			buf[l] = '/';
			l += sprintf(buf + l + 1, "%i", prefixlen) + 1;
		}
	}
	return l;
}

sockaddr_in6 inet6_addr::as_sockaddr() const {
	sockaddr_in6 saddr;

	memset(&saddr, 0, sizeof(saddr));

	saddr.sin6_family = AF_INET6;
	saddr.sin6_addr = addr;

	return saddr;
}

void inet6_addr::set(const in6_addr &address, uint8_t plen) {
	addr = address;
	prefixlen = plen;
}

bool inet6_addr::set(const std::string &str) {
	if (str == "any") {
		addr = in6addr_any;
		prefixlen = 0;
		return true;
	}

	size_t k = str.find('/');
	if (k < str.size()) {
		std::string tmp = str;
		std::string prefix = str.c_str() + k + 1;
		tmp.resize(k);

		if (!inet_pton(AF_INET6, tmp.c_str(), &addr))
			return false;

		char *end;
		int pl = strtol(prefix.c_str(), &end, 10);
		if (*end || pl < 0 || pl > 128)
			return false;
		prefixlen = pl;
	} else {
		if (!inet_pton(AF_INET6, str.c_str(), &addr))
			return false;
		prefixlen = 128;
	}
	return true;
}

bool inet6_addr::from_string(const std::string &value, inet6_addr &res) {
	return res.set(value);
}

void inet6_addr::to_string(const inet6_addr &value, std::string &res) {
	res = value.as_string();
}

inet6_addr inet6_addr::prefix() const {
	inet6_addr copy = *this;
	copy.apply_prefixlen();
	return copy;
}

void inet6_addr::apply_prefixlen() {
	uint8_t *ptr = addr.s6_addr;

	int start = prefixlen / 8;
	int mask = (0xff << (8 - (prefixlen % 8))) & 0xff;

	if (start < 15)
		memset(ptr + start + 1, 0, (16 - start - 1));

	ptr[start] &= mask;
}

