/* SIP extension for IP connection tracking.
 *
 * (C) 2005 by Christian Hentschel <chentschel@arnet.com.ar>
 * based on RR's ip_conntrack_ftp.c and other modules.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */

#include <linux/config.h>
#include <linux/module.h>
#include <linux/netfilter.h>
#include <linux/ip.h>
#include <linux/ctype.h>
#include <net/checksum.h>
#include <net/udp.h>

#include <linux/netfilter_ipv4/ip_conntrack_helper.h>
#include <linux/netfilter_ipv4/ip_conntrack_sip.h>
/* jimmy added */
#include <linux/netfilter_ipv4/ip_conntrack_core.h>
#include <linux/netfilter_ipv4/ip_nat_helper.h>
/* --------------------- */

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Christian Hentschel <chentschel@arnet.com.ar>");
MODULE_DESCRIPTION("SIP connection tracking helper");

static DEFINE_SPINLOCK(sipbf_lock);


#define MAX_PORTS	8
static int ports[MAX_PORTS];
static int ports_c;
module_param_array(ports, int, &ports_c, 0400);
MODULE_PARM_DESC(ports, " port numbers of sip servers");

static unsigned int sip_timeout = SIP_TIMEOUT;

module_param(sip_timeout, int, 0600);
MODULE_PARM_DESC(sip_timeout, "timeout for the master sip session");

unsigned int (*ip_nat_sip_hook)(struct sk_buff **pskb, 
				enum ip_conntrack_info ctinfo,
				struct ip_conntrack *ct,
				const char **dptr);
EXPORT_SYMBOL_GPL(ip_nat_sip_hook);
				
unsigned int (*ip_nat_sdp_hook)(struct sk_buff **pskb, 
				enum ip_conntrack_info ctinfo,
				struct ip_conntrack_expect *exp,
				const char *dptr, uint8_t port_index);
EXPORT_SYMBOL_GPL(ip_nat_sdp_hook);

int ct_sip_get_info(const char *dptr, size_t dlen, 
				unsigned int *matchoff, 
				unsigned int *matchlen, 
				struct sip_header_nfo *hnfo);
EXPORT_SYMBOL(ct_sip_get_info);

#if 0
#define DEBUGP printk
#else
#define DEBUGP(format, args...)
#endif

/* jimmy added 20080303, for sip rtp binding */
DEFINE_RWLOCK(sip_rtp_binding_lock);

/*	list to store each rtp binding */
struct sip_rtp_binding *binding_list_head = NULL;
struct sip_rtp_binding *binding_list_tail = NULL;

void sip_rtp_binding_init(struct sip_rtp_binding **head, struct sip_rtp_binding **tail){
	(*head) = (*tail)  = NULL;
}

struct sip_rtp_binding* sip_rtp_binding_alloc(void){
	struct sip_rtp_binding *ptr;

	ptr=kmalloc(sizeof(struct sip_rtp_binding), GFP_ATOMIC);//GFP_KERNEL doesn't work

	if(!ptr){
		printk(KERN_ERR "Allocing memory for sip_rtp_binding failed (%s)\n",__FILE__);
		return NULL;
	}

	ptr->next = NULL;
	ptr->prev = NULL;
	ptr->branch = NULL;
	
	return ptr;
}


/* debug function */
/*
void sip_rtp_binding_show(const struct sip_rtp_binding *list){
	const struct sip_rtp_binding *list_tmp;
	list_tmp=list;
	while(list_tmp){
		printk("wan_uac_ip=%d\n",list_tmp->wan_uac_ip);
		printk("router_port=%d\n",list_tmp->router_port);
		printk("lan_uac_ip=%d\n",list_tmp->lan_uac_ip);
		list_tmp=list_tmp->next;
	}
}
*/


struct sip_rtp_binding * sip_rtp_binding_find(uint32_t wan_uac_ip, uint32_t lan_uac_ip){
	struct sip_rtp_binding *list_tmp = NULL;
	uint16_t port = 0;
	list_tmp=binding_list_head;

	DEBUGP("Finding list for [%u.%u.%u.%u] -> [%u.%u.%u.%u] \n", NIPQUAD(wan_uac_ip), NIPQUAD(lan_uac_ip));

	if(!list_tmp)
		return NULL;

	/* lock function */
	read_lock_bh(&sip_rtp_binding_lock);
	while(list_tmp){
		DEBUGP("at %p, [%u.%u.%u.%u] -> [%u.%u.%u.%u] : [%hu]\n",list_tmp , NIPQUAD(list_tmp->wan_uac_ip), NIPQUAD(list_tmp->lan_uac_ip), ntohs(list_tmp->router_port));
		if( (list_tmp->wan_uac_ip == wan_uac_ip) &&
			 (list_tmp->lan_uac_ip == lan_uac_ip) ){
			port = list_tmp->router_port;
			/* lock function */
			read_unlock_bh(&sip_rtp_binding_lock);
			return list_tmp;
		}
		list_tmp=list_tmp->next;
	}
	/* lock function */
	read_unlock_bh(&sip_rtp_binding_lock);

	return NULL;
}


