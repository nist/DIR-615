/*
 * RTSP extension for IP connection tracking
 * (C) 2003 by Tom Marshall <tmarshall@real.com>
 * based on ip_conntrack_irc.c
 *
 *      This program is free software; you can redistribute it and/or
 *      modify it under the terms of the GNU General Public License
 *      as published by the Free Software Foundation; either version
 *      2 of the License, or (at your option) any later version.
 *
 * Module load syntax:
 *   insmod ip_conntrack_rtsp.o ports=port1,port2,...port<MAX_PORTS>
 *                              max_outstanding=n setup_timeout=secs
 *
 * If no ports are specified, the default will be port 554.
 *
 * With max_outstanding you can define the maximum number of not yet
 * answered SETUP requests per RTSP session (default 8).
 * With setup_timeout you can specify how long the system waits for
 * an expected data channel (default 300 seconds).
 *
 * 2005-02-13: Harald Welte <laforge@netfilter.org>
 * 	- port to 2.6
 * 	- update to recent post-2.6.11 api changes
 */

#include <linux/config.h>
#include <linux/module.h>
#include <linux/netfilter.h>
#include <linux/ip.h>
#include <net/checksum.h>
#include <net/tcp.h>

#include <linux/netfilter_ipv4/ip_conntrack_helper.h>
#include <linux/netfilter_ipv4/ip_conntrack_rtsp.h>

#include <linux/ctype.h>
#define NF_NEED_STRNCASECMP
#define NF_NEED_STRTOU16
#define NF_NEED_STRTOU32
#define NF_NEED_NEXTLINE
#include <linux/netfilter_helpers.h>
#define NF_NEED_MIME_NEXTLINE
#include <linux/netfilter_mime.h>

#define MAX_SIMUL_SETUP 8 /* XXX: use max_outstanding */
#define INFOP(fmt, args...) printk(KERN_INFO "%s: %s: " fmt, __FILE__, __FUNCTION__ , ## args)
#ifdef IP_NF_RTSP_DEBUG
#define DEBUGP(fmt, args...) printk("%s: %s: " fmt, __FILE__, __FUNCTION__ , ## args)
#else
#define DEBUGP(fmt, args...)
#endif

#define MAX_PORTS 8
static int ports[MAX_PORTS];
static int num_ports = 0;
static int max_outstanding = 8;
static unsigned int setup_timeout = 300;

MODULE_AUTHOR("Tom Marshall <tmarshall@real.com>");
MODULE_DESCRIPTION("RTSP connection tracking module");
MODULE_LICENSE("GPL");
module_param_array(ports, int, &num_ports, 0400);
MODULE_PARM_DESC(ports, "port numbers of RTSP servers");
module_param(max_outstanding, int, 0400);
MODULE_PARM_DESC(max_outstanding, "max number of outstanding SETUP requests per RTSP session");
module_param(setup_timeout, int, 0400);
MODULE_PARM_DESC(setup_timeout, "timeout on for unestablished data channels");

static char rtsp_buffer[65536];
static DEFINE_SPINLOCK(rtsp_buffer_lock);

//unsigned int (*ip_nat_rtsp_hook)(struct sk_buff **pskb,
//				 enum ip_conntrack_info ctinfo,
//				 struct ip_ct_rtsp_expect *expinfo,
//				 struct ip_conntrack_expect *exp);
unsigned int (*ip_nat_rtsp_hook)(struct sk_buff **pskb,
 				 enum ip_conntrack_info ctinfo,
				 unsigned int matchoff, unsigned int matchlen,struct ip_ct_rtsp_expect* prtspexp,
 				 struct ip_conntrack_expect *exp);
 				 
void (*ip_nat_rtsp_hook_expectfn)(struct ip_conntrack *ct, struct ip_conntrack_expect *exp);				 
EXPORT_SYMBOL_GPL(ip_nat_rtsp_hook);
EXPORT_SYMBOL(ip_nat_rtsp_hook_expectfn);

/*
 * Max mappings we will allow for one RTSP connection (for RTP, the number
 * of allocated ports is twice this value).  Note that SMIL burns a lot of
 * ports so keep this reasonably high.  If this is too low, you will see a
 * lot of "no free client map entries" messages.
 */
#define MAX_PORT_MAPS 16

/*** default port list was here in the masq code: 554, 3030, 4040 ***/

