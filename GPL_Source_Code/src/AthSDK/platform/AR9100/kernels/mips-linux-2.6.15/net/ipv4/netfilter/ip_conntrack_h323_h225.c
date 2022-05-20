/*
 * H.323/H.225 connection tracking helper
 * (c) 2005 Max Kellermann <max@duempel.org>
 *
 * Uses Sampsa Ranta's excellent idea on using expectfn to 'bind'
 * the unregistered helpers to the conntrack entries.
 */


#include <linux/module.h>
#include <linux/netfilter.h>
#include <linux/ip.h>
#include <net/checksum.h>
#include <net/tcp.h>

#include <linux/netfilter_ipv4/ip_conntrack.h>
#include <linux/netfilter_ipv4/ip_conntrack_core.h>
#include <linux/netfilter_ipv4/ip_conntrack_helper.h>
#include <linux/netfilter_ipv4/ip_conntrack_tuple.h>
#include <linux/netfilter_ipv4/ip_conntrack_h323.h>

#include "asn1_per.h"

/* This is slow, but it's simple. --RR */
static char h225_buffer[65536];

static DEFINE_SPINLOCK(ip_h225_lock);

int (*ip_nat_h225_hook)(struct sk_buff **pskb,
			enum ip_conntrack_info ctinfo,
			unsigned int offset,
			struct ip_conntrack_expect *exp);
EXPORT_SYMBOL_GPL(ip_nat_h225_hook);

void (*ip_nat_h225_signal_hook)(struct sk_buff **pskb,
				struct ip_conntrack *ct,
				enum ip_conntrack_info ctinfo,
				unsigned int offset,
				int dir,
				int orig_dir);
EXPORT_SYMBOL_GPL(ip_nat_h225_signal_hook);

#if 0
#define DEBUGP printk
#else
#define DEBUGP(format, args...)
#endif

unsigned int sourceaddress;
u_int16_t port_ext;


/**
 * Parse an H.225 TransportAddress and return the position of the IP
 * address (if present). Returns 1 on success.
 */
static int h225_parse_transport_address(struct asn1_per_buffer *bb, unsigned *i,
					u_int32_t *ip, u_int16_t *port) {
	unsigned choice, after;

	choice = asn1_per_read_choice_header(bb, 1, 7, &after);
	if (bb->error)
		return 0;

	switch (choice) {
	case 0: /* ipAddress */
		asn1_per_byte_align(bb);
		*i = bb->i;
		asn1_per_read_bytes(bb, ip, sizeof(*ip));
		asn1_per_read_bytes(bb, port, sizeof(*port));
		return !bb->error;

	default:
		if (after == 0) {
			DEBUGP("TransportAddress %u not yet supported\n", choice);
			bb->error = 1;
		} else {
			bb->i = after;
		}
		return 0;
	}
}