int sip_rtp_binding_free(struct sip_rtp_binding *ptr){
	if(!ptr){
		return 1;
	}

	if(ptr->branch != NULL){
		DEBUGP("kfree memory for sip rtp binding[%p] -> branch at %p \n",ptr,ptr->branch);
		kfree(ptr->branch);
		ptr->branch = NULL;
	}
	
	DEBUGP("kfree memory for sip rtp binding[%p] \n",ptr);
	kfree(ptr);
	ptr = NULL;

	return 1;
}

int sip_rtp_binding_del(struct sip_rtp_binding *list_del){

	if(list_del == NULL){
		return 1;
	}
	/* lock function */
	write_lock_bh(&sip_rtp_binding_lock);

	if(list_del->next == NULL){
		/* this list is the last one or the only one */
		if(list_del->prev != NULL){
			/* this list is the last one */
			list_del->prev->next = NULL;
			binding_list_tail = list_del->prev ;
			list_del->prev = NULL;
		}else{
			/* this list is the only one */
			binding_list_head = NULL;
			binding_list_tail = NULL;
		}
	}else{
		if(list_del->prev != NULL){
			list_del->prev->next = list_del->next;
			list_del->next->prev = list_del->prev;
			list_del->prev = NULL;
			list_del->next = NULL;
		}else{
			/* This is the first one entry */
			list_del->next->prev = NULL;
			binding_list_head = list_del->next;	
			list_del->next = NULL;
		}
	}
	/* lock function */
	write_unlock_bh(&sip_rtp_binding_lock);

	sip_rtp_binding_free(list_del);
	list_del = NULL;

	return 1;
}

static void sip_rtp_binding_remove_expire(unsigned long ul_list_del){
	/* 
		This function remove the rtp conntrack whatever the rtp is still sending or not
		if we need to improve, we need to do 
		1. mod_timer(), when receiving 200 OK, or other event that can let us know
			rtp binding need to renew timeout
		2. verify if timeout or not in here
		3. self readding timer in here if it's not timeout 
	*/
	struct sip_rtp_binding *list_tmp = (void *)ul_list_del;
	sip_rtp_binding_del(list_tmp);
}


struct sip_rtp_binding* sip_rtp_binding_create(void){
	/* add to tail */
	struct sip_rtp_binding *ptr = NULL;
	ptr = sip_rtp_binding_alloc();

	if(!ptr){
		printk(KERN_ERR "Allocing memory for sip_rtp_binding failed (%s)\n",__FILE__);
		return NULL;
	}

	/* lock function */
	write_lock_bh(&sip_rtp_binding_lock);
	if( binding_list_head == NULL ){
		/* This is the first entry */
		ptr->prev = NULL;
		ptr->next = NULL;

		binding_list_head = ptr;
		binding_list_tail = ptr;
	}else{
		ptr->next = NULL;
		ptr->prev = binding_list_tail;
		binding_list_tail->next = ptr;
		binding_list_tail = ptr;
	}

	/* set timer first */
	init_timer(&ptr->timeout);

	ptr->timeout.data = (unsigned long)(ptr);
	ptr->timeout.function = sip_rtp_binding_remove_expire;
	ptr->timeout.expires = jiffies + sip_timeout*HZ;//sip_timeout secs

	add_timer(&ptr->timeout);

	/* unlock function */
	write_unlock_bh(&sip_rtp_binding_lock);
	return ptr;
}


static int parse_branch(const char *cp,	char *branch, 
				int branch_len,const char *limit)
{
	char *ptr=NULL;
	char *end_ptr=NULL;

	memset(branch,'\0',branch_len);
	ptr=strstr(cp,"branch=");
	
	if(!ptr){
		return 0;
	}

	ptr=ptr+(sizeof(char)*strlen("branch="));
	end_ptr=strstr(ptr,"\r\n");

	if(end_ptr<=ptr){
		return 0;
	}
	if(branch_len <= (end_ptr-ptr)){
		printk(KERN_ERR "%s, %s(), Oops...sip branch length isn't enough, give up !\n",__FILE__,__FUNCTION__);
		return 0;
	}

	strncpy(branch,ptr,end_ptr-ptr);

	return 1;
}

static int destroy_sip_sibling_or_exp(const struct ip_conntrack_tuple *t)
{
	struct ip_conntrack_tuple_hash *h;
	struct ip_conntrack_expect *exp;

	DEBUGP("%s trying to timeout ct or exp for tuple ",__FUNCTION__);
	DEBUGP("%p: %u %u.%u.%u.%u:%hu -> %u.%u.%u.%u:%hu\n",
				t, t->dst.protonum,
				NIPQUAD((t)->src.ip), ntohs((t)->src.u.all),
				NIPQUAD((t)->dst.ip), ntohs((t)->dst.u.all));

	h = ip_conntrack_find_get(t, NULL);
	if (h)  {
		DEBUGP("%s(), tuple found\n",__FUNCTION__);

		struct ip_conntrack *sibling = tuplehash_to_ctrack(h);
		DEBUGP("setting timeout of conntrack %p to 0\n", sibling);
		
		if (del_timer(&sibling->timeout)){
			sibling->timeout.function((unsigned long)sibling);
		}

//		ip_conntrack_put(sibling);

		exp = ip_conntrack_expect_find(t);
		if (exp) {
			DEBUGP("unexpect_related of expect %p\n", exp);
			ip_conntrack_unexpect_related(exp);
			ip_conntrack_expect_put(exp);
			//return 1;
		}
		ip_conntrack_put(sibling);		
		return 1;
	} else {
		exp = ip_conntrack_expect_find(t);
		if (exp) {
			DEBUGP("unexpect_related of expect %p\n", exp);
			ip_conntrack_unexpect_related(exp);
			ip_conntrack_expect_put(exp);
			return 1;
		}
	}
	return 0;
}
/* ----------------------------------------- */