#define SKIP_WSPACE(ptr,len,off) while(off < len && isspace(*(ptr+off))) { off++; }

/*
 * Parse an RTSP packet.
 *
 * Returns zero if parsing failed.
 *
 * Parameters:
 *  IN      ptcp        tcp data pointer
 *  IN      tcplen      tcp data len
 *  IN/OUT  ptcpoff     points to current tcp offset
 *  OUT     phdrsoff    set to offset of rtsp headers
 *  OUT     phdrslen    set to length of rtsp headers
 *  OUT     pcseqoff    set to offset of CSeq header
 *  OUT     pcseqlen    set to length of CSeq header
 */
#if 0 
static int
rtsp_parse_message(char* ptcp, uint tcplen, uint* ptcpoff,
                   uint* phdrsoff, uint* phdrslen,
                   uint* pcseqoff, uint* pcseqlen)
{
    uint    entitylen = 0;
    uint    lineoff;
    uint    linelen;

    if (!nf_nextline(ptcp, tcplen, ptcpoff, &lineoff, &linelen))
    {
        return 0;
    }

    *phdrsoff = *ptcpoff;
    while (nf_mime_nextline(ptcp, tcplen, ptcpoff, &lineoff, &linelen))
    {
        if (linelen == 0)
        {
            if (entitylen > 0)
            {
                *ptcpoff += min(entitylen, tcplen - *ptcpoff);
            }
            break;
        }
        if (lineoff+linelen > tcplen)
        {
            INFOP("!! overrun !!\n");
            break;
        }

        if (nf_strncasecmp(ptcp+lineoff, "CSeq:", 5) == 0)
        {
            *pcseqoff = lineoff;
            *pcseqlen = linelen;
        }
        if (nf_strncasecmp(ptcp+lineoff, "Content-Length:", 15) == 0)
        {
            uint off = lineoff+15;
            SKIP_WSPACE(ptcp+lineoff, linelen, off);
            nf_strtou32(ptcp+off, &entitylen);
        }
    }
    *phdrslen = (*ptcpoff) - (*phdrsoff);

    return 1;
}
#else
 static int
 rtsp_parse_message(char* ptcp, uint tcplen, uint* ptcpoff,
                    uint* phdrsoff, uint* phdrslen,
                   uint* pcseqoff, uint* pcseqlen,
                   uint* transoff, uint* translen)
{
	uint    entitylen = 0;
	uint    lineoff;
	uint    linelen;
	
	if (!nf_nextline(ptcp, tcplen, ptcpoff, &lineoff, &linelen))
		return 0;
	
	*phdrsoff = *ptcpoff;
	while (nf_mime_nextline(ptcp, tcplen, ptcpoff, &lineoff, &linelen)) {
		if (linelen == 0) {
			if (entitylen > 0)
				*ptcpoff += min(entitylen, tcplen - *ptcpoff);
			break;
		}
		if (lineoff+linelen > tcplen) {
			INFOP("!! overrun !!\n");
			break;
		}
		
		if (nf_strncasecmp(ptcp+lineoff, "CSeq:", 5) == 0) {
			*pcseqoff = lineoff;
			*pcseqlen = linelen;
		} 

		if (nf_strncasecmp(ptcp+lineoff, "Transport:", 10) == 0) {
			*transoff = lineoff;
			*translen = linelen;
		}
		
		if (nf_strncasecmp(ptcp+lineoff, "Content-Length:", 15) == 0) {
			uint off = lineoff+15;
			SKIP_WSPACE(ptcp+lineoff, linelen, off);
			nf_strtou32(ptcp+off, &entitylen);
		}
	}
	*phdrslen = (*ptcpoff) - (*phdrsoff);
	
	return 1;
 }
#endif
/*
 * Find lo/hi client ports (if any) in transport header
 * In:
 *   ptcp, tcplen = packet
 *   tranoff, tranlen = buffer to search
 *
 * Out:
 *   pport_lo, pport_hi = lo/hi ports (host endian)
 *
 * Returns nonzero if any client ports found
 *
 * Note: it is valid (and expected) for the client to request multiple
 * transports, so we need to parse the entire line.
 */
#if 0 
static int
rtsp_parse_transport(char* ptran, uint tranlen,
                     struct ip_ct_rtsp_expect* prtspexp)
{
    int     rc = 0;
    uint    off = 0;

