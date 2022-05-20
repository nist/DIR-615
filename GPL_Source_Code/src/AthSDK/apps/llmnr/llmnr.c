/*
 *  Copyright (C) 2009 Cameo Communication Inc.
 *  
 *
 *  history:
 *      v0.8, 2009 Apr 2, , 
 *          1. not works in pure IPv6 env.
 *          2. ...
 */


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>  
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <net/if.h>
#include <sys/ioctl.h>
#include <net/if_arp.h>
#include "llmnr.h"

#define LLMNR_VER       "0.8"
#define LLMNR_REL_DATE  "2009 Apr 2"

#ifdef LLMNR_DEBUG
#define DEBUG_MSG(fmt, arg...)  printf(fmt, ##arg)
#else
#define DEBUG_MSG(fmt, arg...)
#endif

static char hostBfr[MAX_BUFLEN];   
static char servBfr[MAX_BUFLEN];  
static char my_hostname[32];
static struct sockaddr_in addr;
static struct sockaddr_in6 addr6;
#define PATH_PROC_NET_IF_INET6 "/proc/net/if_inet6"

static void string_tolower(unsigned char *str)
{
    if (str == NULL) {
        perror("string_tolower");
        return;
    }
        
    while(*str)
    {
        *str = tolower(*str);
        str++;
    }
    
    return;
}

// get sockaddr, IPv4 or IPv6:
static void *get_in_addr(struct sockaddr *sa)
{
    if (sa == NULL) {
        perror("get_in_addr");
        return NULL;
    }
            
    if (sa->sa_family == AF_INET) {
        return &(((struct sockaddr_in*)sa)->sin_addr);
    }

    return &(((struct sockaddr_in6*)sa)->sin6_addr);
}

static unsigned short get_in_port(struct sockaddr *sa)
{
    if (sa == NULL) {
        perror("get_in_port");
        return NULL;
    }
    
    if (sa->sa_family == AF_INET) {
        return ((struct sockaddr_in*)sa)->sin_port;
    }

    return ((struct sockaddr_in6*)sa)->sin6_port;
}

static int get_local_v6addr(unsigned char *ifname, unsigned char *addr6)
{
	FILE *fp;
	char str_addr[40];
	unsigned int plen, scope, dad_status, if_idx;
	char devname[IFNAMSIZ];

	if ((fp = fopen(PATH_PROC_NET_IF_INET6, "r")) == NULL)
	{
		printf("can't open %s: %s", PATH_PROC_NET_IF_INET6, strerror(errno));
		return (-1);	
	}
	
	while (fscanf(fp, "%32s %x %02x %02x %02x %15s\n",
		      str_addr, &if_idx, &plen, &scope, &dad_status,
		      devname) != EOF)
	{
		struct in6_addr addr;
		unsigned int ap;
		int i;
		
		for (i=0; i<16; i++)
		{
			sscanf(str_addr + i * 2, "%02x", &ap);
			addr.s6_addr[i] = (unsigned char)ap;
		}
		
		if (strcmp(ifname, devname) == 0)
		{
		    strncpy(addr6, str_addr+ 0, 4);
		    strcat(addr6, ":");
		    strncat(addr6, str_addr+ 4, 4);
		    strcat(addr6, ":");
		    strncat(addr6, str_addr+ 8, 4);
		    strcat(addr6, ":");
		    strncat(addr6, str_addr+12, 4);
		    strcat(addr6, ":");
		    strncat(addr6, str_addr+16, 4);
		    strcat(addr6, ":");
		    strncat(addr6, str_addr+20, 4);
		    strcat(addr6, ":");
		    strncat(addr6, str_addr+24, 4);
		    strcat(addr6, ":");
		    strncat(addr6, str_addr+28, 4);
		    
		    DEBUG_MSG("v6 addr = %s\n", addr6);
		    
		    fclose(fp);
            return 0;
        }
	}

    /* not found */
	fclose(fp);
	return (-1);
}

