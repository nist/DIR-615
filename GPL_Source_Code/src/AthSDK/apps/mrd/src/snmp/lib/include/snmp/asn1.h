/*
 * Multicast Routing Daemon (MRD)
 *   asn1.h
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

#ifndef _asn1_h_
#define _asn1_h_

#include <string>
#include <vector>
#include <deque>
#include <iostream>
#include <memory>

#include <stdint.h>

namespace asn {

class encoding_buffer {
public:
	virtual ~encoding_buffer() {}

	virtual bool require(int) const = 0;
	virtual void *eat(int) = 0;
	virtual void *peek(int) const = 0;

	virtual int get_pointer() const = 0;

	template <class T> T &eat() { return *((T *)eat(sizeof(T))); }
	template <class T> const T &peek() const
		{ return *((const T *)peek(sizeof(T))); }
};

class static_encoding_buffer : public encoding_buffer {
public:
	static_encoding_buffer(uint8_t *buffer, int len);

	bool require(int) const;
	void *eat(int);
	void *peek(int) const;

	int get_pointer() const { return pointer; }
	
private:
	uint8_t *buffer;
	int length;
	int pointer;
};

class object {
public:
	virtual ~object() {}

	virtual int get_length() const;
	int get_object_length() const;

	virtual bool encode(encoding_buffer &) const;
	virtual bool decode(encoding_buffer &);
	virtual bool decode_content(encoding_buffer &, int);

	bool base_decode(encoding_buffer &, uint8_t &, int &len, int *hlen = 0);

	virtual uint8_t get_type() const { return type; }
	virtual void set_type(uint8_t);

	virtual bool encode_index(std::vector<int> &, bool) const { return false; }
	virtual bool decode_index(std::deque<int> &, bool) { return false; }

	virtual object *clone() const { return new object(type); }
	
protected:
	explicit object(uint8_t);

	uint8_t type;
};

class integer : public object {
public:
	integer();
	integer(int);
	integer(const integer &);

	static int base_type() { return 0x2; }

	int get_length() const;
	bool encode(encoding_buffer &) const;

	static bool encode_integer(encoding_buffer &, int);
	static bool decode_integer(encoding_buffer &, int &, int &);
	static int get_integer_length(int);

	bool encode_index(std::vector<int> &, bool) const;
	bool decode_index(std::deque<int> &, bool);

	operator int & () { return value; }
	operator const int & () const { return value; }
	
	virtual object *clone() const { return new integer(*this); }

private:
	bool decode_content(encoding_buffer &, int);

	int value;
};

class unsigned32 : public object {
public:
	unsigned32();
	unsigned32(uint8_t);
	unsigned32(const unsigned32 &);

	static int base_type() { return 0x42; }

	int get_length() const;
	bool encode(encoding_buffer &) const;
	bool decode_content(encoding_buffer &, int len);

	operator uint32_t & () { return value; }
	operator const uint32_t & () const { return value; }

	unsigned32 &operator = (uint32_t v) { value = v; return *this; }

	virtual object *clone() const { return new unsigned32(*this); }

private:
	uint32_t value;
};

class octet_string : public object {
public:
	octet_string();
	octet_string(const std::string &);
	octet_string(const void *, size_t);
	octet_string(const octet_string &);

	static int base_type() { return 0x4; }

	int get_length() const { return value.size(); }
	
	operator std::vector<char> &() { return value; }
	operator const std::vector<char> & () const { return value; }

	std::string as_string() const { return std::string(value.begin(), value.end()); }

	octet_string &operator = (const octet_string &v) { value = v.value; return *this; }
	octet_string &operator = (const std::string &v) { value = std::vector<char>(v.begin(), v.end()); return *this; }
	
	bool encode(encoding_buffer &) const;
	bool decode_content(encoding_buffer &, int);

	bool encode_index(std::vector<int> &, bool) const;
	bool decode_index(std::deque<int> &, bool);

	virtual object *clone() const { return new octet_string(*this); }
private:
	std::vector<char> value;
};

class oid : public asn::object {
public:
	oid();
	oid(const std::string &);
	oid(const oid &);

	int get_length() const;
	bool encode(asn::encoding_buffer &) const;
	bool decode_content(asn::encoding_buffer &, int len);

	oid &operator = (const oid &base) { seq = base.seq; return *this; }

	operator const std::vector<int> & () const { return seq; }
	operator std::vector<int> & () { return seq; }

	friend std::ostream &operator << (std::ostream &, const oid &);

	virtual object *clone() const { return new oid(*this); }
private:
	std::vector<int> seq;
};

class sequence : public object {
public:
	sequence();
	sequence(uint8_t type);
	sequence(uint8_t cls, uint8_t tag);

	/*
	int get_length() const;
	bool encode(encoding_buffer &) const;
	bool decode(encoding_buffer &); */
};