    if (tranlen < 10 || !iseol(ptran[tranlen-1]) ||
        nf_strncasecmp(ptran, "Transport:", 10) != 0)
    {
        INFOP("sanity check failed\n");
        return 0;
    }
    DEBUGP("tran='%.*s'\n", (int)tranlen, ptran);
    off += 10;
    SKIP_WSPACE(ptran, tranlen, off);

    /* Transport: tran;field;field=val,tran;field;field=val,... */
    while (off < tranlen)
    {
        const char* pparamend;
        uint        nextparamoff;

        pparamend = memchr(ptran+off, ',', tranlen-off);
        pparamend = (pparamend == NULL) ? ptran+tranlen : pparamend+1;
        nextparamoff = pparamend-ptran;

        while (off < nextparamoff)
        {
            const char* pfieldend;
            uint        nextfieldoff;

            pfieldend = memchr(ptran+off, ';', nextparamoff-off);
            nextfieldoff = (pfieldend == NULL) ? nextparamoff : pfieldend-ptran+1;

            if (strncmp(ptran+off, "client_port=", 12) == 0)
            {
                u_int16_t   port;
                uint        numlen;

                off += 12;
                numlen = nf_strtou16(ptran+off, &port);
                off += numlen;
                if (prtspexp->loport != 0 && prtspexp->loport != port)
                {
                    DEBUGP("multiple ports found, port %hu ignored\n", port);
                }
                else
                {
                    prtspexp->loport = prtspexp->hiport = port;
                    if (ptran[off] == '-')
                    {
                        off++;
                        numlen = nf_strtou16(ptran+off, &port);
                        off += numlen;
                        prtspexp->pbtype = pb_range;
                        prtspexp->hiport = port;

                        // If we have a range, assume rtp:
                        // loport must be even, hiport must be loport+1
                        if ((prtspexp->loport & 0x0001) != 0 ||
                            prtspexp->hiport != prtspexp->loport+1)
                        {
                            DEBUGP("incorrect range: %hu-%hu, correcting\n",
                                   prtspexp->loport, prtspexp->hiport);
                            prtspexp->loport &= 0xfffe;
                            prtspexp->hiport = prtspexp->loport+1;
                        }
                    }
                    else if (ptran[off] == '/')
                    {
                        off++;
                        numlen = nf_strtou16(ptran+off, &port);
                        off += numlen;
                        prtspexp->pbtype = pb_discon;
                        prtspexp->hiport = port;
                    }
                    rc = 1;
                }
            }

            /*
             * Note we don't look for the destination parameter here.
             * If we are using NAT, the NAT module will handle it.  If not,
             * and the client is sending packets elsewhere, the expectation
             * will quietly time out.
             */

            off = nextfieldoff;
        }

        off = nextparamoff;
    }

    return rc;
}
#else
static int
rtsp_parse_transport(char* ptran, uint tranlen,
                      struct ip_ct_rtsp_expect* prtspexp)
{
	int     rc = 0;
	uint    off = 0;
	
	if (tranlen < 10 || !iseol(ptran[tranlen-1]) ||
	    nf_strncasecmp(ptran, "Transport:", 10) != 0) {
		INFOP("sanity check failed\n");
		return 0;
	}
	
	DEBUGP("tran='%.*s'\n", (int)tranlen, ptran);
	off += 10;
	SKIP_WSPACE(ptran, tranlen, off);
	