static int get_local_v4addr(unsigned char *ifname, unsigned char *addr4)
{
    int iSocket; 
    struct if_nameindex *pIndex, *pIndex2; 
    
    if ((iSocket = socket(PF_INET, SOCK_DGRAM, 0)) < 0) 
    { 
        perror("socket"); 
        return -1; 
    } 
    
    pIndex = pIndex2 = if_nameindex(); 
    while ((pIndex != NULL) && (pIndex->if_name != NULL)) 
    { 
        struct ifreq req; 
        
        strncpy(req.ifr_name, pIndex->if_name, IFNAMSIZ); 
        if (ioctl(iSocket, SIOCGIFADDR, &req) < 0) 
        { 
            if (errno == EADDRNOTAVAIL) 
            { 
                pIndex++; 
                continue; 
            } 
            perror("ioctl"); 
            close(iSocket); 
            return -1; 
        } 
        
        if (strcmp(ifname, pIndex->if_name) == 0)
        {
            sprintf(addr4, inet_ntoa(((struct sockaddr_in*)&req.ifr_addr)->sin_addr));
            DEBUG_MSG("v4 addr = %s\n", addr4);
            
            if_freenameindex(pIndex2); 
            close(iSocket); 
            return 0;
        }
        pIndex++; 
    } 
    
    if_freenameindex(pIndex2); 
    close(iSocket); 
    return -1; 
}

static int process_llmnr(int sockfd)
{
    int numbytes;
    struct sockaddr_storage their_addr;
    unsigned char buf[MAX_BUFLEN];
    unsigned char response_buf[MAX_BUFLEN];
    size_t addr_len;
    char s[INET6_ADDRSTRLEN];
    int i;
    unsigned char qd_name[128];   
    unsigned char qd_type;
    unsigned char qd_class;
    char *pbuf, *p_response_buf;
    struct llmnr_hdr_s *llmnr_hdr;
    unsigned char *p_addr;
    
    while(1) {
        DEBUG_MSG("listener: waiting to recvfrom...\n");
        
        memset(qd_name, 0, 128);
        memset(buf, 0, MAX_BUFLEN);
        memset(response_buf, 0, MAX_BUFLEN);
        
        addr_len = sizeof their_addr;
        if ((numbytes = recvfrom(sockfd, buf, MAX_BUFLEN-1 , 0,
            (struct sockaddr *)&their_addr, &addr_len)) == -1) {
            perror("recvfrom");
            exit(1);
        }
    
        DEBUG_MSG("listener: got packet from %s, %d\n",
            inet_ntop(their_addr.ss_family,
                get_in_addr((struct sockaddr *)&their_addr),
                s, sizeof s), get_in_port((struct sockaddr *)&their_addr));
        DEBUG_MSG("listener: packet is %d bytes long\n", numbytes);
        buf[numbytes] = '\0';

        llmnr_hdr = (struct llmnr_hdr_s *) buf;
        
        DEBUG_MSG("llmnr id        = 0x%04x\n", llmnr_hdr->id);
        DEBUG_MSG("llmnr flags     = 0x%04x\n", llmnr_hdr->flags);
        DEBUG_MSG("llmnr qdcount   = %d\n", ntohs(llmnr_hdr->qdcount));
        DEBUG_MSG("llmnr ancount   = %d\n", ntohs(llmnr_hdr->ancount));
        DEBUG_MSG("llmnr nscount   = %d\n", ntohs(llmnr_hdr->nscount));
        DEBUG_MSG("llmnr arcount   = %d\n", ntohs(llmnr_hdr->arcount));
        
        pbuf = (unsigned char *) &llmnr_hdr->flags;
        *pbuf       = 0x80; /* enable response bit */
        *(pbuf+1)   = 0;
        
        memcpy(response_buf, buf, sizeof(struct llmnr_hdr_s));
        p_response_buf = response_buf + sizeof(struct llmnr_hdr_s);
        
        pbuf = &buf[sizeof(struct llmnr_hdr_s)];
        
        llmnr_hdr = (struct llmnr_hdr_s *) response_buf;
        
        /* now qdcount should not be greater then 1 */
        if (htons(llmnr_hdr->qdcount) > 1)
            continue;
            
        /* now, implement qdcount/ancount only */
        for (i=0; i<htons(llmnr_hdr->qdcount); i++)
        {
            strncpy(qd_name, pbuf, numbytes);
            pbuf += strlen(qd_name);
            pbuf += 2;;
            qd_type = *pbuf;
            pbuf += 2;;
            qd_class = *pbuf;
            pbuf++;
               
            DEBUG_MSG("qd_name  = %s\n", qd_name + 1);
            DEBUG_MSG("qd_type  = 0x%02x\n", qd_type);
            DEBUG_MSG("qd_class = 0x%02x\nn", qd_class);
            
            string_tolower(qd_name+1);
            string_tolower(my_hostname);
            
            DEBUG_MSG("my_hostname = %s\n", my_hostname);
            DEBUG_MSG("qd_name + 1 = %s\n", qd_name + 1);
            
            if(strcmp(my_hostname, qd_name + 1) == 0)
            {
                DEBUG_MSG("matched hostname counter = %d\n", llmnr_hdr->ancount);
                llmnr_hdr->ancount++;
            }
            else
            {
                DEBUG_MSG("no a matched hostname\n");
                continue;
            }
                
            /* query */
            strncpy(p_response_buf, qd_name, MAX_BUFLEN);
            p_response_buf += strlen(qd_name);
            *p_response_buf++ = 0;
            *p_response_buf++ = 0;
            *p_response_buf++ = qd_type;
            *p_response_buf++ = 0;
            *p_response_buf++ = qd_class;
            
            /* answer */
            strncpy(p_response_buf, qd_name, MAX_BUFLEN);
            p_response_buf += strlen(qd_name);
            *p_response_buf++ = 0;
            *p_response_buf++ = 0;
            *p_response_buf++ = qd_type;
            *p_response_buf++ = 0;
            *p_response_buf++ = qd_class;
            *(unsigned long *) p_response_buf = htonl(LLMNR_TTL);
            p_response_buf += 4;
            
            switch (qd_type)
            {
                default:
                case 0x01:
                    DEBUG_MSG("v4 request\n");
                    *(unsigned short *) p_response_buf = htons(4);
                    p_response_buf += 2;
                    p_addr = &(addr.sin_addr.s_addr);
                    memcpy(p_response_buf, p_addr, 4);
                    p_response_buf += 4;
                    break;
                case 0x1c:  /* ipv6 */
                    DEBUG_MSG("v6 request\n");
                    *(unsigned short *) p_response_buf = htons(16);
                    p_response_buf += 2;
                    p_addr = &(addr6.sin6_addr.s6_addr);
                    memcpy(p_response_buf, p_addr, 16);
                    p_response_buf += 16;                
                    break;
            }
        }

        if (llmnr_hdr->ancount) {
            unsigned long len = (unsigned long)p_response_buf - (unsigned long)response_buf;
            if ((numbytes = sendto(sockfd, response_buf, len, 0,
                 &their_addr, addr_len)) == -1) {
                perror("talker: sendto");
                exit(1);
            }
        }
    }
}