unsigned char h225_sAddress_patten[] ={0xcd,0x0d,0x98,0x00,0x07,0x00};
static int update_h225_sourceCallsignalAddress(struct sk_buff *skb, struct asn1_per_buffer *bb, unsigned long address)
{
	int ret = 0;
	int  tcp_len;
		
	
	*(unsigned long *)&bb->data[bb->i] = address;
	DEBUGP("H.225 transportAddress: %u.%u.%u.%u\n", NIPQUAD(address));
	skb->h.raw = skb->nh.raw + (skb->nh.iph->ihl * 4);
	skb->nh.iph->check = 0;
	skb->nh.iph->check = ip_fast_csum((unsigned char *)skb->nh.iph,skb->nh.iph->ihl);
	skb->h.th->check = 0;
	tcp_len = htons(skb->nh.iph->tot_len) -(skb->nh.iph->ihl * 4);
		
	skb->h.th->check = tcp_v4_check(skb->h.th,tcp_len ,
			   skb->nh.iph->saddr,
			   skb->nh.iph->daddr,
			   csum_partial((char *)skb->h.th,
					tcp_len, 0));	
	return ret;	 	
}


	
static int h225_parse_setup_uuie(struct sk_buff **pskb,
				   struct ip_conntrack *ct,
				   enum ip_conntrack_info ctinfo,
				   struct asn1_per_buffer *bb) {
				   	
	struct asn1_per_sequence_header hdr;
	int ret;
	int pos = 0;
	int  tcp_len;
	u_int32_t ip;	
	int dir = CTINFO2DIR(ctinfo);
	u_int16_t port;

	struct ip_conntrack_expect *exp;

	port_ext = 0;

	asn1_per_read_sequence_header(bb, 1, 1, &hdr);
	/* protocolIdentifier */
	asn1_per_skip_object_id(bb);
	
	for(pos = bb->i; pos < bb->length; pos ++){
		if(!memcmp(&bb->data[pos], h225_sAddress_patten, sizeof(h225_sAddress_patten))){
			bb->i = (pos + sizeof(h225_sAddress_patten));
		 	ret = 1;
		 	break;
		 }	
	}
	
	ip = *(unsigned long *)&bb->data[bb->i];
	port = *(unsigned short *)&bb->data[bb->i+ sizeof(unsigned long)];
	DEBUGP("create H.245 expection: dir = %u.%u.%u.%u - %u.%u.%u.%u  !dir = %u.%u.%u.%u - %u.%u.%u.%u \n", NIPQUAD(ct->tuplehash[dir].tuple.src.ip),
								       				 NIPQUAD(ct->tuplehash[dir].tuple.dst.ip),
								       				 NIPQUAD(ct->tuplehash[!dir].tuple.src.ip),
								       				 NIPQUAD(ct->tuplehash[!dir].tuple.dst.ip)
	);	
	if (port == 15332)  /* just for i2eye */
		port_ext = 15329;
	else
		port_ext = port + 1;	
			
	ret = update_h225_sourceCallsignalAddress(*pskb, bb, sourceaddress);
	
	if (ip == ct->tuplehash[dir].tuple.src.ip) {
			/* match found: create an expectation */
			exp = ip_conntrack_expect_alloc(ct);
			if (exp == NULL)
				return NF_ACCEPT;

			exp->tuple = ((struct ip_conntrack_tuple)
					{ { ct->tuplehash[dir].tuple.src.ip,
					    { .tcp = { port_ext} } },
					  { ct->tuplehash[dir].tuple.dst.ip,
					    { 0 },
					    IPPROTO_TCP }});
			exp->mask = ((struct ip_conntrack_tuple)
					{ { 0xFFFFFFFF,  { .tcp = { 0xFFFF } }},
					  { 0xFFFFFFFF, { 0 }, 0xFF }});

			exp->expectfn = ip_conntrack_h245_expect;
			exp->master = ct;		


			ip_conntrack_expect_related(exp);
			DEBUGP("create H.245 expection: dir = %u.%u.%u.%u:%u - %u.%u.%u.%u:%u  src port = %u\n", NIPQUAD(exp->tuple.src.ip),ntohs(exp->tuple.src.u.tcp.port),
										       		       NIPQUAD(exp->tuple.dst.ip),ntohs(exp->tuple.dst.u.tcp.port)
										       		       										       				 
			);
			return ret;
	}	

	return ret;
	
	
}	
/**
 * Parse a H.225 Connect-UUIE packet and handle NAT/expectations for
 * the H.245 transport address.
 */
static int h225_parse_connect_uuie(struct sk_buff **pskb,
				   struct ip_conntrack *ct,
				   enum ip_conntrack_info ctinfo,
				   struct asn1_per_buffer *bb) {
	struct asn1_per_sequence_header hdr;

	asn1_per_read_sequence_header(bb, 1, 1, &hdr);

	/* protocolIdentifier */
	asn1_per_skip_object_id(bb);

	/* h245Address */
	if (asn1_per_bitmap_get(&hdr.present, 0)) {
		int dir = CTINFO2DIR(ctinfo);
		struct ip_conntrack_expect *exp, *exp1;
		int ret;
		unsigned i;
		u_int32_t ip;
		u_int16_t port;

		ret = h225_parse_transport_address(bb, &i, &ip, &port);
		if (ret) {
			DEBUGP("H.245 transportAddress: %u.%u.%u.%u:%u\n",
			       NIPQUAD(ip), ntohs(port));
		}
		
		if (ret && ip == ct->tuplehash[dir].tuple.src.ip) {
			
			/*delete old expect first */
			exp1 = ip_conntrack_expect_alloc(ct);
			if (exp1 == NULL)
				return NF_ACCEPT;

			exp1->tuple = ((struct ip_conntrack_tuple)
					{ { ct->tuplehash[!dir].tuple.src.ip,
					    { .tcp = { port_ext} } },
					  { ct->tuplehash[!dir].tuple.dst.ip,
					    { 0 },
					    IPPROTO_TCP }});
			exp1->mask = ((struct ip_conntrack_tuple)
					{ { 0xFFFFFFFF,  { .tcp = { 0xFFFF } }},
					  { 0xFFFFFFFF, { 0 }, 0xFF }});

			exp1->expectfn = ip_conntrack_h245_expect;
			exp1->master = ct;				
			
			ip_conntrack_unexpect_related(exp1);			
			/* delete end */
			
			/* match found: create an expectation */
			exp = ip_conntrack_expect_alloc(ct);
			if (exp == NULL)
				return NF_ACCEPT;

			exp->tuple = ((struct ip_conntrack_tuple)
					{ { ct->tuplehash[!dir].tuple.src.ip,
					    { 0 } },
					  { ct->tuplehash[!dir].tuple.dst.ip,
					    { .tcp = { port } },
					    IPPROTO_TCP }});
			exp->mask = ((struct ip_conntrack_tuple)
					{ { 0xFFFFFFFF, { 0 } },
					  { 0xFFFFFFFF, { .tcp = { 0xFFFF } }, 0xFF }});

			exp->expectfn = ip_conntrack_h245_expect;
			exp->master = ct;

			/* call NAT hook and register expectation */
			if (ip_nat_h225_hook != NULL) {
				ret = ip_nat_h225_hook(pskb, ctinfo, i,
						       exp);
			} else {
				/* Can't expect this?  Best to drop packet now. */
				if (ip_conntrack_expect_related(exp) != 0) {
					ret = NF_DROP;
				} else {
					ret = NF_ACCEPT;
				}
			}

			ip_conntrack_expect_put(exp);

			return ret;
		}
	}

	/* XXX */
	bb->error = 1;

	asn1_per_skip_sequence_extension(bb, &hdr);

	return NF_ACCEPT;
}