	/* Transport: tran;field;field=val,tran;field;field=val,... */
	while (off < tranlen) {
		const char* pparamend;
		uint        nextparamoff;
		
		pparamend = memchr(ptran+off, ',', tranlen-off);
		pparamend = (pparamend == NULL) ? ptran+tranlen : pparamend+1;
		nextparamoff = pparamend-ptran;
		
		while (off < nextparamoff) {
			const char* pfieldend;
			uint        nextfieldoff;
			
			pfieldend = memchr(ptran+off, ';', nextparamoff-off);
			nextfieldoff = (pfieldend == NULL) ? nextparamoff : pfieldend-ptran+1;
		   
			if (strncmp(ptran+off, "client_port=", 12) == 0) {
				u_int16_t   port;
				uint        numlen;
		    
				off += 12;
				numlen = nf_strtou16(ptran+off, &port);
				off += numlen;
				if (prtspexp->loport != 0 && prtspexp->loport != port)
					DEBUGP("multiple ports found, port %hu ignored\n", port);
				else {
					DEBUGP("lo port found : %hu\n", port);
					prtspexp->loport = prtspexp->hiport = port;
					if (ptran[off] == '-') {
						off++;
						numlen = nf_strtou16(ptran+off, &port);
						off += numlen;
						prtspexp->pbtype = pb_range;
						prtspexp->hiport = port;
						
						// If we have a range, assume rtp:
						// loport must be even, hiport must be loport+1
						if ((prtspexp->loport & 0x0001) != 0 ||
						    prtspexp->hiport != prtspexp->loport+1) {
							DEBUGP("incorrect range: %hu-%hu, correcting\n",
							       prtspexp->loport, prtspexp->hiport);
							prtspexp->loport &= 0xfffe;
							prtspexp->hiport = prtspexp->loport+1;
						}
					} else if (ptran[off] == '/') {
						off++;
						numlen = nf_strtou16(ptran+off, &port);
						off += numlen;
						prtspexp->pbtype = pb_discon;
						prtspexp->hiport = port;
					}
					rc = 1;
				}
			}
			
			/*
			 * Note we don't look for the destination parameter here.
			 * If we are using NAT, the NAT module will handle it.  If not,
			 * and the client is sending packets elsewhere, the expectation
			 * will quietly time out.
			 */
			
			off = nextfieldoff;
		}
	
		off = nextparamoff;
	}
	
	return rc;
}
#endif
/*** conntrack functions ***/
void expected(struct ip_conntrack* ct, struct ip_conntrack_expect *exp)
{
    if(ip_nat_rtsp_hook_expectfn) {
        ip_nat_rtsp_hook_expectfn(ct,exp);
     }

}

/* outbound packet: client->server */
static inline int
#if 0
help_out(struct sk_buff **pskb, unsigned char *rb_ptr, unsigned int datalen,
                struct ip_conntrack* ct, enum ip_conntrack_info ctinfo)
{
    struct ip_ct_rtsp_expect expinfo;
    int dir = CTINFO2DIR(ctinfo);   /* = IP_CT_DIR_ORIGINAL */
    //struct  tcphdr* tcph = (void*)iph + iph->ihl * 4;
    //uint    tcplen = pktlen - iph->ihl * 4;
    char*   pdata = rb_ptr;
    //uint    datalen = tcplen - tcph->doff * 4;
    uint    dataoff = 0;
    int ret = NF_ACCEPT;

    struct ip_conntrack_expect *exp;

    memset(&expinfo, 0, sizeof(expinfo));