int main(int argc, unsigned char *argv[])
{
    int sockfd;
    struct addrinfo hints, *servinfo, *p;
    struct sockaddr_in  *p4;
    struct sockaddr_in6 *p6;    
    int rv;
    
    memset(&hints, 0, sizeof hints);
    hints.ai_family = AF_UNSPEC; // set to AF_INET to force IPv4
    hints.ai_socktype = SOCK_DGRAM;
    hints.ai_flags = AI_PASSIVE; // use my IP
    char v4_addr[20];
    char v6_addr[50];
    struct ip_mreq  imreq;
    struct ipv6_mreq imreq6;
    
    switch (argc)
    {
        case 2:
            gethostname(my_hostname, 32);
            break;
        case 3:
            strncpy(my_hostname, argv[2], 32);
/*  Date: 2009-4-09
 *  Name: Chase Cheng
 *  Reason: neglect "break;", daemon not work with argc==3.
 *  Notice :
*/
			break;
        default:
            printf("Link-Local Multicast Name Resolution daemon, ver. %s, date. %s\n",
                LLMNR_VER, LLMNR_REL_DATE);
            printf("usage: %s intreface_name [hostname]\n", argv[0]);
            exit(1);
    }
    
    DEBUG_MSG("hostname = %s\n", my_hostname);
    
    get_local_v4addr(argv[1], v4_addr);
    DEBUG_MSG("IPv4 Addr : %s\n", v4_addr);
    inet_aton(v4_addr, &addr.sin_addr);
    
    get_local_v6addr(argv[1], v6_addr);
    DEBUG_MSG("IPv6 Addr : %s\n", v6_addr);
    inet_pton(AF_INET6, v6_addr, &(addr6.sin6_addr));
    
    /* resolve the domain name into a list of addresses */
    if ((rv = getaddrinfo(NULL, LLMNR_PORT, &hints, &servinfo)) != 0) {
        DEBUG_MSG("getaddrinfo: %s\n", gai_strerror(rv));
        exit(1);
    }
    
    // loop through all the results and bind
    for(p = servinfo; p != NULL; p = p->ai_next) {

        getnameinfo( p->ai_addr,
            p->ai_addrlen,
            hostBfr,
            sizeof( hostBfr ),
            servBfr,
            sizeof( servBfr ),
            NI_NUMERICHOST | NI_NUMERICSERV ); 
#if 1           
        switch ( p->ai_family )
        {
            case PF_INET:  
                 /* IPv4 address record. */
                p4 = (struct sockaddr_in*) p->ai_addr;
                DEBUG_MSG(
                    "   ai_addr      = sin_family:   %s\n"
                    "                  sin_addr:     %s\n"
                    "                  sin_port:     %s\n",
                    "AF_INET",
                    hostBfr,
                    servBfr );
                break;
                /* End CASE of IPv4. */
                
            case PF_INET6:   
                /* IPv6 address record. */
                p6 = (struct sockaddr_in6*) p->ai_addr;
                DEBUG_MSG(
                    "   ai_addr      = sin6_family:   %s\n"
                    "                  sin6_addr:     %s\n"
                    "                  sin6_port:     %s\n",
                    "AF_INET6",
                    hostBfr,
                    servBfr);
                continue;
                /* End CASE of IPv6. */
                
            default:   
                /* Can never get here, but just for completeness. */
                DEBUG_MSG(
                    "Unknown protocol family (%d).\n",
                    p->ai_family );
                freeaddrinfo( p );
                exit(1);
    
        }  /* End SWITCH on protocol family. */
#endif

        if ((sockfd = socket(p->ai_family, p->ai_socktype,
                p->ai_protocol)) == -1) {
            perror("listener: socket");
            continue;
        }

        if (bind(sockfd, p->ai_addr, p->ai_addrlen) == -1) {
            close(sockfd);
            perror("listener: bind");
            continue;
        }

        /* Join the multicast group. We do this seperately depending on whether we
        * are using IPv4 or IPv6. WSAJoinLeaf is supposed to be IP version agnostic
        * but it looks more complex than just duplicating the required code. */
        //if (p->ai_family == PF_INET) /* IPv4 */
        {
            struct ip_mreq imr;	/* Ip multicast membership */
            
            /* setting up imr structure */
            imr.imr_multiaddr.s_addr = inet_addr(LLMNR_MCAST_V4GROUP);
            //imr.imr_interface.s_addr = INADDR_ANY;   
            imr.imr_interface.s_addr = inet_addr(v4_addr);
	
	        if (setsockopt(sockfd, IPPROTO_IP, IP_ADD_MEMBERSHIP, (void *)&imr, sizeof(struct ip_mreq)) < 0)
	        {
                perror("setsockopt(udp, IP_ADD_MEMBERSHIP)");
        	    return -1;
            }
        }
#if 0        
        else if (p->ai_family == PF_INET6) /* IPv6 */
        {
            struct ipv6_mreq multicastRequest; /* Multicast address join structure */
            
            /* Specify the multicast group */
            memcpy(&multicastRequest.ipv6mr_multiaddr,
                &((struct sockaddr_in6*)(multicastAddr->ai_addr))->sin6_addr,
                sizeof(multicastRequest.ipv6mr_multiaddr));
            
            /* Accept multicast from any interface */
            multicastRequest.ipv6mr_interface = 0;
            
            /* Join the multicast address */
            if ( setsockopt(sockfd, IPPROTO_IPV6, IPV6_ADD_MEMBERSHIP, (char*) &multicastRequest, sizeof(multicastRequest)) != 0 )
            {
                perror("setsockopt() failed");
            }
        }
        else
        {
            perror("Neither IPv4 or IPv6");
        }
#endif
        
        break;
    }

    if (p == NULL){
        perror("listener: failed to bind socket\n");
        exit(1);
    }

    freeaddrinfo(servinfo);
    
    process_llmnr(sockfd);

    close(sockfd);

    return 0;
}
