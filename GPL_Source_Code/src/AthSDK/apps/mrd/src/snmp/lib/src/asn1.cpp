/*
 * Multicast Routing Daemon (MRD)
 *   asn1.cpp
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

#include <snmp/asn1.h>

#include <iostream>

#include <netinet/in.h>

namespace asn {

static_encoding_buffer::static_encoding_buffer(uint8_t *b, int len)
	: buffer(b), length(len), pointer(0) {
}

bool static_encoding_buffer::require(int len) const {
	return (pointer + len) <= length;
}

void *static_encoding_buffer::eat(int len) {
	if ((pointer + len) > length)
		return 0;

	void *res = buffer + pointer;
	pointer += len;
	return res;
}

void *static_encoding_buffer::peek(int len) const {
	if ((pointer + len) > length)
		return 0;

	return buffer + pointer;
}

object::object(uint8_t t) : type(t) {
}

int object::get_length() const {
	return 0;
}

int object::get_object_length() const {
	int len = get_length();
	int objlen = 2 + len;

	if (len > 0x7f) {
		objlen++;
		while (len > 0xff) {
			len >>= 8;
			objlen++;
		}
	}

	return objlen;
}

bool object::encode(encoding_buffer &buff) const {
	int len = get_length();

	int lensize = 0;
	if (len > 0x7f) {
		lensize = 1;
		int l = len;
		while (l > 0xff) {
			l >>= 8;
			lensize++;
		}
	}

	if (!buff.require(2 + lensize + len))
		return false;

	buff.eat<uint8_t>() = type;

	if (lensize > 0) {
		buff.eat<uint8_t>() = 0x80 | lensize;

		int i = lensize - 1;
		while (i >= 0) {
			buff.eat<uint8_t>() = (len >> (8 * i)) & 0xff;
			i--;
		}
	} else {
		buff.eat<uint8_t>() = len;
	}
	
	return true;
}

bool object::decode(encoding_buffer &buff) {
	uint8_t enctype;
	int len;

	if (!base_decode(buff, enctype, len))
		return false;

	if (enctype != type) {
		return false;
	}

	return decode_content(buff, len);
}

bool object::base_decode(encoding_buffer &b, uint8_t &enctype, int &len, int *hl) {
	if (!b.require(2))
		return false;

	int headerlen = 2;

	enctype = b.eat<uint8_t>();
	uint8_t l = b.eat<uint8_t>();

	if (l & 0x80) {
		int lensize = l & 0x7f;
		if (!b.require(lensize))
			return false;
		headerlen += lensize;
		len = 0;
		for (int i = 0; i < lensize; i++) {
			len <<= 8;
			len += b.eat<uint8_t>();
		}
	} else {
		len = l;
	}

	if (hl)
		*hl = headerlen;
	
	return b.require(len);
}

bool object::decode_content(encoding_buffer &buff, int len) {
	return buff.eat(len) != 0;
}

void object::set_type(uint8_t t) {
	type = t;
}

integer::integer()
	: object(0x2), value(0) {}

integer::integer(int v)
	: object(0x2), value(v) {}

integer::integer(const integer &base)
	: object(base.type), value(base.value) {}

int integer::get_length() const {
	return get_integer_length(value);
}

int integer::get_integer_length(int value) {
	register int val = value < 0 ? -value : value;
	if (val & 0x7f000000) {
		return 4;
	} else {
		if (val & 0x007f0000) {
			return 3;
		} else {
			if (val & 0x7f00) {
				return 2;
			} else {
				return 1;
			}
		}
	}
}

bool integer::encode(encoding_buffer &b) const {
	if (!object::encode(b))
		return false;

	int len = get_length();
	for (int i = (len - 1); i >= 0; i--) {
		b.eat<uint8_t>() = (value >> (i * 8)) & 0xff;
	}

	return true;
}

bool integer::encode_integer(encoding_buffer &b, int value) {
	if (!b.require(1))
		return false;

	b.eat<uint8_t>() = value;

	return true;
}

bool integer::decode_integer(encoding_buffer &b, int &value, int &len) {
	if (!b.require(1))
		return false;

	len = 1;
	value = b.eat<uint8_t>();

	return true;
}

bool integer::decode_content(encoding_buffer &b, int len) {
	value = 0;

	if (len == 0)
		return true;
	
	int val = b.eat<uint8_t>();

	for (int i = 1; i < len; i++) {
		val <<= 8;
		val |= b.eat<uint8_t>();
	}

	value = val;

	return true;
}

bool integer::encode_index(std::vector<int> &toks, bool addsize) const {
	int len = get_length();
	if (addsize)
		toks.push_back(len);

	for (int i = (len - 1); i >= 0; i--) {
		toks.push_back((value >> (i * 8)) & 0xff);
	}

	return true;
}

bool integer::decode_index(std::deque<int> &toks, bool eatsize) {
	value = 0;
	
	if (toks.empty())
		return false;

	int val = 0;
	
	if (eatsize) {
		size_t i, len = toks.front();
		toks.pop_front();

		if (len < toks.size())
			return false;

		for (i = 0; i < len; i++) {
			val <<= 8;
			val |= toks.front();
			toks.pop_front();
		}
	} else {
		while (!toks.empty()) {
			val <<= 8;
			val |= toks.front();
			toks.pop_front();
		}
	}

	value = val;

	return true;
}

unsigned32::unsigned32()
	: object(0x42), value(0) {}

unsigned32::unsigned32(uint8_t type)
	: object(type), value(0) {}

unsigned32::unsigned32(const unsigned32 &base)
	: object(base.type), value(base.value) {}

int unsigned32::get_length() const {
	return integer::get_integer_length(value);
}

bool unsigned32::encode(encoding_buffer &b) const {
	if (!object::encode(b))
		return false;

	int len = get_length();
	for (int i = (len - 1); i >= 0; i--) {
		b.eat<uint8_t>() = (value >> (i * 8)) & 0xff;
	}

	return true;
}

bool unsigned32::decode_content(encoding_buffer &b, int len) {
	value = 0;

	if (len == 0)
		return true;
	
	uint32_t val = b.eat<uint8_t>();

	for (int i = 1; i < len; i++) {
		val <<= 8;
		val |= b.eat<uint8_t>();
	}

	value = val;

	return true;
}

sequence::sequence()
	: object(0x30) {
}

sequence::sequence(uint8_t type) 
	: object(type) {
}

sequence::sequence(uint8_t cls, uint8_t tag)
	: object(cls << 6 | (1 << 5) | tag) {
}

octet_string::octet_string()
	: object(0x4) {
}

octet_string::octet_string(const std::string &v)
	: object(0x4) {
	value = std::vector<char>(v.begin(), v.end());
}

octet_string::octet_string(const void *v, size_t len)
	: object(0x4) {
	value = std::vector<char>((const char *)v, ((const char *)v) + len);
}

octet_string::octet_string(const octet_string &base)
	: object(base.type) {
	value = base;
}

bool octet_string::encode(encoding_buffer &b) const {
	if (!object::encode(b))
		return false;

	for (std::vector<char>::const_iterator k = value.begin(); k != value.end(); k++) {
		b.eat<uint8_t>() = *k;
	}

	return true;
}

bool octet_string::decode_content(encoding_buffer &b, int len) {
	value.clear();
	
	for (int i = 0; i < len; i++)
		value.push_back(b.eat<char>());

	return true;
}

bool octet_string::encode_index(std::vector<int> &toks, bool addsize) const {
	if (addsize)
		toks.push_back(value.size());

	for (std::vector<char>::const_iterator k = value.begin(); k != value.end(); k++) {
		toks.push_back(*k);
	}

	return true;
}

bool octet_string::decode_index(std::deque<int> &toks, bool eatsize) {
	value.clear();

	if (toks.empty())
		return false;

	if (eatsize) {
		size_t i, len = toks.front();
		toks.pop_front();

		if (toks.size() < len)
			return false;

		for (i = 0; i < len; i++) {
			value.push_back(toks.front());
			toks.pop_front();
		}
	} else {
		while (!toks.empty()) {
			value.push_back(toks.front());
			toks.pop_front();
		}
	}

	return true;
}



oid::oid()
	: asn::object(6) {
}

oid::oid(const std::string &oid)
	: asn::object(6) {
	const char *ptr = oid.c_str();
	char *end;
	while (1) {
		int tok = strtol(ptr, &end, 10);
		if (ptr == end || *end && *end != '.') {
			seq.clear();
			break;
		}
		seq.push_back(tok);
		if (!*end)
			break;
		ptr = end + 1;
	}
}

oid::oid(const oid &baseoid)
	: asn::object(6), seq(baseoid.seq) {
}

int oid::get_length() const {
	std::vector<int>::const_iterator k = seq.begin();
	int a1 = *k;
	k++;
	int a2 = *k;
	k++;
	
	int len = integer::get_integer_length(a1 * 40 + a2);

	for (; k != seq.end(); k++)
		len += integer::get_integer_length(*k);

	return len;
}

bool oid::encode(asn::encoding_buffer &b) const {
	if (!object::encode(b))
		return false;

	if (seq.size() < 2)
		return false;

	std::vector<int>::const_iterator k = seq.begin();
	int a1 = *k;
	k++;
	int a2 = *k;
	k++;

	if (!asn::integer::encode_integer(b, a1 * 40 + a2))
		return false;

	for (; k != seq.end(); k++) {
		if (!asn::integer::encode_integer(b, *k))
			return false;
	}
	
	return true;
}

bool oid::decode_content(asn::encoding_buffer &b, int len) {
	int i = 0, j;

	int val;
	
	while (i < len) {
		if (!asn::integer::decode_integer(b, val, j))
			return false;
		if (i == 0) {
			seq.push_back(val / 40);
			seq.push_back(val % 40);
		} else {
			seq.push_back(val);
		}
		i += j;
	}

	return i == len;
}

std::ostream &operator << (std::ostream &os, const oid &id) {
	for (std::vector<int>::const_iterator k = id.seq.begin(); k != id.seq.end(); k++) {
		if (k != id.seq.begin())
			os << ".";
		os << *k;
	}
	return os;
}

container::container()
	: object(0) {
	set_to(new null());
}

container::container(object *ct)
	: object(0), contained(ct) {
}

container::container(const container &base)
	: object(0) {
	if (base.contained.get())
		set_to(base.contained->clone());
}

bool any::decode(encoding_buffer &b) {
	uint8_t type;
	int len;

	if (!object::base_decode(b, type, len))
		return false;

	object *obj = ((const any *)this)->instantiate(type);

	if (!obj)
		return false;

	if (!obj->decode_content(b, len)) {
		delete obj;
		return false;
	}

	contained.reset(obj);
	
	return true;
}

bool any::instantiate(int type) {
	object *obj = ((const any *)this)->instantiate(type);

	if (obj) {
		contained.reset(obj);
		return true;
	}

	return false;
}

object *any::instantiate(int type) const {
	switch (type) {
	case 0x2:
		return new integer();
	case 0x4:
		return new octet_string();
	case 0x5:
		return new null();
	case 0x6:
		return new oid();
	case 0x42:
	case 0x43:
		return new unsigned32(type);
	}

	return 0;
}

} // namespace asn