/**
 * Parse a H.225 H323-UU-PDU packet and handle NAT/expectations for
 * the H.245 transport address.
 */
static int h225_parse_uu_pdu(struct sk_buff **pskb,
			     struct ip_conntrack *ct,
			     enum ip_conntrack_info ctinfo,
			     struct asn1_per_buffer *bb) {
	struct asn1_per_sequence_header hdr;
	unsigned choice, after;
	int ret;

	asn1_per_read_sequence_header(bb, 1, 1, &hdr);

	/* h323-message-body */
	choice = asn1_per_read_choice_header(bb, 1, 7, &after);
	switch (choice) {
	case 0: /* setup */
	
		ret = h225_parse_setup_uuie(pskb, ct, ctinfo, bb);
		break;
						
	case 2: /* connect */
		ret = h225_parse_connect_uuie(pskb, ct, ctinfo, bb);
		if (ret != NF_ACCEPT)
			return ret;
		break;

	default:
		if (after == 0) {
			bb->error = 1;
			return NF_ACCEPT;
		}

		bb->i = after;
	}

	asn1_per_skip_sequence_extension(bb, &hdr);

	return NF_ACCEPT;
}

/**
 * Parse a H.225 packet and handle NAT/expectations for the H.245
 * transport address.
 */
static int h225_parse(struct sk_buff **pskb,
		      struct ip_conntrack *ct,
		      enum ip_conntrack_info ctinfo,
		      struct asn1_per_buffer *bb) {
	struct asn1_per_sequence_header hdr;

	asn1_per_read_sequence_header(bb, 1, 1, &hdr);

	return h225_parse_uu_pdu(pskb, ct, ctinfo, bb);
}

/**
 * Parse a Q.931 CONNECT packet and handle NAT/expectations for the
 * H.245 transport address.
 */
static int h225_parse_q931_connect(struct sk_buff **pskb,
				   struct ip_conntrack *ct,
				   enum ip_conntrack_info ctinfo,
				   const unsigned char *data,
				   unsigned i, unsigned length)
{
	struct asn1_per_buffer bb;

	if (i + 2 > length)
		return NF_ACCEPT;

	if (data[i++] != 0x05) /* X.208 / X.209 */
		return NF_ACCEPT;

	asn1_per_initialize(&bb, data, length, i);

	return h225_parse(pskb, ct, ctinfo, &bb);
}

/**
 * Scan a Q.931 packet for a user-to-user information element
 * (IE). Return the index, or 0 if none found.
 */
static unsigned q931_find_u2u(const unsigned char *data,
			      unsigned datalen,
			      unsigned int i,
			      unsigned *lengthp) {
	unsigned char type;
	unsigned length;

	/* traverse all Q.931 information elements (IE) */
	while (i + 2 <= datalen) {
		type = data[i++];

		/* highest bit set means one-byte IE */
		if (type & 0x80)
			continue;

		length = data[i++];

		if (type == 0x7e) { /* user-to-user */
			/* user-to-user IEs have a 16 bit length
			   field */
			length = (length << 8) | data[i++];
			if (i + length > datalen)
				return 0;

			*lengthp = length;
			return i;
		}

		i += length;
	}

	return 0;
}

/**
 * Parse a Q.931/H.225 packet and handle NAT/expectations for the
 * H.245 transport address (if applicable).
 */