static int digits_len(const char *dptr, const char *limit, int *shift);
static int epaddr_len(const char *dptr, const char *limit, int *shift);
static int skp_digits_len(const char *dptr, const char *limit, int *shift);
static int skp_epaddr_len(const char *dptr, const char *limit, int *shift);

struct sip_header_nfo ct_sip_hdrs[] = {
	{ 	/* Via header */
		"Via:",		sizeof("Via:") - 1,
		"\r\nv:",	sizeof("\r\nv:") - 1, /* rfc3261 "\r\n" */
		"UDP ", 	sizeof("UDP ") - 1,
		epaddr_len
	},
	{ 	/* Contact header */
		"Contact:",	sizeof("Contact:") - 1,
		"\r\nm:",	sizeof("\r\nm:") - 1,
		"sip:",		sizeof("sip:") - 1,
		skp_epaddr_len
	},
	{ 	/* Content length header */
		"Content-Length:", sizeof("Content-Length:") - 1,
		"\r\nl:",	sizeof("\r\nl:") - 1,
		":",		sizeof(":") - 1, 
		skp_digits_len
	},
	{	/* SDP media info */
		"\nm=a",	sizeof("\nm=a") - 1,	
		"\rm=a",	sizeof("\rm=a") - 1,
		"audio ",	sizeof("audio ") - 1,
		digits_len
	},
	{ 	/* SDP owner address*/	
		"\no=",		sizeof("\no=") - 1, 
		"\ro=",		sizeof("\ro=") - 1,
		"IN IP4 ",	sizeof("IN IP4 ") - 1,
		epaddr_len
	},
	{ 	/* SDP connection info */
		"\nc=",		sizeof("\nc=") - 1, 
		"\rc=",		sizeof("\rc=") - 1,
		"IN IP4 ",	sizeof("IN IP4 ") - 1,
		epaddr_len
	},
	{ 	/* Requests headers */
		"sip:",		sizeof("sip:") - 1,
		"sip:",		sizeof("sip:") - 1, /* yes, i know.. ;) */
		"@", 		sizeof("@") - 1, 
		epaddr_len
	},
	{ 	/* SDP version header */
		"\nv=",		sizeof("\nv=") - 1,
		"\rv=",		sizeof("\rv=") - 1,
		"=", 		sizeof("=") - 1, 
		digits_len
	},
	{	/* SDP media info */
		"\nm=v",	sizeof("\nm=v") - 1,	
		"\rm=v",	sizeof("\rm=v") - 1,
		"video ",	sizeof("video ") - 1,
		digits_len
	}
};
EXPORT_SYMBOL(ct_sip_hdrs);


static int digits_len(const char *dptr, const char *limit, int *shift)
{
	int len = 0;	
	while (dptr <= limit && isdigit(*dptr)) {
		dptr++;
		len++;
	}
	return len;
} 

/* get digits lenght, skiping blank spaces. */
static int skp_digits_len(const char *dptr, const char *limit, int *shift)
{
	for (; dptr <= limit && *dptr == ' '; dptr++)
		(*shift)++;
		
	return digits_len(dptr, limit, shift);
}

/* Simple ipaddr parser.. */
static int parse_ipaddr(const char *cp,	const char **endp, 
			uint32_t *ipaddr, const char *limit)
{
	unsigned long int val;
	int i, digit = 0;
	
	for (i = 0, *ipaddr = 0; cp <= limit && i < 4; i++) {
		digit = 0;
		if (!isdigit(*cp))
			break;
		
		val = simple_strtoul(cp, (char **)&cp, 10);
		if (val > 0xFF)
			return -1;
	
		((uint8_t *)ipaddr)[i] = val;	
		digit = 1;
	
		if (*cp != '.')
			break;
		cp++;
	}
	if (!digit)
		return -1;
	
	if (endp)
		*endp = cp;

	return 0;
}

/* skip ip address. returns it lenght. */
static int epaddr_len(const char *dptr, const char *limit, int *shift)
{
	const char *aux = dptr;
	uint32_t ip;
	
	if (parse_ipaddr(dptr, &dptr, &ip, limit) < 0) {
		DEBUGP("ip: %s parse failed.!\n", dptr);
		return 0;
	}

	/* Port number */
	if (*dptr == ':') {
		dptr++;
		dptr += digits_len(dptr, limit, shift);
	}
	return dptr - aux;
}