    while (dataoff < datalen)
    {
        uint    cmdoff = dataoff;
        uint    hdrsoff = 0;
        uint    hdrslen = 0;
        uint    cseqoff = 0;
        uint    cseqlen = 0;
        uint    lineoff = 0;
        uint    linelen = 0;
        uint    off;

        if (!rtsp_parse_message(pdata, datalen, &dataoff,
                                &hdrsoff, &hdrslen,
                                &cseqoff, &cseqlen))
        {
            break;      /* not a valid message */
        }

        if (strncmp(pdata+cmdoff, "SETUP ", 6) != 0)
        {
            continue;   /* not a SETUP message */
        }
        DEBUGP("found a setup message\n");

        off = 0;
        while (nf_mime_nextline(pdata+hdrsoff, hdrslen, &off,
                                &lineoff, &linelen))
        {
            if (linelen == 0)
            {
                break;
            }
            if (off > hdrsoff+hdrslen)
            {
                INFOP("!! overrun !!");
                break;
            }

            if (nf_strncasecmp(pdata+hdrsoff+lineoff, "Transport:", 10) == 0)
            {
                rtsp_parse_transport(pdata+hdrsoff+lineoff, linelen, &expinfo);
            }
        }

        if (expinfo.loport == 0)
        {
            DEBUGP("no udp transports found\n");
            continue;   /* no udp transports found */
        }

        DEBUGP("udp transport found, ports=(%d,%hu,%hu)\n",
              (int)expinfo.pbtype,
              expinfo.loport,
              expinfo.hiport);

	exp = ip_conntrack_expect_alloc(ct);
	if (!exp) {
		ret = NF_DROP;
		goto out;
	}

        //exp->seq = ntohl(tcph->seq) + hdrsoff; /* mark all the headers */
	exp->master = ct;
        //exp.help.exp_rtsp_info.len = hdrslen;

        exp->tuple.src.ip = ct->tuplehash[!dir].tuple.src.ip;
        exp->mask.src.ip  = 0xffffffff;
        exp->tuple.dst.ip = ct->tuplehash[dir].tuple.src.ip;
        exp->mask.dst.ip  = 0xffffffff;
        exp->tuple.dst.u.udp.port = expinfo.loport;
        exp->mask.dst.u.udp.port  = 
		(expinfo.pbtype == pb_range) ? 0xfffe : 0xffff;
        exp->tuple.dst.protonum = IPPROTO_UDP;
        exp->mask.dst.protonum  = 0xff;
        exp->expectfn = expected;
        exp->flags = 0;
        

        DEBUGP("expect_related %u.%u.%u.%u:%u-%u.%u.%u.%u:%u\n",
                NIPQUAD(exp->tuple.src.ip),
                ntohs(exp->tuple.src.u.tcp.port),
                NIPQUAD(exp->tuple.dst.ip),
                ntohs(exp->tuple.dst.u.tcp.port));

	if (ip_nat_rtsp_hook)
        	/* pass the request off to the nat helper */
		ret = ip_nat_rtsp_hook(pskb, ctinfo, &expinfo, exp);
	else if (ip_conntrack_expect_related(exp) != 0) {
  		INFOP("ip_conntrack_expect_related failed\n");
		ip_conntrack_expect_free(exp);
		ret  = NF_DROP;
	}
	ip_conntrack_expect_put(exp);
	goto out;
    }
out:

    return ret;
}
#else
help_out(struct sk_buff **pskb, unsigned char *rb_ptr, unsigned int datalen,
                 struct ip_conntrack* ct, enum ip_conntrack_info ctinfo)
{
	struct ip_ct_rtsp_expect expinfo;
	
	int dir = CTINFO2DIR(ctinfo);   /* = IP_CT_DIR_ORIGINAL */
	//struct  tcphdr* tcph = (void*)iph + iph->ihl * 4;
	//uint    tcplen = pktlen - iph->ihl * 4;
	char*   pdata = rb_ptr;
	//uint    datalen = tcplen - tcph->doff * 4;
	uint    dataoff = 0;
	int ret = NF_ACCEPT;
	
	struct ip_conntrack_expect *exp;
	
	memset(&expinfo, 0, sizeof(expinfo));
	
	while (dataoff < datalen) {
		uint    cmdoff = dataoff;
		uint    hdrsoff = 0;
		uint    hdrslen = 0;
		uint    cseqoff = 0;
		uint    cseqlen = 0;
		uint    transoff = 0;
		uint    translen = 0;
		uint    off;
		
		if (!rtsp_parse_message(pdata, datalen, &dataoff,
					&hdrsoff, &hdrslen,
					&cseqoff, &cseqlen,
					&transoff, &translen))
			break;      /* not a valid message */
		
		if (strncmp(pdata+cmdoff, "SETUP ", 6) != 0)
			continue;   /* not a SETUP message */
		DEBUGP("found a setup message\n");

		off = 0;
		if(translen) {
			rtsp_parse_transport(pdata+transoff, translen, &expinfo);
		}

		if (expinfo.loport == 0) {
			DEBUGP("no udp transports found\n");
			continue;   /* no udp transports found */
		}

		DEBUGP("udp transport found, ports=(%d,%hu,%hu)\n",
		       (int)expinfo.pbtype, expinfo.loport, expinfo.hiport);

		exp = ip_conntrack_expect_alloc(ct);
		if (!exp) {
			ret = NF_DROP;
			goto out;
		}

		exp->master = ct;

		exp->expectfn = expected;
		exp->flags = 0;

		exp->tuple = ((struct ip_conntrack_tuple)
				{
					{ ct->tuplehash[!dir].tuple.src.ip,
						{ 0 } 
					},
					{ 	
						ct->tuplehash[!dir].tuple.dst.ip,
						{ .udp = { htons(expinfo.loport) } },
						IPPROTO_UDP 
					}
				});
		exp->mask = ((struct ip_conntrack_tuple)
				{ 
					{ 0,
						{ 0 } 
					},
					{
						0xFFFFFFFF, 
						{ .udp = { 0xFFFF } }, 0xFF 
					}
				});
		if (expinfo.pbtype == pb_range) {
			DEBUGP("Changing expectation mask to handle multiple ports\n");
			exp->mask.dst.u.udp.port  = 0xfffe;
		}

		DEBUGP("expect_related %u.%u.%u.%u:%u-%u.%u.%u.%u:%u\n",
		       NIPQUAD(exp->tuple.src.ip),
		       ntohs(exp->tuple.src.u.udp.port),
		       NIPQUAD(exp->tuple.dst.ip),
		       ntohs(exp->tuple.dst.u.udp.port));

		if (ip_nat_rtsp_hook)
			/* pass the request off to the nat helper */
			ret = ip_nat_rtsp_hook(pskb, ctinfo, hdrsoff, hdrslen, &expinfo, exp);
		else if (ip_conntrack_expect_related(exp) != 0) {
			INFOP("ip_conntrack_expect_related failed\n");
			ret  = NF_DROP;
		}
		ip_conntrack_expect_put(exp);
 		goto out;
 	}

