/*
 *   $Id: recv.c,v 1.4 2009/06/09 06:32:18 macpaul_lin Exp $
 *
 *   Authors:
 *    Pedro Roque		<roque@di.fc.ul.pt>
 *    Lars Fenneberg		<lf@elemental.net>	 
 *
 *   This software is Copyright 1996,1997 by the above mentioned author(s), 
 *   All Rights Reserved.
 *
 *   The license which is distributed with this software in the file COPYRIGHT
 *   applies to this software. If your distribution is missing this file, you
 *   may request it from <pekkas@netcore.fi>.
 *
 */

#include <config.h>
#include <includes.h>
#include <radvd.h>


/* There is a bug in __cmsg_nxthdr , so we define by ourself */
#define CMSG_NXTHDR2(mhdr, cmsg) __cmsg_nxthdr2 (mhdr, cmsg)

struct cmsghdr *
#if __GNUC__ >= 4
__cmsg_nxthdr2 (struct msghdr *__mhdr, struct cmsghdr *__cmsg)
#else
__cmsg_nxthdr2 (struct msghdr *__mhdr, struct cmsghdr *__cmsg) __THROW
#endif
{
  if ((size_t) __cmsg->cmsg_len < sizeof (struct cmsghdr))
    /* The kernel header does this so there may be a reason.  */
    return 0;

  __cmsg = (struct cmsghdr *) ((unsigned char *) __cmsg
                               + CMSG_ALIGN (__cmsg->cmsg_len));
  if ((unsigned char *) (__cmsg + 1) >= ((unsigned char *) __mhdr->msg_control
                                         + __mhdr->msg_controllen)
      || ((unsigned char *) __cmsg + CMSG_ALIGN (__cmsg->cmsg_len)
          > ((unsigned char *) __mhdr->msg_control + __mhdr->msg_controllen)))
    /* No more entries.  */
    return 0;
  return __cmsg;
}



int
recv_rs_ra(int sock, unsigned char *msg, struct sockaddr_in6 *addr,
                 struct in6_pktinfo **pkt_info, int *hoplimit)
{                 
	struct msghdr mhdr;
	struct cmsghdr *cmsg;
	struct cmsghdr *cmsg2;
	struct iovec iov;
	static unsigned char *chdr = NULL;
	static unsigned int chdrlen = 0;
	int len;
	fd_set rfds;

	if( ! chdr )
	{
		chdrlen = CMSG_SPACE(sizeof(struct in6_pktinfo)) +
				CMSG_SPACE(sizeof(int));
		if ((chdr = malloc(chdrlen)) == NULL) {
			flog(LOG_ERR, "recv_rs_ra: malloc: %s", strerror(errno));
			return -1;
		}
	}

	FD_ZERO( &rfds );
	FD_SET( sock, &rfds );

	if( select( sock+1, &rfds, NULL, NULL, NULL ) < 0 )
	{
		if (errno != EINTR)
			flog(LOG_ERR, "select: %s", strerror(errno));
			
		return -1;
	}

	iov.iov_len = MSG_SIZE;
	iov.iov_base = (caddr_t) msg;

	memset(&mhdr, 0, sizeof(mhdr));
	mhdr.msg_name = (caddr_t)addr;
	mhdr.msg_namelen = sizeof(*addr);
	mhdr.msg_iov = &iov;
	mhdr.msg_iovlen = 1;
	mhdr.msg_control = (void *)chdr;
	mhdr.msg_controllen = chdrlen;

	len = recvmsg(sock, &mhdr, 0);
	
	if (len < 0)
	{
		if (errno != EINTR)
			flog(LOG_ERR, "recvmsg: %s", strerror(errno));
			
		return len;
	}

	*hoplimit = 255;

	int count = 0;

        for (cmsg = CMSG_FIRSTHDR(&mhdr); cmsg != NULL; cmsg = CMSG_NXTHDR2(&mhdr, cmsg))
	{
		
//	flog(LOG_ERR, "#######count = %d",count);
	count++;
	 if (cmsg->cmsg_level != IPPROTO_IPV6)
          	continue;
	
//         flog(LOG_ERR, "#######cmsg->cmsg_type = %d",cmsg->cmsg_type);
  
          switch(cmsg->cmsg_type)
          {
              case IPV6_HOPLIMIT:
                if ((cmsg->cmsg_len == CMSG_LEN(sizeof(int))) && 
                    (*(int *)CMSG_DATA(cmsg) >= 0) && 
                    (*(int *)CMSG_DATA(cmsg) < 256))
                {
//			flog(LOG_ERR, "#######PACKET HOP LIMIT");
                  *hoplimit = *(int *)CMSG_DATA(cmsg);
                }
                else
                {
                  flog(LOG_ERR, "received a bogus IPV6_HOPLIMIT from the kernel! len=%d, data=%d",
                  	cmsg->cmsg_len, *(int *)CMSG_DATA(cmsg));
                  return (-1);	
                }  
                break;
              case IPV6_PKTINFO:
                if ((cmsg->cmsg_len == CMSG_LEN(sizeof(struct in6_pktinfo))) &&
                    ((struct in6_pktinfo *)CMSG_DATA(cmsg))->ipi6_ifindex)
                {
//			flog(LOG_ERR, "#######PACKET INFO");
                  *pkt_info = (struct in6_pktinfo *)CMSG_DATA(cmsg);
                }
                else
                {
                  flog(LOG_ERR, "received a bogus IPV6_PKTINFO from the kernel! len=%d, index=%d", 
                  	cmsg->cmsg_len, ((struct in6_pktinfo *)CMSG_DATA(cmsg))->ipi6_ifindex);
                  return (-1);
                } 
                break;
          }
	}

//	dlog(LOG_DEBUG, 4, "recvmsg len=%d", len);

	return len;
}