/* get address lenght, skiping user info. */
static int skp_epaddr_len(const char *dptr, const char *limit, int *shift)
{
	for (; dptr <= limit && *dptr != '@'; dptr++)
		(*shift)++;	
	
	if (*dptr == '@') {
		dptr++;
		(*shift)++;
		return epaddr_len(dptr, limit, shift);
	}	
	return  0;
}

/* Returns 0 if not found, -1 error parsing. */
int ct_sip_get_info(const char *dptr, size_t dlen, 
		unsigned int *matchoff, 
		unsigned int *matchlen,
		struct sip_header_nfo *hnfo)
{
	const char *limit, *aux, *k = dptr;
	int shift = 0;
	
	limit = dptr + (dlen - hnfo->lnlen);

	while (dptr <= limit) {
		if ((strncmp(dptr, hnfo->lname, hnfo->lnlen) != 0) &&
			(strncmp(dptr, hnfo->sname, hnfo->snlen) != 0))
		{
			dptr++;
			continue;
		}
		aux = ct_sip_search(hnfo->ln_str, dptr, hnfo->ln_strlen, 
						ct_sip_lnlen(dptr, limit));
		if (!aux) {
			DEBUGP("'%s' not found in '%s'.\n", hnfo->ln_str, hnfo->lname);
			return -1;
		}
		aux += hnfo->ln_strlen;
		
		*matchlen = hnfo->match_len(aux, limit, &shift);
		if (!*matchlen)
			return -1;

		*matchoff = (aux - k) + shift; 
		
		DEBUGP("%s match succeeded! - len: %u\n", hnfo->lname, *matchlen);
		return 1;
	}
	DEBUGP("%s header not found.\n", hnfo->lname);
	return 0;
}