 out:
 
	return ret;
}
#endif
/* inbound packet: server->client */
static inline int
help_in(struct sk_buff **pskb, size_t pktlen,
                struct ip_conntrack* ct, enum ip_conntrack_info ctinfo)
{
    return NF_ACCEPT;
}

#if 0
static int help(struct sk_buff **pskb, struct ip_conntrack* ct, enum
		ip_conntrack_info ctinfo) 
{
    struct tcphdr _tcph, *th;
    unsigned int dataoff, datalen;
    char *rb_ptr;
    int ret = NF_DROP;

    /* Until there's been traffic both ways, don't look in packets. */
    if (ctinfo != IP_CT_ESTABLISHED && 
	ctinfo != IP_CT_ESTABLISHED + IP_CT_IS_REPLY)
    {
        DEBUGP("conntrackinfo = %u\n", ctinfo);
        return NF_ACCEPT;
    }

    /* Not whole TCP header? */
    th = skb_header_pointer(*pskb, (*pskb)->nh.iph->ihl*4,
		    	    sizeof(_tcph), &_tcph);
    if (!th)
	    return NF_ACCEPT;
   
    /* No data ? */
    dataoff = (*pskb)->nh.iph->ihl*4 + th->doff*4;
    datalen = (*pskb)->len - dataoff;
    if (dataoff >= (*pskb)->len)
	    return NF_ACCEPT;

    spin_lock_bh(&rtsp_buffer_lock);
    rb_ptr = skb_header_pointer(*pskb, dataoff,
		    		(*pskb)->len - dataoff, rtsp_buffer);
    BUG_ON(rb_ptr == NULL);

#if 0
    /* Checksum invalid?  Ignore. */
    /* FIXME: Source route IP option packets --RR */
    if (tcp_v4_check(tcph, tcplen, iph->saddr, iph->daddr,
                     csum_partial((char*)tcph, tcplen, 0)))
    {
        DEBUGP("bad csum: %p %u %u.%u.%u.%u %u.%u.%u.%u\n",
               tcph, tcplen, NIPQUAD(iph->saddr), NIPQUAD(iph->daddr));
        return NF_ACCEPT;
    }
#endif

    switch (CTINFO2DIR(ctinfo))
    {
    case IP_CT_DIR_ORIGINAL:
        ret = help_out(pskb, rb_ptr, datalen, ct, ctinfo);
        break;
    case IP_CT_DIR_REPLY:
	/* inbound packet: server->client */
        ret = NF_ACCEPT;
        break;
    }

    spin_unlock_bh(&rtsp_buffer_lock);

    return ret;
}
#else
static int help(struct sk_buff **pskb, struct ip_conntrack* ct, enum
 		ip_conntrack_info ctinfo) 
{

	struct tcphdr _tcph, *th;
	unsigned int dataoff, datalen;
	char *rb_ptr;
	int ret = NF_DROP;

	/* Until there's been traffic both ways, don't look in packets. */
	if (ctinfo != IP_CT_ESTABLISHED && 
	    ctinfo != IP_CT_ESTABLISHED + IP_CT_IS_REPLY) {
		DEBUGP("conntrackinfo = %u\n", ctinfo);
		return NF_ACCEPT;
	}
 

	/* Not whole TCP header? */
	th = skb_header_pointer(*pskb, (*pskb)->nh.iph->ihl*4,
				sizeof(_tcph), &_tcph);
	if (!th)
		return NF_ACCEPT;
    

	/* No data ? */
	dataoff = (*pskb)->nh.iph->ihl*4 + th->doff*4;
	datalen = (*pskb)->len - dataoff;
	if (dataoff >= (*pskb)->len)
		return NF_ACCEPT;

	spin_lock_bh(&rtsp_buffer_lock);
	rb_ptr = skb_header_pointer(*pskb, dataoff,
				    (*pskb)->len - dataoff, rtsp_buffer);
	BUG_ON(rb_ptr == NULL);
 
#if 0

	/* Checksum invalid?  Ignore. */
	/* FIXME: Source route IP option packets --RR */
	if (tcp_v4_check(tcph, tcplen, iph->saddr, iph->daddr,
			 csum_partial((char*)tcph, tcplen, 0)))
	{
		DEBUGP("bad csum: %p %u %u.%u.%u.%u %u.%u.%u.%u\n",
		       tcph, tcplen, NIPQUAD(iph->saddr), NIPQUAD(iph->daddr));
		return NF_ACCEPT;
	}
#endif
	switch (CTINFO2DIR(ctinfo)) {
	case IP_CT_DIR_ORIGINAL:
		ret = help_out(pskb, rb_ptr, datalen, ct, ctinfo);
		break;
	case IP_CT_DIR_REPLY:
		DEBUGP("IP_CT_DIR_REPLY\n");
		/* inbound packet: server->client */
		ret = NF_ACCEPT;
		break;
	}
 
	spin_unlock_bh(&rtsp_buffer_lock);
 
	return ret;
}
#endif
static struct ip_conntrack_helper rtsp_helpers[MAX_PORTS];
static char rtsp_names[MAX_PORTS][10];

