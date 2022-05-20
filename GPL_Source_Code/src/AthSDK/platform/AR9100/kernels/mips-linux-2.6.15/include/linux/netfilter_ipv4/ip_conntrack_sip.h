#ifndef __IP_CONNTRACK_SIP_H__
#define __IP_CONNTRACK_SIP_H__
/* SIP tracking. */

#ifdef __KERNEL__

#define SIP_PORT	5060
#define SIP_TIMEOUT	3600

#define POS_VIA		0
#define POS_CONTACT	1
#define POS_CONTENT	2
#define POS_MEDIA	3
#define POS_OWNER	4
#define POS_CONECTION	5
#define POS_REQ_HEADER	6
#define POS_SDP_HEADER	7
#define POS_MEDIA_VIDEO		8

struct sip_header_nfo {
	const char *lname;
	size_t lnlen;
	const char *sname;
	size_t snlen;
	const char *ln_str;
	size_t ln_strlen;
	int (*match_len)(const char *, const char *, int *);

};

extern unsigned int (*ip_nat_sip_hook)(struct sk_buff **pskb, 
				enum ip_conntrack_info ctinfo,
				struct ip_conntrack *ct,
				const char **dptr);
				
/* For NAT to hook in when on expect. */
extern unsigned int (*ip_nat_sdp_hook)(struct sk_buff **pskb, 
				enum ip_conntrack_info ctinfo,
				struct ip_conntrack_expect *exp,
				const char *dptr, uint8_t port_index);

extern int ct_sip_get_info(const char *dptr, size_t dlen, 
				unsigned int *matchoff, 
				unsigned int *matchlen, 
				struct sip_header_nfo *hnfo);

/* get line lenght until first CR or LF seen. */
static __inline__ int ct_sip_lnlen(const char *line, const char *limit)
{
        const char *k = line;

        while ((line <= limit) && (*line == '\r' || *line == '\n'))
                line++;

        while (line <= limit) {
                if (*line == '\r' || *line == '\n')
                        break;
                line++;
        }
        return line - k;
}

/* Linear string search, case sensitive. */
static __inline__ 
const char *ct_sip_search(const char *needle, const char *haystack, 
			size_t needle_len, size_t haystack_len) 
{
	const char *limit = haystack + (haystack_len - needle_len);

	while (haystack <= limit) {
		if (memcmp(haystack, needle, needle_len) == 0)
			return haystack;
		haystack++;
	}
	return NULL;
}

/* jimmy added 20080324, for sip rtp binding list */
#define SIP_BRANCH_LEN 60
/* using SIP_TIMEOUT as sip_rtp_binding expire time instead of defining new variable */
//#define SIP_RTP_EXPIRE 3600

/* 
	Currently using wan_uac_ip + lan_uac_ip to set/find router_port
	in sip_rtp_binding_list, which means, current solution only suitable
	for ip <-> ip, 1 vs 1's binding, if we need to improve to ip:port <-> ip:port
	we need to struct sip_rtp_binding and related functions
*/
struct sip_rtp_binding{
	struct sip_rtp_binding *prev;
	struct sip_rtp_binding *next;
	uint32_t wan_uac_ip;
	uint16_t wan_uac_port;
	/* jimmy 20080321 added */
	uint32_t router_ip;
	/* -------------------- */
	uint16_t router_port;
	uint32_t lan_uac_ip;
	/* jimmy 20080321 added */
	uint16_t lan_uac_port;
	/* -------------------- */
	char *branch;
	struct timer_list timeout;
};

void sip_rtp_binding_init(struct sip_rtp_binding **head, struct sip_rtp_binding **tail);
struct sip_rtp_binding* sip_rtp_binding_alloc(void);
struct sip_rtp_binding * sip_rtp_binding_find(uint32_t wan_uac_ip, uint32_t lan_uac_ip);
int sip_rtp_binding_free(struct sip_rtp_binding *ptr);
int sip_rtp_binding_del(struct sip_rtp_binding *list_del);

/* -----------------------------------------------*/
#endif /* __KERNEL__ */

#endif /* __IP_CONNTRACK_SIP_H__ */