static int set_expected_rtp(struct sk_buff **pskb, 
			struct ip_conntrack *ct,
			enum ip_conntrack_info ctinfo, 
			uint32_t ipaddr, uint16_t *port,
			const char *dptr)
{
	struct ip_conntrack_expect *exp[2];
	int ret = 0;
	uint16_t new_port;
	/* jimmy added */
//	struct sip_rtp_binding *sip_rtp_binding_tmp = NULL;
//	const char *dptr_tmp;
//	unsigned int dataoff, datalen;
//	int matchoff, matchlen;
//	char branch_tmp[SIP_BRANCH_LEN];
	/* ------------------------------------------*/

	int i = 0;
	uint32_t newip = ct->tuplehash[IP_CT_DIR_REPLY].tuple.dst.ip;
	
	for(i = 0; i < 2; i++){
		if(port[1] == 0)
		 	break;
		exp[i] = ip_conntrack_expect_alloc(ct);
		if (exp[i] == NULL)
		return NF_DROP;

		exp[i]->tuple = ((struct ip_conntrack_tuple)
		{ { ct->tuplehash[IP_CT_DIR_REPLY].tuple.src.ip, { 0 } },
			  { ipaddr, { .udp = { htons(port[i]) } }, IPPROTO_UDP }});
		  
		exp[i]->mask = ((struct ip_conntrack_tuple) 
		{ { 0xFFFFFFFF, { 0 } },
		  { 0xFFFFFFFF, { .udp = { 0xFFFF } }, 0xFF }});
	
		exp[i]->expectfn = NULL;
	

		exp[i]->tuple.dst.ip = newip;
		exp[i]->saved_proto.udp.port = exp[i]->tuple.dst.u.udp.port;
		exp[i]->dir = IP_CT_DIR_REPLY;

		/* When you see the packet, we need to NAT it the same as the
		   this one. */
		exp[i]->expectfn = ip_nat_follow_master;

		/* Try to get same port: if not, try to change it. */
		for (new_port = ntohs(exp[i]->saved_proto.udp.port); port != 0; port++) {
			exp[i]->tuple.dst.u.udp.port = htons(new_port);
			if (ip_conntrack_expect_related(exp[i]) == 0)
				break;
		}		
	
		if (new_port == 0)
			return NF_DROP;		
/* jimmy modified, for sip rtp binding */
//	if (ip_nat_sdp_hook)
//		ret = ip_nat_sdp_hook(pskb, ctinfo, exp, dptr);
	if (ip_nat_sdp_hook){
			ret = ip_nat_sdp_hook(pskb, ctinfo, exp[i], dptr, i);

		DEBUGP(" after ip_nat_sdp(), RTP tuple became \n");
		DEBUGP("tuple %p: %u.%u.%u.%u:%hu -> %u.%u.%u.%u:%hu %u\n",
					&(exp[i]->tuple), 
					NIPQUAD(  (&(exp[i]->tuple))->src.ip), ntohs( (&(exp[i]->tuple))->src.u.all),
					NIPQUAD( (&(exp[i]->tuple))->dst.ip), ntohs( (&(exp[i]->tuple))->dst.u.all),
					(&(exp[i]->tuple))->dst.protonum);

	//		dataoff = (*pskb)->nh.iph->ihl*4 + sizeof(struct udphdr);
	//		dptr_tmp = (*pskb)->data + dataoff;
	//		datalen = (*pskb)->len - dataoff;
	//		if (ct_sip_get_info(dptr_tmp, datalen, &matchoff, &matchlen, 
	//		    	&ct_sip_hdrs[POS_VIA]) > 0) {
	//			if (parse_branch(dptr_tmp + matchoff, branch_tmp, sizeof(branch_tmp), dptr_tmp + datalen) == 1) {
	//				sip_rtp_binding_tmp = sip_rtp_binding_find(	(&(exp->tuple))->src.ip, 
	//												ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.src.ip);
	//
	//				if(sip_rtp_binding_tmp){
	//				/* already has this binding, check if need to update branch and wan_uac_port */
	//					if( !(sip_rtp_binding_tmp->branch) ){
	//						sip_rtp_binding_tmp->branch = kmalloc( strlen(branch_tmp)+1,GFP_ATOMIC);//GFP_KERNEL can't work
	//						strcpy(sip_rtp_binding_tmp->branch,branch_tmp);
	//					}else{
	//						if( strncmp(sip_rtp_binding_tmp->branch,branch_tmp,strlen(sip_rtp_binding_tmp->branch)) != 0 ){
	//							/* update branch */
	//							kfree(sip_rtp_binding_tmp->branch);
	//							sip_rtp_binding_tmp->branch = NULL;
	//							sip_rtp_binding_tmp->branch = kmalloc( strlen(branch_tmp)+1,GFP_ATOMIC);//GFP_KERNEL can't work
	//							strcpy(sip_rtp_binding_tmp->branch,branch_tmp);
	//							/* when branch is not the same, save router_port again to make sure it's correct */
	//							sip_rtp_binding_tmp->router_port=(&(exp->tuple))->dst.u.all;
	//						}
	//					}
	//				}else{
	//					sip_rtp_binding_tmp = sip_rtp_binding_create();
	//					if(sip_rtp_binding_tmp){
	//						sip_rtp_binding_tmp->wan_uac_ip=(&(exp->tuple))->src.ip;
	//						/* for outbound call, router port is not right, catch again when receiving 200 OK */
	//						sip_rtp_binding_tmp->router_port=(&(exp->tuple))->dst.u.all;
	//						sip_rtp_binding_tmp->lan_uac_ip=ipaddr;
	//						sip_rtp_binding_tmp->router_ip = (&(exp->tuple))->dst.ip;
	//						sip_rtp_binding_tmp->lan_uac_port=port;
	//
	//						sip_rtp_binding_tmp->branch = kmalloc( strlen(branch_tmp)+1,GFP_ATOMIC);//GFP_KERNEL can't work
	//						strcpy(sip_rtp_binding_tmp->branch,branch_tmp);
	//					}else{
	//						printk(KERN_ERR "%s, Oops, sip_rtp_binding_create failed !\n",__FUNCTION__);
	//					}
	//				}
	//
	//				DEBUGP("%s(), rtp binding wan_uac_ip %u.%u.%u.%u\n",__FUNCTION__, NIPQUAD(sip_rtp_binding_tmp->wan_uac_ip));
	//				DEBUGP("%s(),             router_ip %u.%u.%u.%u\n",__FUNCTION__, NIPQUAD(sip_rtp_binding_tmp->router_ip));
	//				DEBUGP("%s(),             lan_uac_ip %u.%u.%u.%u\n",__FUNCTION__, NIPQUAD(sip_rtp_binding_tmp->lan_uac_ip));
	//				DEBUGP("%s(),             lan_uac_port %hu\n",__FUNCTION__, ntohs(sip_rtp_binding_tmp->lan_uac_port));
	//				DEBUGP("%s(),             branch     [%s]\n",__FUNCTION__, sip_rtp_binding_tmp->branch);
	//			}
	//		}

	}else{
/* ------------------------------------------*/
			if (ip_conntrack_expect_related(exp[i]) != 0)
			ret = NF_DROP;
		else
			ret = NF_ACCEPT;
	}
		ip_conntrack_expect_put(exp[i]);
	}	

	return ret;
}

/* jimmy added */
/*
	If UAC's UDP packet source port != the port in Via header of SDP,
	We need to create an expected conntrack for following SIP packet
*/

/* in ip_nat_sip.c */
extern int parse_via_port(const char *cp,uint16_t *via_port);

static int set_expected_sip(struct sk_buff **pskb, 
			struct ip_conntrack *ct,
			enum ip_conntrack_info ctinfo, 
			uint32_t ipaddr, uint16_t port,
			const char *dptr)
{
	struct ip_conntrack_expect *exp;
	int ret = 0;

	exp = ip_conntrack_expect_alloc(ct);
	if (exp == NULL)
		return NF_DROP;

	exp->tuple = ((struct ip_conntrack_tuple)
		{ { ct->tuplehash[IP_CT_DIR_REPLY].tuple.src.ip, { 0 } },
		  { ipaddr, { .udp = { htons(port) } }, IPPROTO_UDP }});
		  
	exp->mask = ((struct ip_conntrack_tuple) 
		{ { 0xFFFFFFFF, { 0 } },
		  { 0xFFFFFFFF, { .udp = { 0xFFFF } }, 0xFF }});
	
	/* below are the key factors that differ from set_expected_rtp() */
	exp->saved_proto = ((union ip_conntrack_manip_proto)
		{.udp = { htons(port)}}
	);

	exp->expectfn = ip_nat_follow_master;

	exp->dir = IP_CT_DIR_REPLY;

	if(ip_conntrack_expect_related(exp)!=0){
		ret = 0;
	}else{
		ret = 1;
	}
	return ret;
}
/* ------------------------------- */