/* This function is intentionally _NOT_ defined as __exit */
static void
fini(void)
{
    int i;
    for (i = 0; i < num_ports; i++)
    {
        DEBUGP("unregistering port %d\n", ports[i]);
        ip_conntrack_helper_unregister(&rtsp_helpers[i]);
    }
}

static int __init
init(void)
{
    int i, ret;
    struct ip_conntrack_helper *hlpr;
    char *tmpname;

    printk("ip_conntrack_rtsp v" IP_NF_RTSP_VERSION " loading\n");

    if (max_outstanding < 1)
    {
        printk("ip_conntrack_rtsp: max_outstanding must be a positive integer\n");
        return -EBUSY;
    }
    if (setup_timeout < 0)
    {
        printk("ip_conntrack_rtsp: setup_timeout must be a positive integer\n");
        return -EBUSY;
    }

    /* If no port given, default to standard rtsp port */
    if (ports[0] == 0)
    {
        ports[0] = RTSP_PORT;
    }
    if (ports[1] == 0)
    {
        ports[1] = 557;
    }    

    for (i = 0; (i < MAX_PORTS) && ports[i]; i++)
    {
        hlpr = &rtsp_helpers[i];
        memset(hlpr, 0, sizeof(struct ip_conntrack_helper));
        hlpr->tuple.src.u.tcp.port = htons(ports[i]);
        hlpr->tuple.dst.protonum = IPPROTO_TCP;
        hlpr->mask.src.u.tcp.port = 0xFFFF;
        hlpr->mask.dst.protonum = 0xFF;
        hlpr->max_expected = max_outstanding;
        hlpr->timeout = setup_timeout;
        hlpr->me = THIS_MODULE;
        hlpr->help = help;

        tmpname = &rtsp_names[i][0];
        if (ports[i] == RTSP_PORT)
        {
            sprintf(tmpname, "rtsp");
        }
        else
        {
            sprintf(tmpname, "rtsp-%d", i);
        }
        hlpr->name = tmpname;

        DEBUGP("port #%d: %d\n", i, ports[i]);

        ret = ip_conntrack_helper_register(hlpr);

        if (ret)
        {
            printk("ip_conntrack_rtsp: ERROR registering port %d\n", ports[i]);
            fini();
            return -EBUSY;
        }
        num_ports++;
    }
    return 0;
}

module_init(init);
module_exit(fini);