template<class T>
class sequence_of_ref : public sequence {
public:
	sequence_of_ref(std::vector<T> &);
	sequence_of_ref(uint8_t type, std::vector<T> &);

	int get_length() const;
	bool encode(encoding_buffer &) const;

	operator const std::vector<T> & () const { return seq; }
	operator std::vector<T> & () { return seq; }

private:
	bool decode_content(encoding_buffer &, int);

	std::vector<T> &seq;
};

template<class T>
inline sequence_of_ref<T>::sequence_of_ref(std::vector<T> &s)
	: sequence(0x30), seq(s) {
}

template<class T>
inline sequence_of_ref<T>::sequence_of_ref(uint8_t type, std::vector<T> &s)
	: sequence(type), seq(s) {
}

template<class T>
inline int sequence_of_ref<T>::get_length() const {
	int len = 0;

	typedef typename std::vector<T>::const_iterator viter;

	for (viter i = seq.begin(); i != seq.end(); i++) {
		len += i->get_object_length();
	}
	return len;
}

template<class T>
inline bool sequence_of_ref<T>::encode(encoding_buffer &b) const {
	if (!object::encode(b))
		return false;

	typedef typename std::vector<T>::const_iterator viter;

	for (viter i = seq.begin(); i != seq.end(); i++) {
		if (!i->encode(b))
			return false;
	}
	
	return true;
}

template<class T>
inline bool sequence_of_ref<T>::decode_content(encoding_buffer &b, int len) {
	int i = 0, j, hl;
	uint8_t enctype;

	while (i < len) {
		seq.push_back(T());

		T &obj = seq.back();
		
		if (!obj.base_decode(b, enctype, j, &hl))
			return false;

		obj.set_type(enctype);

		if (!obj.decode_content(b, j))
			return false;

		i += j + hl;
	}

	return i == len;
}

template<class T>
class sequence_of : public sequence_of_ref<T> {
public:
	sequence_of();
	sequence_of(uint8_t type);

private:
	std::vector<T> seq;
};

template<class T>
inline sequence_of<T>::sequence_of()
	: sequence_of_ref<T>(seq) {
}

template<class T>
inline sequence_of<T>::sequence_of(uint8_t type)
	: sequence_of_ref<T>(type, seq) {
}

class null : public object {
public:
	null() : object(5) {}
};

class container : public object {
public:
	container();
	container(object *);
	container(const container &);

	object *operator->() { return contained.get(); }
	const object *operator->() const { return contained.get(); }

	object &operator*() { return *contained; }
	const object &operator*() const { return *contained; }

	int get_length() const { return contained->get_length(); }

	void set_to(object *obj) { contained.reset(obj); }

	bool encode(encoding_buffer &b) const { return contained->encode(b); }
	bool decode_content(encoding_buffer &b, int l) { return contained->decode_content(b, l); }

	virtual object *clone() const { return new container(*this); }

protected:
	std::auto_ptr<object> contained;
};

class any : public container {
public:
	any() : container() {}
	any(const any &base) : container(base) {}

	bool decode(encoding_buffer &);

	bool instantiate(int);

	template<class T, class V>
	bool instantiate_with(const V &v) {
		if (!instantiate(T::base_type()))
			return false;
		((T &)*contained) = v;
		return true;
	}

protected:
	virtual object *instantiate(int) const;
};

class choice : public any {
public:

protected:
	virtual object *instantiate(int) const { return 0; }
};

} // namespace asn

#endif