static int sip_help(struct sk_buff **pskb,
		struct ip_conntrack *ct,
		enum ip_conntrack_info ctinfo)
{
	unsigned int dataoff, datalen;
	const char *dptr;
	int ret = NF_ACCEPT;
	int matchoff, matchlen;
	uint32_t ipaddr;
	uint16_t port[2]={};
	struct sk_buff *skb = (*pskb);
	/* jimmy added */
	const char *dptr_tmp;
	char branch_tmp[SIP_BRANCH_LEN];//60 maybe not enough :(
	struct sip_rtp_binding *sip_rtp_binding_tmp = NULL;
	struct ip_conntrack_tuple bye_tuple;
	const char *aux;
	uint16_t via_port;
	struct ip_conntrack_protocol *proto;
	/* -------------------- */
	

	/* No Data ? */ 
	dataoff = (*pskb)->nh.iph->ihl*4 + sizeof(struct udphdr);
	if (dataoff >= (*pskb)->len) {
		DEBUGP("skb->len = %u\n", (*pskb)->len);
		return NF_ACCEPT;
        }
        
	ip_ct_refresh_acct(ct, ctinfo, skb, sip_timeout * HZ);
		
	spin_lock_bh(&sipbf_lock);
	
	if ((dataoff + (*pskb)->len - dataoff) <= skb_headlen(*pskb))
		dptr = (*pskb)->data + dataoff;
	else {
		DEBUGP("Copy of skbuff not supported yet.\n");
		goto out;
	}
	if (ip_nat_sip_hook) {
		if (!ip_nat_sip_hook(pskb, ctinfo, ct, &dptr)) {
			ret = NF_DROP;
			goto out;
		}
	}

			
		
	/* jimmy added , handling direction independent METHOD , BYE 
		we can't directly destroy conntrack when receiving BYE,
		we should destroy it when receiving the replying 200 OK for BYE
	*/
//	if ( memcmp(dptr, "SIP/2.0 200 OK", sizeof("SIP/2.0 200 OK") - 1) == 0){
//		aux = ct_sip_search("CSeq:", dptr, sizeof("CSeq:") - 1, 
//								(*pskb)->len - dataoff);
//		if (aux){
//			if(strstr(aux," BYE\r\n")){
//				sip_rtp_binding_tmp = sip_rtp_binding_find(	ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.ip, 
//									ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.src.ip);
//				if(sip_rtp_binding_tmp){
//					memset(&bye_tuple,'0',sizeof(struct ip_conntrack_tuple));
//					bye_tuple = (
//						(struct ip_conntrack_tuple)
//						{
//							{ sip_rtp_binding_tmp->wan_uac_ip, { .udp.port = sip_rtp_binding_tmp->wan_uac_port } },
//							{ ct->tuplehash[IP_CT_DIR_REPLY].tuple.dst.ip, { .udp.port = sip_rtp_binding_tmp->router_port }, IPPROTO_UDP }
//						}
//					);
//					destroy_sip_sibling_or_exp(&bye_tuple);
//					sip_rtp_binding_tmp->timeout.expires = 0;
//					if (del_timer(&sip_rtp_binding_tmp->timeout)){
//						sip_rtp_binding_tmp->timeout.function((unsigned long)sip_rtp_binding_tmp);
//					}
//				}
//				goto out;
//			}
//		}
//	}

	if ( memcmp(dptr, "SIP/2.0 200 OK", sizeof("SIP/2.0 200 OK") - 1) == 0){
		aux = ct_sip_search("CSeq:", dptr, sizeof("CSeq:") - 1, 
								(*pskb)->len - dataoff);
		if (aux){
			if(strstr(aux," BYE\r\n")){
					memset(&bye_tuple,'0',sizeof(struct ip_conntrack_tuple));
					bye_tuple = (
						(struct ip_conntrack_tuple)
						{
						{ ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.src.ip, { .udp.port = SIP_PORT } },
						{ ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.ip, { .udp.port = SIP_PORT }, IPPROTO_UDP }
						}
					);
					destroy_sip_sibling_or_exp(&bye_tuple);
				
			memset(&bye_tuple,'0',sizeof(struct ip_conntrack_tuple));
			bye_tuple = (
				(struct ip_conntrack_tuple)
				{
						{ ct->tuplehash[IP_CT_DIR_REPLY].tuple.src.ip, { .udp.port = SIP_PORT } },
						{ ct->tuplehash[IP_CT_DIR_REPLY].tuple.dst.ip, { .udp.port = SIP_PORT }, IPPROTO_UDP }
				}
			);
			destroy_sip_sibling_or_exp(&bye_tuple);
				goto out;
			}
		}
	}
	/* ---------------------------------------------------- */

