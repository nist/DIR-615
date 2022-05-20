

#include "mld.h"



struct ifrx  aifr[MAX_IF_NUM];
struct mldgroupx *pgmg;
       int  ifcnt;
       int  sock0, sock1;
       char  recvbuf[1600];

int opensock(void);
int loop(void);
int ismld(struct sockaddr_ll *psa, char *data, int dlen);
int test(struct sockaddr_ll* psa, char *data, int dlen);




int main(int argc, char **argv) {
	int ret=0;

	printf("Enter mldc, ==== argc=%d, argv[0]=%s, argv[1]=%s, argv[2]=%s  ====\n", argc, argv[0], argv[1], argv[2]);
	if (3!=argc) {
		printf("usage: mldc [lan-if] [wan-if] &\n");
		return -1;
	}

	memset((void*)aifr, 0, sizeof(aifr));
	ifinit(argv[1], argv[2]);

	ret = opensock();
	if (-1==ret) {
		return -1;
	}

	loop();

	return 0;
}


int opensock(void) {
	int  ret=0, val=256*1024;

	sock0 = socket(PF_PACKET, SOCK_DGRAM, htons(ETH_P_IPV6));
	if (-1==sock0) {
		return -1;
	}

	ret = setsockopt(sock0, SOL_SOCKET, SO_RCVBUF, &val, sizeof(val));
	if (0!=ret) {
		close(sock0);
		return -1;
	}

	sock1 = socket(PF_PACKET, SOCK_DGRAM, htons(ETH_P_IPV6));
	if (-1==sock1) {
		close(sock0);
		return -1;
	}

	return 0;
}


int loop() {
	int     len=0, ls, ism=0;
	fd_set  fdr, fdw;
	struct sockaddr_ll  sa;
	socklen_t  salen=sizeof(sa);

//	ls = (sock0>sock1)?sock0:sock1;
	ls = sock0;
	memset(recvbuf, 0, sizeof(recvbuf));

	FD_ZERO(&fdr);
	FD_ZERO(&fdw);
	FD_SET(sock0, &fdr);
//	FD_SET(sock1, &fdr);

	while (1) {
//		Smldqry(aifr[0].ifidx, 0, 0); // test mld query
		if (0>=select(ls+1, &fdr, NULL, NULL, NULL)) {
			continue;
		}

		if (FD_ISSET(sock0, &fdr)) {
			struct ip6_hdr *ph6;

			memset(&sa, 0, sizeof(sa));
			len = recvfrom(sock0, recvbuf, sizeof(recvbuf), 0, (struct sockaddr*)&sa, (socklen_t*)&salen);
			if (0>=len) {
				continue;
			}

			ph6 = (struct ip6_hdr*)recvbuf;

			// useless pkt (ucast, NS.NA.RS.RA.Redirect, ...)
			if (  (htons(ETH_P_IPV6)!=sa.sll_protocol)
			   || (PACKET_OUTGOING==sa.sll_pkttype) ) {
				continue;
			}

			if (!IN6_IS_ADDR_MULTICAST(&(ph6->ip6_dst))) {
				continue;
			}

			if (  IN6_IS_ADDR_UNSPECIFIED(&(ph6->ip6_src))
			   || IN6_IS_ADDR_MULTICAST(&(ph6->ip6_src)) ) {
				continue;
			}

			if (IN6_IS_ADDR_LINKLOCAL(&(ph6->ip6_src))) {
				//check ismld here
				ism = ismld(&sa, recvbuf, len);
				continue;
			}

			if (3>=(ph6->ip6_dst.s6_addr[1]&0xf)) {
				continue;
			}

			if (0==(ph6->ip6_hlim)--) {
				continue;
			}

			if (0<gpcnt)
				test(&sa, recvbuf, len);

		}
	}
	close(sock0);
	close(sock1);
	return 0;
}


int test( struct sockaddr_ll *psa,
                 char        *data,
                 int          dlen)
{
	int ret=0, oldifidx=psa->sll_ifindex;
	struct ip6_hdr *ph6=(struct ip6_hdr*)data;
	struct mldgroupx *p=0;
	int sd=0;

	if (1!=findgp((struct in6_addr*)&(ph6->ip6_dst), 0, &p)) {
		return -1;
	}

	if (!(p->ifx->isquerier)) {
		return -1;
	}

	if (-1==chk_hbhopt(data, dlen)) {
		return -1;
	}

	if (-1==(sd=socket(PF_PACKET, SOCK_DGRAM, htons(ETH_P_IPV6)))) {
		return -1;
	}

	*((uint16_t*)&(psa->sll_addr[0])) = 0x3333;
	memcpy(psa->sll_addr+2, ph6->ip6_dst.s6_addr+12, 4);

	psa->sll_ifindex = p->ifx->ifidx;

	if (0>=(ret=sendto(sd, (const void*)data, dlen, 0, (const struct sockaddr*)psa, (socklen_t)sizeof(struct sockaddr_ll)))) {
		if (EMSGSIZE==errno) {
			int mtu=0;
			if (-1!=(mtu=getmtu(p->ifx->name)))
				sendd2big(data, dlen, mtu); //send too big
		}
		close(sd);
		return -1;
	}

	close(sd);
	return 0;
}