static int h225_parse_q931(struct sk_buff **pskb,
			   struct ip_conntrack *ct,
			   enum ip_conntrack_info ctinfo,
			   const unsigned char *data,
			   unsigned datalen, unsigned i) {
	u_int8_t q931_message_type;
	unsigned length;

	if (i + 3 > datalen)
		return NF_ACCEPT;

	/* parse Q.931 packet */
	if (data[i++] != 0x08) /* protocol discriminator */
		return NF_ACCEPT;

	/* call reference */
	i += 1 + data[i];
	if (i >= datalen)
		return NF_ACCEPT;

	/* only some Q.931 message types can contain a H.245 transport
	   address - we can ignore the rest in this module */
	q931_message_type = data[i++];
	if (q931_message_type == 0x07 || q931_message_type == 0x05 || q931_message_type == 0x01) {
		/* CONNECT */		 /* SETUP */			 /*alerting*/
		DEBUGP("ct_h225_help: q931_message_type = %x\n", q931_message_type);
		/* find a user-to-user information element (IE) */
		i = q931_find_u2u(data, datalen, i, &length);
		if (i == 0)
			return NF_ACCEPT;

		/* the length returned by q931_find_u2u() is relative
		   to i */
		length += i;

		return h225_parse_q931_connect(pskb, ct, ctinfo,
					       data, i, length);
	} else {
		/* XXX handle q931_message_type 0x01, 0x02, 0x03 */
		return NF_ACCEPT;
	}
}

/**
 * Parse a TPKT/Q.931/H.225 packet and handle NAT/expectations for the
 * H.245 transport address (if applicable).
 */
static int h225_parse_tpkt(struct sk_buff **pskb,
			   struct ip_conntrack *ct,
			   enum ip_conntrack_info ctinfo,
			   const unsigned char *data,
			   unsigned datalen) {
	unsigned int i = 0;
	u_int16_t tpkt_len;

	if (i + 4 > datalen)
		return NF_ACCEPT;

	/* expect TPKT header, see RFC 1006 */
	if (data[0] != 0x03 || data[1] != 0x00)
		return NF_ACCEPT;

	i += 2;

	tpkt_len = ntohs(*(u_int16_t*)(data + i));
	if (tpkt_len < datalen)
		datalen = tpkt_len;

	i += 2;

	/* parse Q.931 packet */
	return h225_parse_q931(pskb, ct, ctinfo,
			       data, datalen, i);
}

static int h225_help(struct sk_buff **pskb,
		     struct ip_conntrack *ct,
		     enum ip_conntrack_info ctinfo)
{
	struct tcphdr _tcph, *tcph;
	unsigned char *data;
	unsigned dataoff, datalen;
	int ret = NF_ACCEPT;

	/* Until there's been traffic both ways, don't look in packets. */
	if (ctinfo != IP_CT_ESTABLISHED
	    && ctinfo != IP_CT_ESTABLISHED + IP_CT_IS_REPLY) {
		DEBUGP("ct_h225_help: Conntrackinfo = %u\n", ctinfo);
		return NF_ACCEPT;
	}

	tcph = skb_header_pointer((*pskb), (*pskb)->nh.iph->ihl*4,
				  sizeof(_tcph), &_tcph);
	if (tcph == NULL)
		return NF_ACCEPT;

	DEBUGP("ct_h225_help: help entered %u.%u.%u.%u:%u->%u.%u.%u.%u:%u\n",
		NIPQUAD((*pskb)->nh.iph->saddr), ntohs(tcph->source),
		NIPQUAD((*pskb)->nh.iph->daddr), ntohs(tcph->dest));

	sourceaddress = (*pskb)->nh.iph->saddr;	
	

	dataoff = (*pskb)->nh.iph->ihl*4 + tcph->doff*4;
	/* No data? */
	if (dataoff >= (*pskb)->len) {
		DEBUGP("ct_h225_help: skblen = %u\n", (*pskb)->len);
		return NF_ACCEPT;
	}
	datalen = (*pskb)->len - dataoff;

	if (datalen < 16)
		return NF_ACCEPT;

	/* get data portion, and evaluate it */
	spin_lock_bh(&ip_h225_lock);
	data = skb_header_pointer((*pskb), dataoff,
				  datalen, h225_buffer);
	BUG_ON(data == NULL);

	ret = h225_parse_tpkt(pskb, ct, ctinfo,
			      data, datalen);

	spin_unlock_bh(&ip_h225_lock);
	return ret;
}

struct ip_conntrack_helper ip_conntrack_helper_h225 =
{
	.list = { NULL, NULL },
	.name = "H.225",
	.me = THIS_MODULE,
	.max_expected = 2,
	.timeout = 240,
	.tuple = { .src = { .ip = 0, 
		 	    .u = { .tcp = { .port =  
				    __constant_htons(H225_PORT) } } 
			  }, 
		   .dst = { .ip = 0, 
			    .u = { .all = 0 },
			    .protonum = IPPROTO_TCP
			  } 
		 },
	.mask = { .src = { .ip = 0, 
			   .u = { .tcp = { .port = __constant_htons(0xffff) } } 
			 }, 
		  .dst = { .ip = 0, 
			   .u = { .all = 0 },
			   .protonum = 0xff 
		 	 } 
		},		 	
	.help = h225_help
};
EXPORT_SYMBOL_GPL(ip_conntrack_helper_h225);