	/* jimmy modified , to record each rtp binding info */
	if ((ctinfo) >= IP_CT_IS_REPLY)
			goto out;
//	if ((ctinfo) >= IP_CT_IS_REPLY){
//		/* We need to reload this. Thanks Patrick. */
//		dptr = (*pskb)->data + dataoff;
//		datalen = (*pskb)->len - dataoff;
//		if (datalen < (sizeof("SIP/2.0 200") - 1))
//			goto out;
//
//		if ( memcmp(dptr, "SIP/2.0 200 OK", sizeof("SIP/2.0 200 OK") - 1) == 0){
//			dptr_tmp=dptr;
//			if (ct_sip_get_info(dptr_tmp, datalen, &matchoff, &matchlen, 
//		    	&ct_sip_hdrs[POS_VIA]) > 0) {
//				if (parse_branch(dptr_tmp + matchoff, branch_tmp, sizeof(branch_tmp), dptr_tmp + datalen) == 1) {
//					sip_rtp_binding_tmp = sip_rtp_binding_find(	ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.ip, 
//												ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.src.ip);
//					if(sip_rtp_binding_tmp){
//						/* binding already exists */
//						if((sip_rtp_binding_tmp->branch) && 
//							(strncmp(sip_rtp_binding_tmp->branch, branch_tmp, strlen(sip_rtp_binding_tmp->branch)) == 0) ){
//
//							if (ct_sip_get_info(dptr_tmp, datalen, &matchoff, &matchlen, 
//						    	&ct_sip_hdrs[POS_CONECTION]) > 0) {
//								if (parse_ipaddr(dptr_tmp + matchoff, NULL, &ipaddr, 
//			 					   dptr_tmp + datalen) < 0) {
//									goto out;
//								}
//								if (ct_sip_get_info(dptr_tmp, datalen, &matchoff, &matchlen, 
//								    &ct_sip_hdrs[POS_MEDIA]) > 0) {
//									/* store rtp port */
//									sip_rtp_binding_tmp->wan_uac_port = simple_strtoul(dptr_tmp + matchoff, NULL, 10);
//									sip_rtp_binding_tmp->timeout.expires = jiffies + sip_timeout*HZ;
//									
//									DEBUGP("%s, line %d, inbound 200 OK, router port = %hu\n",__FUNCTION__,__LINE__,ntohs(sip_rtp_binding_tmp->router_port));
//									DEBUGP("%s, line %d, inbound 200 OK, wan_uac_port = %hu\n",__FUNCTION__,__LINE__,ntohs(sip_rtp_binding_tmp->wan_uac_port));
//								}
//							}//else{
//								/* maybe a 200 OK for non INVITE request ? */
//							//}
//							memset(branch_tmp,'\0',sizeof(branch_tmp));
//						}
//					}else{
//						/* maybe a 200 OK for non INVITE request ? */
//							DEBUGP("Oops, receiving a unrecorded 200 OK for INVITE with %u.%u.%u.%u -> %u.%u.%u.%u ,branch:%s\n", 
//								NIPQUAD(ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.ip), 
//								NIPQUAD(ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.src.ip), 
//								branch_tmp);
//					}
//				}
//			}
//		}else if ( (memcmp(dptr, "CANCEL", sizeof("CANCEL") - 1) == 0) ||
//					(memcmp(dptr, "SIP/2.0 400 Bad Request", sizeof("SIP/2.0 400 Bad Request") - 1) == 0) ){
//			/* need to check branch ?? */
//			sip_rtp_binding_tmp = sip_rtp_binding_find(	ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.ip, 
//									ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.src.ip);
//			if(!sip_rtp_binding_tmp){
//				goto out;
//			}
//			memset(&bye_tuple,'0',sizeof(struct ip_conntrack_tuple));
//			bye_tuple = (
//				(struct ip_conntrack_tuple)
//				{
//					{ sip_rtp_binding_tmp->wan_uac_ip, { .udp.port = sip_rtp_binding_tmp->wan_uac_port } },
//					{ ct->tuplehash[IP_CT_DIR_REPLY].tuple.dst.ip, { .udp.port = sip_rtp_binding_tmp->router_port }, IPPROTO_UDP }
//				}
//			);
//			destroy_sip_sibling_or_exp(&bye_tuple);
//			sip_rtp_binding_tmp->timeout.expires = 0;
//			if (del_timer(&sip_rtp_binding_tmp->timeout)){
//				sip_rtp_binding_tmp->timeout.function((unsigned long)sip_rtp_binding_tmp);
//			}
//		}
//		goto out;
							//}
/*-----------------------------------------------*/

	/* After this point NAT, could have mangled skb, so 
	   we need to recalculate payload lenght. */
	datalen = (*pskb)->len - dataoff;

	if (datalen < (sizeof("SIP/2.0 200") - 1))
		goto out;
	
//	/* jimmy added, for src port != Via port*/
//	if ( memcmp(dptr, "REGISTER", sizeof("REGISTER") - 1) == 0){
//		dptr_tmp = (*pskb)->data + dataoff;
//		datalen = (*pskb)->len - dataoff;
//		if (ct_sip_get_info(dptr_tmp, datalen, &matchoff, &matchlen, 
//		    	&ct_sip_hdrs[POS_VIA]) > 0) {
//			if(parse_via_port(dptr_tmp + matchoff,&via_port)){
//				if( ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.src.u.all != via_port ){
//					/* add an expected conntrack */
//					ret = set_expected_sip(pskb, ct, ctinfo,
//									ct->tuplehash[IP_CT_DIR_REPLY].tuple.dst.ip, via_port, dptr);
//				}
//			}
//		}
//		goto out;
//	}
//	//-----------

	/* jimmy added */
	/* Outbound CANCEL */
//	if ( memcmp(dptr, "CANCEL", sizeof("CANCEL") - 1) == 0 ){
//		/* need to check branch ?? */
//		sip_rtp_binding_tmp = sip_rtp_binding_find(	ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.ip, 
//									ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.src.ip);
//		if(!sip_rtp_binding_tmp){
//			goto out;
//		}
//		memset(&bye_tuple,'0',sizeof(struct ip_conntrack_tuple));
//		bye_tuple = (
//			(struct ip_conntrack_tuple)
//			{
//				{ sip_rtp_binding_tmp->wan_uac_ip, { .udp.port = sip_rtp_binding_tmp->wan_uac_port } },
//				{ ct->tuplehash[IP_CT_DIR_REPLY].tuple.dst.ip, { .udp.port = sip_rtp_binding_tmp->router_port }, IPPROTO_UDP }
//			}
//		);
//		destroy_sip_sibling_or_exp(&bye_tuple);
//		sip_rtp_binding_tmp->timeout.expires = 0;
//		if (del_timer(&sip_rtp_binding_tmp->timeout)){
//			sip_rtp_binding_tmp->timeout.function((unsigned long)sip_rtp_binding_tmp);
//		}
//	}
	/* ----------------------------------------------------- */

	/* RTP info only in some SDP pkts */
	if (memcmp(dptr, "INVITE", sizeof("INVITE") - 1) != 0 && 
	    memcmp(dptr, "SIP/2.0 200", sizeof("SIP/2.0 200") - 1) != 0) {

		goto out;
	}


	/* Get ip and port address from SDP packet. */
	if (ct_sip_get_info(dptr, datalen, &matchoff, &matchlen, 
	    &ct_sip_hdrs[POS_CONECTION]) > 0) {

		/* We'll drop only if there are parse problems. */
		if (parse_ipaddr(dptr + matchoff, NULL, &ipaddr, 
		    dptr + datalen) < 0) {
			ret = NF_DROP;
			goto out;
		}
		if (ct_sip_get_info(dptr, datalen, &matchoff, &matchlen, 
		    &ct_sip_hdrs[POS_MEDIA]) > 0) {

			port[0] = simple_strtoul(dptr + matchoff, NULL, 10);
			if (port[0] < 1024) {
				ret = NF_DROP;
				goto out;
			}
			DEBUGP("video_port = %u\n", port[0]);
			if (ct_sip_get_info(dptr, datalen, &matchoff, &matchlen, 
			    &ct_sip_hdrs[POS_MEDIA_VIDEO]) > 0) {
		
				port[1] = simple_strtoul(dptr + matchoff, NULL, 10);
				if (port[1] < 1024) {
				ret = NF_DROP;
				goto out;
			}
				DEBUGP("video_port = %u\n", port[1]);
			}				
			
			ret = set_expected_rtp(pskb, ct, ctinfo,
						ipaddr, &port, dptr);
		}
	
	}
out:	spin_unlock_bh(&sipbf_lock);
	return ret;
}

static struct ip_conntrack_helper sip[MAX_PORTS];
static char sip_names[MAX_PORTS][10];

static void fini(void)
{
	int i = 0;
	for (; i < ports_c; i++) {
		DEBUGP("unregistering helper for port %d\n", ports[i]);
		ip_conntrack_helper_unregister(&sip[i]);
	} 
}

static int __init init(void)
{
	int i, ret;
	char *tmpname;

	if (ports_c == 0)
		ports[ports_c++] = SIP_PORT;

	for (i = 0; i < ports_c; i++) {
		/* Create helper structure */
		memset(&sip[i], 0, sizeof(struct ip_conntrack_helper));

		sip[i].tuple.dst.protonum = IPPROTO_UDP;
		sip[i].tuple.src.u.udp.port = htons(ports[i]);
		sip[i].mask.src.u.udp.port = 0xFFFF;
		sip[i].mask.dst.protonum = 0xFF;
		sip[i].max_expected = 1;
		sip[i].timeout = 3 * 60; /* 3 minutes */
		sip[i].me = THIS_MODULE;
		sip[i].help = sip_help;

		tmpname = &sip_names[i][0];
		if (ports[i] == SIP_PORT)
			sprintf(tmpname, "sip");
		else
			sprintf(tmpname, "sip-%d", i);
		sip[i].name = tmpname;

		DEBUGP("port #%d: %d\n", i, ports[i]);

		ret=ip_conntrack_helper_register(&sip[i]);
		if (ret) {
			printk("ERROR registering helper for port %d\n",
				ports[i]);
			fini();
			return(ret);
		}
	}
	/* jimmy added, for sip rtp binding */
	/* initialize sip_rtp_binding list */
	sip_rtp_binding_init( &binding_list_head, &binding_list_tail );
	/* ------------------------------------------ */

	return(0);
}

module_init(init);
module_exit(fini);
