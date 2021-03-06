/*
 * smtp.c
 *
 * This file is part of msmtp, an SMTP client.
 *
 * Copyright (C) 2000, 2003, 2004, 2005, 2006
 * Martin Lambers <marlam@marlam.de>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, write to the Free Software Foundation,
 *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */
 
#if 0
#define DEBUG_MSG(fmt, arg...)       printf(fmt, ##arg)
#else
#define DEBUG_MSG(fmt, arg...) 
#endif 

#ifdef HAVE_CONFIG_H
# include "config.h"
#endif

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <stdarg.h>
#include <string.h>
#include <strings.h>
#include <ctype.h>
#include <errno.h>
#include <time.h>
#include <sys/stat.h>
#include <unistd.h>
//jimmy added
#include <syslog.h>
//-------------

extern int errno;

#ifdef HAVE_LIBGSASL
# include <gsasl.h>
#else
# include "base64.h"
# include "hmac.h"
#endif

#include "gettext.h"
#include "xalloc.h"
#include "xvasprintf.h"

#include "list.h"
#include "net.h"
#include "smtp.h"
#include "stream.h"
#ifdef HAVE_TLS
#include "tls.h"
#endif /* HAVE_TLS */

/*
* Date: 2009-01-14
* Name: Anderson Chen
* Detail: remove nvram header file
*/
//#include "nvram.h"
#include "sutil.h"
#include "shvar.h"
/* This defines the maximum number of lines in a multiline server reply.
 * This limit exists to prevent an extremely long reply from eating
 * all the memory.
 * The longest server reply we have to expect is the repsonse to the EHLO
 * command. We should have enough lines for every SMTP extension known today
 * plus more lines for future extensions.
 */
#define SMTP_MAXLINES 50

/* This defines the length of the *input* buffer for SMTP messages.
 * According to RFC 2821, SMTP commands and SMTP messages may contain
 * at most 512 characters including CRLF, thus the *minimum* size is
 * 512 characters.
 */
#define SMTP_BUFSIZE 1024

/* This defines the length of the *output* buffer for SMTP commands, without
 * CRLF. According to RFC 2821, SMTP commands may contain at most 512
 * characters including CRLF, thus the maximum size should be 510 characters.
 * But this is not sufficient for some authentication mechanisms, notably
 * GSSAPI, so this value must be higher.
 */
#define SMTP_MAXCMDLEN 1022

/* The maximum length of the SMTP command pipeline (the maximum number of
 * commands that are sent at once, before starting to read the replies). This
 * number should be large enough to keep the benefits of pipelining (saved round
 * trips), and small enough to avoid problems (exceeding the TCP window size).
 * A value of 1 disables pipelining.
 */
#define SMTP_PIPELINE_LIMIT 100

/* This is the buffer length for copying the mail to the SMTP server.
 * According to RFC 2822, a line in a mail can contain at most 998 
 * characters + CRLF. Plus one character for '\0' = 1001 characters.
 * All lines should fit in a buffer of this size.
 * However, this length is not a limit; smtp_send_mail() will accept 
 * arbitrary long lines.
 */
#define MAIL_BUFSIZE 1024

/*  
* Date: 2009-01-07
* Name: Albert 
* Detail: for remove link with sutil.so
*/		
extern char LocalHostName[];
char SenderEmail[64] ={};
/*
 * smtp_new()
 *
 * see smtp.h
 */

smtp_server_t smtp_new(FILE *debug, int protocol)
{
    smtp_server_t srv;

    srv.fd = -1;
    net_readbuf_init(&(srv.readbuf));
#ifdef HAVE_TLS
    tls_clear(&srv.tls);
#endif /* HAVE_TLS */
    srv.protocol = protocol;
    srv.cap.flags = 0;
    srv.cap.size = 0;
    srv.debug = debug;
    return srv;
}


/*
 * smtp_connect()
 *
 * see smtp.h
 */

int smtp_connect(smtp_server_t *srv, const char *host, int port, int timeout,
	char **server_canonical_name, char **server_address, 
	char **errstr)
{
    return net_open_socket(host, port, timeout, &srv->fd, 
	    server_canonical_name, server_address, errstr);
}


/*
 * smtp_get_msg()
 * 
 * This function gets a message from the SMTP server 'srv'.
 * In case of success, 'msg' will contain a pointer to a newly created list, 
 * and each member of this list will contain one line of the message as an 
 * allocated string. The list will contain at least one line. Each line will 
 * be at least 4 characters long: The three digit status code plus a ' ' or '-'.
 * Each line will be at most SMTP_BUFSIZE characters long, including '\0'.
 * The return code will be EOK.
 * In case of failure, 'msg' will be NULL, and one of the following error codes
 * will be returned: SMTP_EIO, SMTP_EPROTO
 */

int smtp_get_msg(smtp_server_t *srv, list_t **msg, char **errstr)
{
    list_t *l;
    list_t *lp;
    char line[SMTP_BUFSIZE];
    int counter;
    size_t len;
    char buf[256]={};
    time_t clock;
    struct tm *tm;
    time(&clock);
    tm = localtime(&clock) ;
    strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);


    *msg = NULL;
    l = list_new();
    lp = l;

    counter = 0;
    
    do
    {
#ifdef HAVE_TLS
		if (tls_is_active(&srv->tls))
		{
		    if (tls_gets(&srv->tls, line, SMTP_BUFSIZE, &len, errstr) 
			    != TLS_EOK)
		    {
			list_xfree(l, free);
			return SMTP_EIO;
		    }
		}
		else
		{
#endif /* HAVE_TLS */
		    if (net_gets(srv->fd, &(srv->readbuf), line, SMTP_BUFSIZE, &len, 
				errstr) != NET_EOK)
		    {
				list_xfree(l, free);
				return SMTP_EIO;
		    }
#ifdef HAVE_TLS
		}
#endif /* HAVE_TLS */

		if (len < 4 
			|| !(isdigit((unsigned char)line[0]) 
			    && isdigit((unsigned char)line[1]) 
			    && isdigit((unsigned char)line[2]) 
			    && (line[3] == ' ' || line[3] == '-'))
			|| line[len - 1] != '\n')
		{
		    list_xfree(l, free);
		    /* The string is not necessarily a reply (it may be the initial OK
		     * message), but this is the term used in the RFCs.
		     * An empty reply is a special case of an invalid reply - this
		     * differentiation may help the user. */
		    if (counter == 0 && len == 0)
		    {
				*errstr = xasprintf(_("the server sent an empty reply"));
				//jimmy modified
				//save2file(LOG_FILE_HTTP,"[email failed] the server sent an empty reply, %s\n",buf);
				syslog(LOG_ERR,"[email failed] the server sent an empty reply, %s\n",buf);
		    }
		    else
		    {
				*errstr = xasprintf(_("the server sent an invalid reply"));
				//jimmy modified
				//save2file(LOG_FILE_HTTP,"[email failed] the server sent an invalid reply, %s\n",buf);
				syslog(LOG_ERR,"[email failed] the server sent an invalid reply, %s\n",buf);
		    }
		    return SMTP_EPROTO;
		}
		
		if (srv->debug)
		{
		    fputs("<-- ", srv->debug);
		    fwrite(line, sizeof(char), len, srv->debug);
		}
		
	/* kill CRLF */
		line[--len] = '\0';
		if (line[len - 1] == '\r')
		{
		    line[--len] = '\0';
		}
		
		list_insert(lp, xstrdup(line));
		counter++;
		lp = lp->next;
    }
    while (line[3] == '-' && counter <= SMTP_MAXLINES);
    

    if (counter > SMTP_MAXLINES)
    {
		list_xfree(l, free);
		*errstr = xasprintf(_("Rejecting server reply that is longer "
			    "than %d lines. Increase SMTP_MAXLINES."), SMTP_MAXLINES);
		//jimmy modified
		//save2file(LOG_FILE_HTTP,"[email failed] Rejecting server reply that is longer than %d lines , %s\n",SMTP_MAXLINES,buf);
		syslog(LOG_ERR,"[email failed] Rejecting server reply that is longer than %d lines , %s\n",SMTP_MAXLINES,buf);
		return SMTP_EPROTO;
    }
    
    *msg = l;
    return SMTP_EOK;
}


/*
 * smtp_msg_status()
 *
 * see smtp.h
 */

int smtp_msg_status(list_t *msg)
{
    /* we know that *msg is valid; there's no need to check for errors */
    return atoi(msg->next->data);
}


/*
 * smtp_put()
 *
 * This function writes 'len' characters from 's' to the SMTP server 'srv'.
 * Used error codes: SMTP_EIO
 */

int smtp_put(smtp_server_t *srv, const char *s, size_t len, char **errstr)
{
    int e = 0;

#ifdef HAVE_TLS
    if (tls_is_active(&srv->tls))
    {
		e = (tls_puts(&srv->tls, s, len, errstr) != TLS_EOK);
    }
    else
    {
#endif /* HAVE_TLS */
		e = (net_puts(srv->fd, s, len, errstr) != NET_EOK);
#ifdef HAVE_TLS
    }
#endif /* HAVE_TLS */
    if (e)
    {
		printf("smtp_put: net_puts error\n");
		return SMTP_EIO;
    }
    if (srv->debug)
    {
		fputs("--> ", srv->debug);
		fwrite(s, sizeof(char), len, srv->debug);
    }
    return SMTP_EOK;
}


/*
 * smtp_send_cmd()
 *
 * This function writes a string to the SMTP server 'srv'. The string may not 
 * be longer than SMTP_MAXCMDLEN characters (see above). TCP CRLF ('\r\n') will
 * be appended to the string. Use this function to send SMTP commands (not mail
 * data) to the SMTP server.
 * Used error codes: SMTP_EIO, SMTP_EINVAL
 */

/* make gcc print format warnings for this function */
#ifdef __GNUC__
int smtp_send_cmd(smtp_server_t *srv, char **errstr, const char *format, ...) 
    __attribute__ ((format (printf, 3, 4)));
#endif

int smtp_send_cmd(smtp_server_t *srv, char **errstr, const char *format, ...)
{
    char line[SMTP_MAXCMDLEN + 3];
    int count;
    va_list args;
    char buf[256]={};
    time_t clock;
    struct tm *tm;
    time(&clock);
    tm = localtime(&clock) ;
    strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);

    va_start(args, format);
    count = vsnprintf(line, SMTP_MAXCMDLEN + 1, format, args);	
    va_end(args);
    if (count >= SMTP_MAXCMDLEN + 1)
    {
	*errstr = xasprintf(_("Cannot send command because it is "
		"longer than %d characters. Increase SMTP_MAXCMDLEN."), 
		SMTP_MAXCMDLEN);
	//jimmy modified
	//save2file(LOG_FILE_HTTP,"[email failed] Cannot send command because it is longer than %d characters, %s\n",SMTP_MAXCMDLEN,buf);
	syslog(LOG_ERR,"[email failed] Cannot send command because it is longer than %d characters, %s\n",SMTP_MAXCMDLEN,buf);
	return SMTP_EINVAL;
    }
    line[count++] = '\r';
    line[count++] = '\n';
    line[count] = '\0';
    return smtp_put(srv, line, (size_t)count, errstr);
}


/*
 * smtp_get_greeting()
 *
 * see smtp.h
 */

int smtp_get_greeting(smtp_server_t *srv, list_t **errmsg, char **buf, 
	char **errstr)
{
    int e;
    list_t *msg;
    char temp_buf[256]={};
    time_t clock;
    struct tm *tm;
    time(&clock);
    tm = localtime(&clock) ;
    strftime(temp_buf,sizeof(temp_buf),"%A, %B %d, %Y %X",tm);

    *errmsg = NULL;
    DEBUG_MSG("smtp_get_greeting\n");
    
    if ((e = smtp_get_msg(srv, &msg, errstr)) != SMTP_EOK)
    {
		return e;
    }
    
    if (smtp_msg_status(msg) != 220)
    {
		*errmsg = msg;
		*errstr = xasprintf(_("cannot get initial OK message from server"));
		//jimmy modified
		//save2file(LOG_FILE_HTTP,"[email failed] cannot get initial OK message from server, %s\n",temp_buf);
		syslog(LOG_ERR,"[email failed] cannot get initial OK message from server, %s\n",temp_buf);
		return SMTP_EPROTO;
    }
    
    if (buf)
    {
		*buf = xmalloc(
			(strlen((char *)msg->next->data + 4) + 1) * sizeof(char));
		strcpy(*buf, (char *)(msg->next->data) + 4);
    }
    
    list_xfree(msg, free);
    
    return SMTP_EOK;
}


/*
 * smtp_init()
 *
 * see smtp.h
 */

int smtp_init(smtp_server_t *srv, const char *ehlo_domain, list_t **errmsg, 
	char **errstr)
{
    int e;
    list_t *ehlo_response;
    list_t *lp;
    char *s;
    char *p;
    size_t len;
    int i;
    char buf[256]={};
    time_t clock;
    struct tm *tm;
    time(&clock);
    tm = localtime(&clock) ;
    strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
    
    DEBUG_MSG("smtp_init start\n");
    
    srv->cap.flags = 0;

    *errmsg = NULL;
    if (srv->protocol == SMTP_PROTO_SMTP)
    {
		DEBUG_MSG("smtp_init: SMTP_PROTO_SMTP\n");
		 
		if ((e = smtp_send_cmd(srv, errstr, "EHLO %s", ehlo_domain)) 
			!= SMTP_EOK)
		{
		    return e;
		}
		
		if ((e = smtp_get_msg(srv, &ehlo_response, errstr)) != SMTP_EOK)
		{
		    return e;
		}
		
		if (smtp_msg_status(ehlo_response) != 250)
		{
		    /* fall back to HELO, for very old SMTP servers */
		    list_xfree(ehlo_response, free);
		    if ((e = smtp_send_cmd(srv, errstr, "HELO %s", ehlo_domain)) 
			    != SMTP_EOK)
		    {
				return e;
		    }
		    
		    if ((e = smtp_get_msg(srv, &ehlo_response, errstr)) != SMTP_EOK)
		    {
				return e;
		    }
		    
		    if (smtp_msg_status(ehlo_response) != 250)
		    {
				*errmsg = ehlo_response;
				*errstr = xasprintf(_("SMTP server does not accept "
					    "EHLO or HELO commands"));
				//jimmy modified
				//save2file(LOG_FILE_HTTP,"[email failed] SMTP server does not accept EHLO or HELO commands, %s\n",buf);	
				syslog(LOG_ERR,"[email failed] SMTP server does not accept EHLO or HELO commands, %s\n",buf);	
				return SMTP_EPROTO;
		    }
		    
		    list_xfree(ehlo_response, free);
		    /* srv->cap.flags is 0 */
		    return SMTP_EOK;
		}
    }
    else /* protocol is LMTP */
    {
		if ((e = smtp_send_cmd(srv, errstr, "LHLO %s", ehlo_domain)) 
			!= SMTP_EOK)
		{
		    return e;
		}
		if ((e = smtp_get_msg(srv, &ehlo_response, errstr)) != SMTP_EOK)
		{
		    return e;
		}
		if (smtp_msg_status(ehlo_response) != 250)
		{
		    *errmsg = ehlo_response;
		    *errstr = xasprintf(_("command %s failed"), "LHLO");
			//jimmy modified
		    //save2file(LOG_FILE_HTTP,"[email failed] command LHLO failed, %s\n",buf);
			syslog(LOG_ERR,"[email failed] command LHLO failed, %s\n",buf);
		    return SMTP_EPROTO;
		}
    }

    lp = ehlo_response;
    while (!list_is_empty(lp))
    {
		lp = lp->next;
		s = lp->data;
		len = strlen(s);
		/* we know that len is >= 4 */
		/* make line uppercase */
	    	for (i = 4; (size_t)i < len; i++)
		{
		    s[i] = toupper((unsigned char)s[i]);
		}
		/* search capabilities */
		if (strncmp(s + 4, "STARTTLS", 8) == 0)
		{
	    	    srv->cap.flags |= SMTP_CAP_STARTTLS;
		}
		else if (strncmp(s + 4, "DSN", 3) == 0)
		{
		    srv->cap.flags |= SMTP_CAP_DSN;
		}
		else if (strncmp(s + 4, "PIPELINING", 10) == 0)
		{
		    srv->cap.flags |= SMTP_CAP_PIPELINING;
		}
		else if (strncmp(s + 4, "SIZE", 4) == 0)
		{
		    /* If there's no number after the SIZE keyword, the server does not
		     * tell us about a maximum message size. Treat that as if the SIZE 
		     * keyword was not seen. Also treat invalid numbers the same way.
		     * The value 0 means there is no maximum.
		     * See RFC 1653. */
		    errno = 0;
		    srv->cap.size = strtol(s + 8, &p, 10);
		    if (!(*(s + 8) == '\0' || *p != '\0' || srv->cap.size < 0
			    || (srv->cap.size == LONG_MAX && errno == ERANGE)))
		    {
				srv->cap.flags |= SMTP_CAP_SIZE;
		    }
		}
		/* Accept "AUTH " as well as "AUTH=". There are still some broken
		 * servers that use "AUTH=". */
	     	else if (strncmp(s + 4, "AUTH", 4) == 0 
			&& (*(s + 8) == ' ' || *(s + 8) == '='))
		{
	    	    srv->cap.flags |= SMTP_CAP_AUTH;
		    if (strstr(s + 9, "PLAIN"))
		    {
	    		srv->cap.flags |= SMTP_CAP_AUTH_PLAIN;
		    }
		    if (strstr(s + 9, "CRAM-MD5"))
		    {
				srv->cap.flags |= SMTP_CAP_AUTH_CRAM_MD5;
		    }
		    if (strstr(s + 9, "DIGEST-MD5"))
		    {
				srv->cap.flags |= SMTP_CAP_AUTH_DIGEST_MD5;
		    }
		    if (strstr(s + 9, "GSSAPI"))
		    {
				srv->cap.flags |= SMTP_CAP_AUTH_GSSAPI;
		    }
		    if (strstr(s + 9, "EXTERNAL"))
		    {
				srv->cap.flags |= SMTP_CAP_AUTH_EXTERNAL;
		    }
		    if (strstr(s + 9, "LOGIN"))
		    {
				srv->cap.flags |= SMTP_CAP_AUTH_LOGIN;
		    }
		    if (strstr(s + 9, "NTLM"))
		    {
				srv->cap.flags |= SMTP_CAP_AUTH_NTLM;
		    }
		}
		else if (strncmp(s + 4, "ETRN", 4) == 0)
		{
		    srv->cap.flags |= SMTP_CAP_ETRN;
		}
    }

    list_xfree(ehlo_response, free);
    
    DEBUG_MSG("smtp_init end\n");
    return SMTP_EOK;
}


/*
 * smtp_tls_init()
 *
 * see smtp.h
 */

#ifdef HAVE_TLS
int smtp_tls_init(smtp_server_t *srv, const char *tls_key_file, 
	const char *tls_ca_file, const char *tls_trust_file, 
	int force_sslv3, char **errstr)
{
    return tls_init(&srv->tls, tls_key_file, tls_ca_file, tls_trust_file, 
	    force_sslv3, errstr);
}
#endif /* HAVE_TLS */


/*
 * smtp_tls_starttls()
 *
 * see smtp.h
 */

#ifdef HAVE_TLS
int smtp_tls_starttls(smtp_server_t *srv, list_t **error_msg, char **errstr)
{
    int e;
    list_t *msg;

    *error_msg = NULL;
    if ((e = smtp_send_cmd(srv, errstr, "STARTTLS")) != SMTP_EOK)
    {
	return e;
    }
    if ((e = smtp_get_msg(srv, &msg, errstr)) != SMTP_EOK)
    {
		return e;
    }
    if (smtp_msg_status(msg) != 220)
    {
	*error_msg = msg;
	*errstr = xasprintf(_("command %s failed"), "STARTTLS");
	return SMTP_EPROTO;
    }
    list_xfree(msg, free);
    return SMTP_EOK;
}
#endif /* HAVE_TLS */


/*
 * smtp_tls()
 *
 * see smtp.h
 */

#ifdef HAVE_TLS
int smtp_tls(smtp_server_t *srv, const char *hostname, int tls_nocertcheck,
	tls_cert_info_t *tci, char **errstr)
{
    return tls_start(&srv->tls, srv->fd, hostname, tls_nocertcheck, tci, 
	    errstr);
}
#endif /* HAVE_TLS */


/*
 * smtp_auth_plain()
 * 
 * Do SMTP authentication via AUTH PLAIN.
 * The SMTP server must support SMTP_CAP_AUTH_PLAIN
 * Used error codes: SMTP_EIO, SMTP_EPROTO, SMTP_EAUTHFAIL, SMTP_EINVAL
 */

#ifndef HAVE_LIBGSASL
int smtp_auth_plain(smtp_server_t *srv, const char *user, const char *password,
	list_t **error_msg, char **errstr)
{
    char *s;
    char *b64;
    size_t u_len;
    size_t p_len;
    size_t b64_len;
    list_t *msg;
    int e;
    int status;
    char buf[256]={};
    time_t clock;
    struct tm *tm;
    time(&clock);
    tm = localtime(&clock) ;
    strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);

    *error_msg = NULL;
    u_len = strlen(user);
    p_len = strlen(password);
    s = xmalloc((u_len + p_len + 3) * sizeof(char));
    s[0] = '\0';
    strcpy(s + 1, user);
    strcpy(s + u_len + 2, password);
    b64_len = BASE64_LENGTH(u_len + p_len + 2);
    b64 = xmalloc(b64_len + 1);
    base64_encode(s, u_len + p_len + 2, b64, b64_len + 1);
    free(s);
    
    if ((e = smtp_send_cmd(srv, errstr, "AUTH PLAIN %s", b64)) != SMTP_EOK)
    {
	free(b64);
	return e;
    }
    free(b64);
    if ((e = smtp_get_msg(srv, &msg, errstr)) != SMTP_EOK)
    {
		return e;
    }
    if ((status = smtp_msg_status(msg)) != 235)
    {
	*error_msg = msg;
	if (status == 504)
	{
	    *errstr = xasprintf(_("command %s failed"), "AUTH PLAIN");
		//jimmy modified
		//save2file(LOG_FILE_HTTP,"[email failed] command AUTH PLAIN failed, %s\n",buf);
		syslog(LOG_ERR,"[email failed] command AUTH PLAIN failed, %s\n",buf);
	    return SMTP_EPROTO;
	}
	else
	{
	    *errstr = xasprintf(_("authentication failed (method %s)"), 
		    "PLAIN");
		//jimmy modified
	    //save2file(LOG_FILE_HTTP,"[email failed] authentication failed (method PLAIN), %s\n",buf);
		syslog(LOG_ERR,"[email failed] authentication failed (method PLAIN), %s\n",buf);
	    return SMTP_EAUTHFAIL;
	}
    }
    list_xfree(msg, free);

    return SMTP_EOK;
}
#endif /* !HAVE_LIBGSASL */


/*
 * smtp_auth_login()
 * 
 * Do SMTP authentication via AUTH LOGIN.
 * The SMTP server must support SMTP_CAP_AUTH_LOGIN
 * Used error codes: SMTP_EIO, SMTP_EPROTO, SMTP_EAUTHFAIL, SMTP_EINVAL
 */

#ifndef HAVE_LIBGSASL
int smtp_auth_login(smtp_server_t *srv, const char *user, const char *password,
	list_t **error_msg, char **errstr)
{
    int e;
    list_t *msg;
    char *b64;
    size_t b64_len;
    size_t u_len;
    size_t p_len;
    char buf[256]={};
    time_t clock;
    struct tm *tm;
    time(&clock);
    tm = localtime(&clock) ;
    strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
    
    DEBUG_MSG("smtp_auth_login: start\n");

    *error_msg = NULL;
    if ((e = smtp_send_cmd(srv, errstr, "AUTH LOGIN")) != SMTP_EOK)
    {
		return e;
    }
    
    if ((e = smtp_get_msg(srv, &msg, errstr)) != SMTP_EOK)
    {
		return e;
    }
    
    if (smtp_msg_status(msg) != 334)
    {
		*error_msg = msg;
		*errstr = xasprintf(_("command %s failed"), "AUTH LOGIN");
		//jimmy modified
		//save2file(LOG_FILE_HTTP,"[email failed] command AUTH LOGIN failed, %s\n",buf);
		syslog(LOG_ERR,"[email failed] command AUTH LOGIN failed, %s\n",buf);
		return SMTP_EPROTO;
    }
    
    list_xfree(msg, free);
    u_len = strlen(user);
    b64_len = BASE64_LENGTH(u_len);
    b64 = xmalloc(b64_len + 1);
    base64_encode(user, u_len, b64, b64_len + 1);
    
    if ((e = smtp_send_cmd(srv, errstr, "%s", b64)) != SMTP_EOK)
    {
		free(b64);
		return e;
    }
    
    free(b64);
    
    if ((e = smtp_get_msg(srv, &msg, errstr)) != SMTP_EOK)
    {
		return e;
    }
    
    if (smtp_msg_status(msg) != 334)
    {
		*error_msg = msg;
		*errstr = xasprintf(_("authentication failed (method %s)"), "LOGIN");
		//jimmy modified
		//save2file(LOG_FILE_HTTP,"[email failed] authentication failed (method LOGIN), %s\n",buf);
		syslog(LOG_ERR,"[email failed] authentication failed (method LOGIN), %s\n",buf);
		return SMTP_EAUTHFAIL;
    }
    
    list_xfree(msg, free);
    p_len = strlen(password);
    b64_len = BASE64_LENGTH(p_len);
    b64 = xmalloc(b64_len + 1);
    base64_encode(password, p_len, b64, b64_len + 1);
    
    if ((e = smtp_send_cmd(srv, errstr, "%s", b64)) != SMTP_EOK)
    {
		free(b64);
		return e;
    }
    
    free(b64);
    
    if ((e = smtp_get_msg(srv, &msg, errstr)) != SMTP_EOK)
    {
		return e;
    }
    
    if (smtp_msg_status(msg) != 235)
    {
		*error_msg = msg;
		*errstr = xasprintf(_("authentication failed (method %s)"), "LOGIN");
		//jimmy modified
		//save2file(LOG_FILE_HTTP,"[email failed] authentication failed (method LOGIN), %s\n",buf);
		syslog(LOG_ERR,"[email failed] authentication failed (method LOGIN), %s\n",buf);
		return SMTP_EAUTHFAIL;
    }
    
    list_xfree(msg, free);
    
	DEBUG_MSG("smtp_auth_login: end\n");
    return SMTP_EOK;
}
#endif /* !HAVE_LIBGSASL */


/*
 * smtp_auth_cram_md5()
 *
 * Do SMTP authentication via AUTH CRAM-MD5.
 * The SMTP server must support SMTP_CAP_AUTH_CRAM_MD5
 * Used error codes: SMTP_EIO, SMTP_EPROTO, SMTP_EAUTHFAIL, SMTP_EINVAL
 */

#ifndef HAVE_LIBGSASL
int smtp_auth_cram_md5(smtp_server_t *srv, const char *user, 
	const char *password,
	list_t **error_msg, char **errstr)
{
    unsigned char digest[16];
    char hex[] = "0123456789abcdef";
    char *challenge;
    size_t challenge_len;
    char *b64;
    size_t b64_len;
    char *buf;
    char *p;
    size_t len;
    int i;
    list_t *msg;
    int e;
    char temp_buf[256]={};
    time_t clock;
    struct tm *tm;
    
    time(&clock);
    tm = localtime(&clock) ;
    strftime(temp_buf,sizeof(temp_buf),"%A, %B %d, %Y %X",tm);

    *error_msg = NULL;
    
    
    if ((e = smtp_send_cmd(srv, errstr, "AUTH CRAM-MD5")) != SMTP_EOK)
    {
		return e;
    }
    
     
    if ((e = smtp_get_msg(srv, &msg, errstr)) != SMTP_EOK)
    {
		return e;
    }
    
    
    if (smtp_msg_status(msg) != 334)
    {
		*error_msg = msg;
		*errstr = xasprintf(_("command %s failed"), "AUTH CRAM-MD5");
		//jimmy modified
		//save2file(LOG_FILE_HTTP,"[email failed]command AUTH CRAM-MD5 failed, %s\n",temp_buf);	
		syslog(LOG_ERR,"[email failed]command AUTH CRAM-MD5 failed, %s\n",temp_buf);	
		return SMTP_EPROTO;
    }
    
    
    /* we know the line is at least 4 characters long */
    challenge = (char *)(msg->next->data) + 4;
    challenge_len = strlen(challenge);
    len = 3 * (challenge_len / 4) + 2;
    b64 = xmalloc(len);
    
    
    if (!base64_decode(challenge, challenge_len, b64, &len))
    {
		list_xfree(msg, free);
		*errstr = xasprintf(_("authentication method CRAM-MD5: "
			    "server sent invalid challenge"));
		//jimmy modified
		//save2file(LOG_FILE_HTTP,"[email failed] authentication method CRAM-MD5:server sent invalid challenge, %s\n",temp_buf);
		syslog(LOG_ERR,"[email failed] authentication method CRAM-MD5:server sent invalid challenge, %s\n",temp_buf);
		return SMTP_EPROTO;
    }
    
    
    list_xfree(msg, free);
    hmac_md5(password, strlen(password), b64, len, digest);
    free(b64);
    
    /* construct username + ' ' + digest_in_hex */
    len = strlen(user);
    buf = xmalloc((len + 1 + 32 + 1) * sizeof(char));
    strcpy(buf, user);
    p = buf + len;
    *p++ = ' ';
    for (i = 0; i < 16; i++)
    {
		p[2 * i] = hex[(digest[i] & 0xf0) >> 4];
		p[2 * i + 1] = hex[digest[i] & 0x0f];
    }
    p[32] = '\0';
    
    
    b64_len = BASE64_LENGTH(len + 33);
    b64 = xmalloc(b64_len + 1);
    base64_encode(buf, len + 33, b64, b64_len + 1);
    free(buf);
    
    
    if ((e = smtp_send_cmd(srv, errstr, "%s", b64)) != SMTP_EOK)
    {
		free(b64);
		return e;
    }
    free(b64);
    
    
    if ((e = smtp_get_msg(srv, &msg, errstr)) != SMTP_EOK)
    {
		return e;
    }
    
    
    if (smtp_msg_status(msg) != 235)
    {
		*error_msg = msg;
		*errstr = xasprintf(_("authentication failed (method %s)"), "CRAM-MD5");
		//jimmy modified
		//save2file(LOG_FILE_HTTP,"[email failed] authentication failed (method CRAM-MD5), %s\n",temp_buf);
		syslog(LOG_ERR,"[email failed] authentication failed (method CRAM-MD5), %s\n",temp_buf);
		return SMTP_EAUTHFAIL;
    }
    
    
    list_xfree(msg, free);
    
	
    return SMTP_EOK;
}
#endif /* !HAVE_LIBGSASL */


/*
 * smtp_auth_external()
 * 
 * Do SMTP authentication via AUTH EXTERNAL.
 * This means the actual authentication is done via TLS; we just send the user
 * name to ther server.
 * The SMTP server must support SMTP_CAP_AUTH_EXTERNAL
 * Used error codes: SMTP_EIO, SMTP_EPROTO, SMTP_EAUTHFAIL, SMTP_EINVAL
 */

#ifndef HAVE_LIBGSASL
int smtp_auth_external(smtp_server_t *srv, const char *user,
	list_t **error_msg, char **errstr)
{
    size_t u_len;
    size_t b64_len;
    char *b64;
    list_t *msg;
    int e;
    char buf[256]={};
    time_t clock;
    struct tm *tm;
    time(&clock);
    tm = localtime(&clock) ;
    strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);

    *error_msg = NULL;
    if ((e = smtp_send_cmd(srv, errstr, "AUTH EXTERNAL")) != SMTP_EOK)
    {
	return e;
    }
    if ((e = smtp_get_msg(srv, &msg, errstr)) != SMTP_EOK)
    {
	return e;
    }
    if (smtp_msg_status(msg) != 334)
    {
	*error_msg = msg;
	*errstr = xasprintf(_("command %s failed"), "AUTH EXTERNAL");
	//jimmy modified
	//save2file(LOG_FILE_HTTP,"[email failed]command AUTH EXTERNAL failed, %s\n",buf);	
	syslog(LOG_ERR,"[email failed]command AUTH EXTERNAL failed, %s\n",buf);
	return SMTP_EPROTO;
    }
    list_xfree(msg, free);
    u_len = strlen(user);
    b64_len = BASE64_LENGTH(u_len);
    b64 = xmalloc(b64_len + 1);
    base64_encode(user, u_len, b64, b64_len + 1);
    if ((e = smtp_send_cmd(srv, errstr, "%s", b64)) != SMTP_EOK)
    {
	free(b64);
	return e;
    }
    free(b64);
    if ((e = smtp_get_msg(srv, &msg, errstr)) != SMTP_EOK)
    {
	return e;
    }
    if (smtp_msg_status(msg) != 235)
    {
	*error_msg = msg;
	*errstr = xasprintf(_("authentication failed (method %s)"), "EXTERNAL");
	//jimmy modified
	//save2file(LOG_FILE_HTTP,"[email failed] authentication failed (method EXTERNAL), %s\n",buf);
	syslog(LOG_ERR,"[email failed] authentication failed (method EXTERNAL), %s\n",buf);
	return SMTP_EAUTHFAIL;
    }
    list_xfree(msg, free);

    return SMTP_EOK;
}
#endif /* !HAVE_LIBGSASL */


/*
 * smtp_server_supports_authmech()
 *
 * see smtp.h
 */

int smtp_server_supports_authmech(smtp_server_t *srv, const char *mech)
{
    return (((srv->cap.flags & SMTP_CAP_AUTH_PLAIN)
		&& strcmp(mech, "PLAIN") == 0)
	    || ((srv->cap.flags & SMTP_CAP_AUTH_CRAM_MD5)
		&& strcmp(mech, "CRAM-MD5") == 0)
	    || ((srv->cap.flags & SMTP_CAP_AUTH_DIGEST_MD5)
		&& strcmp(mech, "DIGEST-MD5") == 0)
	    || ((srv->cap.flags & SMTP_CAP_AUTH_EXTERNAL)
		&& strcmp(mech, "EXTERNAL") == 0)
	    || ((srv->cap.flags & SMTP_CAP_AUTH_GSSAPI)
		&& strcmp(mech, "GSSAPI") == 0)
	    || ((srv->cap.flags & SMTP_CAP_AUTH_LOGIN)
		&& strcmp(mech, "LOGIN") == 0)
	    || ((srv->cap.flags & SMTP_CAP_AUTH_NTLM)
		&& strcmp(mech, "NTLM") == 0));
}


/*
 * smtp_client_supports_authmech()
 *
 * see smtp.h
 */

int smtp_client_supports_authmech(const char *mech)
{
#ifdef HAVE_LIBGSASL

    int supported = 0;
    Gsasl *ctx;
    
    if (gsasl_init(&ctx) != GSASL_OK)
    {
	return 0;
    }
    supported = gsasl_client_support_p(ctx, mech);
    gsasl_done(ctx);
    return supported;
    
#else /* not HAVE_LIBGSASL */
    
    return (strcmp(mech, "CRAM-MD5") == 0
	    || strcmp(mech, "PLAIN") == 0
	    || strcmp(mech, "EXTERNAL") == 0
	    || strcmp(mech, "LOGIN") == 0);
    
#endif /* not HAVE_LIBGSASL */
}


/*
 * smtp_auth()
 *
 * see smtp.h
 */

int smtp_auth(smtp_server_t *srv,
	const char *hostname,
	const char *user, 
	const char *password,
#ifdef HAVE_LIBGSASL
	const char *ntlmdomain,
#else
	const char *ntlmdomain UNUSED,
#endif
	const char *auth_mech,
	char *(*password_callback)(const char *hostname, const char *user),
	list_t **error_msg,
	char **errstr)
{
    char buf[256]={};
    time_t clock;
    struct tm *tm;
    time(&clock);
    tm = localtime(&clock) ;
    strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);

#ifdef HAVE_LIBGSASL
    int e;
    list_t *msg;
    Gsasl *ctx;
    Gsasl_session *sctx;
    char *input;
    char inbuf[SMTP_BUFSIZE];
    char *outbuf;
    int error_code;
    int auth_plain_special;
    char *callback_password = NULL;

    *error_msg = NULL;
    if (strcmp(auth_mech, "") != 0 
	    && !smtp_server_supports_authmech(srv, auth_mech))
    {
	*errstr = xasprintf(
		_("the server does not support authentication method %s"), 
		auth_mech);
	//jimmy modified
	//save2file(LOG_FILE_HTTP,"[email failed]the server does not support authentication method %s, %s\n",auth_mech,buf); 
	syslog(LOG_ERR,"[email failed]the server does not support authentication method %s, %s\n",auth_mech,buf); 
	return SMTP_EUNAVAIL;
    }
    if ((error_code = gsasl_init(&ctx)) != GSASL_OK)
    {
	*errstr = xasprintf(_("GNU SASL: %s"), gsasl_strerror(error_code));
	//jimmy modified
	//save2file(LOG_FILE_HTTP,"[email failed] GNU SASL: %s, %s\n",gsasl_strerror(error_code),buf);
	syslog(LOG_ERR,"[email failed] GNU SASL: %s, %s\n",gsasl_strerror(error_code),buf);
	return SMTP_ELIBFAILED;
    }
    if (strcmp(auth_mech, "") != 0 && !gsasl_client_support_p(ctx, auth_mech))
    {
	gsasl_done(ctx);
	*errstr = xasprintf(
		_("GNU SASL: authentication method %s not supported"), 
		auth_mech);
	//jimmy modified
	//save2file(LOG_FILE_HTTP,"[email failed]GNU SASL: authentication method %s not supported, %s\n",auth_mech,buf);
	syslog(LOG_ERR,"[email failed]GNU SASL: authentication method %s not supported, %s\n",auth_mech,buf);
	return SMTP_ELIBFAILED;
    }
    if (strcmp(auth_mech, "") == 0)
    {
	/* Choose "best" authentication mechanism. */
	/* TODO: use gsasl_client_suggest_mechanism()? */
	if (gsasl_client_support_p(ctx, "GSSAPI") 
		&& (srv->cap.flags & SMTP_CAP_AUTH_GSSAPI))
	{
	    auth_mech = "GSSAPI";
	}
	else if (gsasl_client_support_p(ctx, "DIGEST-MD5") 
		&& (srv->cap.flags & SMTP_CAP_AUTH_DIGEST_MD5))
	{
	    auth_mech = "DIGEST-MD5";
	}
	else if (gsasl_client_support_p(ctx, "CRAM-MD5") 
		&& (srv->cap.flags & SMTP_CAP_AUTH_CRAM_MD5))
	{
	    auth_mech = "CRAM-MD5";
	}
	else if (gsasl_client_support_p(ctx, "NTLM") 
		&& (srv->cap.flags & SMTP_CAP_AUTH_NTLM))
	{
	    auth_mech = "NTLM";
	}
#ifdef HAVE_TLS
	else if (tls_is_active(&srv->tls))
	{
	    if (gsasl_client_support_p(ctx, "PLAIN") 
		    && (srv->cap.flags & SMTP_CAP_AUTH_PLAIN))
	    {
		auth_mech = "PLAIN";
	    }
	    else if (gsasl_client_support_p(ctx, "LOGIN") 
		    && (srv->cap.flags & SMTP_CAP_AUTH_LOGIN))
	    {
		auth_mech = "LOGIN";
	    }
	}
#endif /* HAVE_TLS */
    }
    if (strcmp(auth_mech, "") == 0)
    {
	gsasl_done(ctx);
#ifdef HAVE_TLS
	if (!tls_is_active(&srv->tls))
	{
#endif /* HAVE_TLS */
	    *errstr = xasprintf(_("cannot use a secure authentication method"));
		//jimmy modified
	    //save2file(LOG_FILE_HTTP,"[email failed]cannot use a secure authentication method, %s\n",buf);
		syslog(LOG_ERR,"[email failed]cannot use a secure authentication method, %s\n",buf);
#ifdef HAVE_TLS
	}
	else
	{
	    *errstr = xasprintf(
		    _("cannot find a usable authentication method"));
     	}
#endif /* not HAVE_TLS */
	return SMTP_EUNAVAIL;
    }
    
    /* Check availability of required authentication data */
    if (strcmp(auth_mech, "EXTERNAL") != 0)
    {
	/* GSSAPI, DIGEST-MD5, CRAM-MD5, PLAIN, LOGIN, NTLM all need a user 
	 * name */
	if (!user)
	{
	    gsasl_done(ctx);
	    *errstr = xasprintf(_("authentication method %s needs a user name"),
		    auth_mech);
		//jimmy modified
	    //save2file(LOG_FILE_HTTP,"[email failed]authentication method %s needs a user name, %s\n",auth_mech,buf);
		syslog(LOG_ERR,"[email failed]authentication method %s needs a user name, %s\n",auth_mech,buf);
	    return SMTP_EUNAVAIL;
	}
	/* DIGEST-MD5, CRAM-MD5, PLAIN, LOGIN, NTLM all need a password */
	if (strcmp(auth_mech, "GSSAPI") != 0 && !password)
	{
	    if (!password_callback 
		    || !(callback_password = password_callback(hostname, user)))
	    {
		gsasl_done(ctx);
		*errstr = xasprintf(
			_("authentication method %s needs a password"),
			auth_mech);
		//jimmy modified
		//save2file(LOG_FILE_HTTP,"[email failed]authentication method %s needs a password, %s\n",auth_mech,buf);
		syslog(LOG_ERR,"[email failed]authentication method %s needs a password, %s\n",auth_mech,buf);
		return SMTP_EUNAVAIL;
	    }
	    password = callback_password;
	}
    }

    if ((error_code = gsasl_client_start(ctx, auth_mech, &sctx)) != GSASL_OK)
    {
	gsasl_done(ctx);
	*errstr = xasprintf(_("GNU SASL: %s"), gsasl_strerror(error_code));
	return SMTP_ELIBFAILED;
    }

    /* Set the authentication properties */
    if (user)
    {
	gsasl_property_set(sctx, GSASL_AUTHID, user);
	/* GSASL_AUTHZID must not be set for DIGEST-MD5, because otherwise
    	 * authentication may fail (tested with postfix). Set it only for 
	 * EXTERNAL. */
	if (strcmp(auth_mech, "EXTERNAL") == 0)
	{
	    gsasl_property_set(sctx, GSASL_AUTHZID, user);
	}
    }
    if (password)
    {
	gsasl_property_set(sctx, GSASL_PASSWORD, password);
    }
    free(callback_password);
    /* For DIGEST-MD5 and GSSAPI */
    gsasl_property_set(sctx, GSASL_SERVICE, "smtp");
    if (hostname)
    {
	gsasl_property_set(sctx, GSASL_HOSTNAME, hostname);
    }
    /* For NTLM. Postfix does not care, MS IIS needs an arbitrary non-empty
     * string. */
    if (ntlmdomain)
    {
	gsasl_property_set(sctx, GSASL_REALM, ntlmdomain);
    }

    /* Bigg authentication loop */
    input = NULL;
    do
    {
	error_code = gsasl_step64(sctx, input, &outbuf);
	if (error_code != GSASL_OK && error_code != GSASL_NEEDS_MORE)
	{
	    gsasl_finish(sctx);
	    gsasl_done(ctx);
	    *errstr = xasprintf(_("GNU SASL: %s"), gsasl_strerror(error_code));
	    return SMTP_ELIBFAILED;
	}
	if (!input)
	{
	    if (strcmp(auth_mech, "PLAIN") == 0 && outbuf[0])
	    {
		/* AUTH PLAIN needs special treatment because it needs to send
		 * the authentication data together with the AUTH PLAIN command.
		 * At least smtp.web.de requires this, and I happen to use this
		 * server :) */
		auth_plain_special = 1;
		if ((e = smtp_send_cmd(srv, errstr, 
				"AUTH PLAIN %s", outbuf)) != SMTP_EOK)
		{
		    gsasl_finish(sctx);
		    gsasl_done(ctx);
		    free(outbuf);
		    return e;
		}
	    }
	    else
	    {	    
		auth_plain_special = 0;
		if ((e = smtp_send_cmd(srv, errstr, 
				"AUTH %s", auth_mech)) != SMTP_EOK)
		{
		    gsasl_finish(sctx);
		    gsasl_done(ctx);
		    free(outbuf);
		    return e;
		}
	    }
	    if ((e = smtp_get_msg(srv, &msg, errstr)) != SMTP_EOK)
	    {
		gsasl_finish(sctx);
		gsasl_done(ctx);
	    	free(outbuf);
		return e;
	    }
	    if (smtp_msg_status(msg) != 334 && smtp_msg_status(msg) != 235)
	    {
		*error_msg = msg;
		gsasl_finish(sctx);
		gsasl_done(ctx);
		free(outbuf);
		*errstr = xasprintf(_("authentication failed (method %s)"), 
			auth_mech);
		//jimmy modified
		//save2file(LOG_FILE_HTTP,"[email failed]authentication failed (method %s), %s\n",auth_mech,buf);
		syslog(LOG_ERR,"[email failed]authentication failed (method %s), %s\n",auth_mech,buf);
		return SMTP_EAUTHFAIL;
	    }	    
	    /* msg->next->data cannot be longer than SMTP_BUFSIZE-1 */
	    strcpy(inbuf, msg->next->data);
	    list_xfree(msg, free);
	    input = inbuf + 4;
	    if (auth_plain_special)
	    {
		free(outbuf);
		continue;
	    }
	}
	/* For all mechanisms except GSSAPI, testing for (outbuf[0]) works.
	 * GSSAPI needs an additional step with empty output. */
	if (outbuf[0] 
		|| (GSASL_NEEDS_MORE && (strcmp(auth_mech, "GSSAPI") == 0)))
	{
	    if ((e = smtp_send_cmd(srv, errstr, "%s", outbuf)) != SMTP_EOK)
    	    {
		gsasl_finish(sctx);
		gsasl_done(ctx);
		free(outbuf);
		return e;
	    }
	    if ((e = smtp_get_msg(srv, &msg, errstr)) != SMTP_EOK)
	    {
		gsasl_finish(sctx);
		gsasl_done(ctx);
		free(outbuf);
		return e;
	    }
	    if (smtp_msg_status(msg) != 334 && smtp_msg_status(msg) != 235)
	    {
		*error_msg = msg;
		gsasl_finish(sctx);
		gsasl_done(ctx);
		free(outbuf);
		*errstr = xasprintf(_("authentication failed (method %s)"), 
			auth_mech);
		//jimmy modified
		//save2file(LOG_FILE_HTTP,"[email failed]authentication failed (method %s), %s\n",auth_mech,buf);
		syslog(LOG_ERR,"[email failed]authentication failed (method %s), %s\n",auth_mech,buf);
		return SMTP_EAUTHFAIL;
	    }	    
	    /* msg->next->data cannot be longer than SMTP_BUFSIZE-1 */
	    strcpy(inbuf, msg->next->data);
	    list_xfree(msg, free);
	    input = inbuf + 4;
	}
	free(outbuf);
    }
    while (error_code == GSASL_NEEDS_MORE);
    if (error_code != GSASL_OK)
    {
	gsasl_finish(sctx);
	gsasl_done(ctx);
	*errstr = xasprintf(_("authentication failed: %s (method %s)"), 
		gsasl_strerror(error_code), auth_mech);
	//jimmy modified
	//save2file(LOG_FILE_HTTP,"[email failed]authentication failed %s (method %s), %s\n",gsasl_strerror(error_code),auth_mech,buf);
	syslog(LOG_ERR,"[email failed]authentication failed %s (method %s), %s\n",gsasl_strerror(error_code),auth_mech,buf);
	return SMTP_EAUTHFAIL;
    }
    gsasl_finish(sctx);
    gsasl_done(ctx);
    /* For DIGEST-MD5, we need to send an empty answer to the last 334 
     * response before we get 235. */
    if (strncmp(inbuf, "235 ", 4) != 0)
    {
	if ((e = smtp_send_cmd(srv, errstr, "")) != SMTP_EOK)
	{
	    return e;
	}
	if ((e = smtp_get_msg(srv, &msg, errstr)) != SMTP_EOK)
	{
	    return e;
	}
	if (smtp_msg_status(msg) != 235)
	{
	    *error_msg = msg;
	    *errstr = xasprintf(_("authentication failed (method %s)"),
		    auth_mech);
		//jimmy modified
	    //save2file(LOG_FILE_HTTP,"[email failed]authentication failed (method %s), %s\n",auth_mech,buf);
		syslog(LOG_ERR,"[email failed]authentication failed (method %s), %s\n",auth_mech,buf);
	    return SMTP_EAUTHFAIL;
	}
	list_xfree(msg, free);
    }
    return SMTP_EOK;

#else /* not HAVE_LIBGSASL */

	DEBUG_MSG("smtp_auth: not HAVE_LIBGSASL: start\n");

    char *callback_password = NULL;
    int e;
      
    *error_msg = NULL;
    if (strcmp(auth_mech, "") != 0 
	    && !smtp_server_supports_authmech(srv, auth_mech))
    {
		*errstr = xasprintf( 
			_("the server does not support authentication method %s"), 
			auth_mech);
		return SMTP_EUNAVAIL;
    }
    
    if (strcmp(auth_mech, "") == 0)
    {
		/* Choose "best" authentication mechanism. */
		if (srv->cap.flags & SMTP_CAP_AUTH_CRAM_MD5)
		{
		    //auth_mech = "CRAM-MD5";
		    /* NickChou, 071130, change for smtp.pchome.com.tw
		       because this smtp server support CRAM-MD5, DIGEST-MD5, LOGIN, PLAIN
		       if we choose "best" authentication mechanism => "CRAM-MD5", we can't send mail
		       so we choose "LOGIN" to Auth
		    */
		    auth_mech = "LOGIN";
		}
		else if (srv->cap.flags & SMTP_CAP_AUTH_LOGIN)
		{
			auth_mech = "LOGIN";
		}
#ifdef HAVE_TLS
		else if (tls_is_active(&srv->tls))
		{
		    if (srv->cap.flags & SMTP_CAP_AUTH_PLAIN)
		    {
				auth_mech = "PLAIN";
		    }
		    else if (srv->cap.flags & SMTP_CAP_AUTH_LOGIN)
		    {
				auth_mech = "LOGIN";
		    }
		}
#endif /* HAVE_TLS */
    }
    
    if (strcmp(auth_mech, "") == 0)
    {
#ifdef HAVE_TLS
		if (!tls_is_active(&srv->tls))
	 	{
#endif /* HAVE_TLS */
		    *errstr = xasprintf(_("cannot use a secure authentication method"));
#ifdef HAVE_TLS
	    }
	    	else
	 	{
		    *errstr = xasprintf(
			    _("cannot find a usable authentication method"));
		}
#endif /* not HAVE_TLS */
		return SMTP_EUNAVAIL;
    }
    
    if (strcmp(auth_mech, "EXTERNAL") != 0)
    {
		/* CRAMD-MD5, PLAIN, LOGIN all need a user name and a password */
		if (!user)
		{
		    *errstr = xasprintf(_("authentication method %s needs a user name"),
			    auth_mech);
			//jimmy modified
		    //save2file(LOG_FILE_HTTP,"[email failed] authentication method %s needs a user name, %s\n",auth_mech,buf);
			syslog(LOG_ERR,"[email failed] authentication method %s needs a user name, %s\n",auth_mech,buf);
		    return SMTP_EUNAVAIL;
		}
		if (!password)
		{
		    if (!password_callback 
			    || !(callback_password = password_callback(hostname, user)))
		    {
			*errstr = xasprintf(
				_("authentication method %s needs a password"),
				auth_mech);
			//jimmy modified
			//save2file(LOG_FILE_HTTP,"[email failed] authentication method %s needs a password, %s\n",auth_mech,buf);
			syslog(LOG_ERR,"[email failed] authentication method %s needs a password, %s\n",auth_mech,buf);
			return SMTP_EUNAVAIL;
		    }
		    password = callback_password;
		}
    }
    
    DEBUG_MSG("smtp_auth: not HAVE_LIBGSASL: auth_mech=%s\n", auth_mech);

    if (strcmp(auth_mech, "CRAM-MD5") == 0)
    {
		e = smtp_auth_cram_md5(srv, user, password, error_msg, errstr);
    }
    else if (strcmp(auth_mech, "PLAIN") == 0)
    {
		e = smtp_auth_plain(srv, user, password, error_msg, errstr);
    }
    else if (strcmp(auth_mech, "EXTERNAL") == 0)
    {
		e = smtp_auth_external(srv, user ? user : "", error_msg, errstr);
    }
    else if (strcmp(auth_mech, "LOGIN") == 0)
    {
		e = smtp_auth_login(srv, user, password, error_msg, errstr);
    }
    else
    {
		*errstr = xasprintf(_("authentication method %s not supported"),
			auth_mech);
		//jimmy modified
		//save2file(LOG_FILE_HTTP,"[email failed] authentication method %s not supported, %s\n",auth_mech,buf);
		syslog(LOG_ERR,"[email failed] authentication method %s not supported, %s\n",auth_mech,buf);
		e = SMTP_ELIBFAILED;
    }
    
    DEBUG_MSG("smtp_auth: not HAVE_LIBGSASL: end\n");
    
    free(callback_password);
    return e;

#endif /* not HAVE_LIBGSASL */
}


/*
 * smtp_send_envelope()
 * 
 * see smtp.h
 */

int smtp_send_envelope(smtp_server_t *srv,
	const char *envelope_from, 
	list_t *recipients,
	const char *dsn_notify,
	const char *dsn_return,
	list_t **error_msg,
	char **errstr)
{
    int e;
    list_t *msg;    
    int mailfrom_cmd_was_sent = 0;
    int mailfrom_reply_was_rcvd = 0;
    list_t *rcpt_send = recipients;
    list_t *rcpt_recv = recipients;
    int data_cmd_was_sent = 0;
    int data_reply_was_rcvd = 0;
    int pipeline_limit = 1;
    int piped_commands = 0;
    char buf[256]={};
    time_t clock;
    struct tm *tm;
    time(&clock);
    tm = localtime(&clock) ;
    strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
    
    *error_msg = NULL;
    
    DEBUG_MSG("smtp_send_envelope: start\n");
    
    if (srv->cap.flags & SMTP_CAP_PIPELINING)
    {
		pipeline_limit = SMTP_PIPELINE_LIMIT;
    }
 /*  
* Date: 2009-01-07
* Name: Albert 
* Detail: for remove link with sutil.so
*/		       
    strcpy(SenderEmail, envelope_from);

    /* Send the MAIL FROM, RCPT TO and DATA commands using pipelining. The 
     * number of pipelined commands will never be greater than pipeline_limit
     * to avoid problems with the TCP window size (exceeding it can lead to 
     * deadlocks). pipeline_limit == 1 disables pipelining. */
    while (!data_reply_was_rcvd)
    {
		while (!data_cmd_was_sent && piped_commands < pipeline_limit)
		{
		    /* send */
		    if (!mailfrom_cmd_was_sent)
		    {
				if (dsn_return)
				{
				    printf("ret MAIL FROM:%s\n",envelope_from);
				    e = smtp_send_cmd(srv, errstr, "MAIL FROM:<%s> RET=%s", 
					    envelope_from, dsn_return);
				}
				else
				{
				    printf("MAIL FROM:%s\n",envelope_from);
				    e = smtp_send_cmd(srv, errstr, "MAIL FROM:<%s>", 
					    envelope_from);
				}
				if (e != SMTP_EOK)
				{
				    return e;
				}		
				mailfrom_cmd_was_sent = 1;
		    }
		    else if (!list_is_empty(rcpt_send))
		    {
				rcpt_send = rcpt_send->next;
				if (dsn_notify)
				{
				    printf("notify RCPT TO:%s\n",(char *)(rcpt_send->data));
				    e = smtp_send_cmd(srv, errstr, "RCPT TO:<%s> NOTIFY=%s",
					    (char *)(rcpt_send->data), dsn_notify);
				}
				else
				{
					printf("RCPT TO:%s\n",(char *)(rcpt_send->data));
				    e = smtp_send_cmd(srv, errstr, "RCPT TO:<%s>", 
					    (char *)(rcpt_send->data));
				}
				if (e != SMTP_EOK)
				{
				    return e;
				}		
		    }
		    else
		    {
				if ((e = smtp_send_cmd(srv, errstr, "DATA")) != SMTP_EOK)
				{
				    return e;
				}
				data_cmd_was_sent = 1;
		    }
		    piped_commands++;
		}
		
		while (piped_commands > 0)
		{
		    /* receive */
		    if (!mailfrom_reply_was_rcvd)
		    {
				if ((e = smtp_get_msg(srv, &msg, errstr)) != SMTP_EOK)
				{
				    return e;
				}
				if (smtp_msg_status(msg) != 250)
				{
				    *error_msg = msg;
				    *errstr = xasprintf(_("envelope from address %s not "
						"accepted by the server"), envelope_from);
					//jimmy modified
				    //save2file(LOG_FILE_HTTP,"[email failed]envelope from address %s not accepted by the server, %s\n",envelope_from,buf);
					syslog(LOG_ERR,"[email failed]envelope from address %s not accepted by the server, %s\n",envelope_from,buf);
				    return SMTP_EINVAL;
				}
				list_xfree(msg, free);
				mailfrom_reply_was_rcvd = 1;
		    }
		    else if (!list_is_empty(rcpt_recv))
		    {
				rcpt_recv = rcpt_recv->next;
				if ((e = smtp_get_msg(srv, &msg, errstr)) != SMTP_EOK)
				{
				    return e;
				}
				if (smtp_msg_status(msg) != 250)
				{
				    *error_msg = msg;
				    *errstr = xasprintf(_("recipient address %s not "
						"accepted by the server"),
					    (char *)(rcpt_recv->data));
					//jimmy modified
				    //save2file(LOG_FILE_HTTP,"[email failed]recipient address %s not accepted by the server, %s\n",(char *)(rcpt_recv->data),buf);
					syslog(LOG_ERR,"[email failed]recipient address %s not accepted by the server, %s\n",(char *)(rcpt_recv->data),buf);
				    return SMTP_EINVAL;
				}
				list_xfree(msg, free);		
			}
		    else
		    {
				if ((e = smtp_get_msg(srv, &msg, errstr)) != SMTP_EOK)
				{
				    return e;
				}
				if (smtp_msg_status(msg) != 354)
				{
				    *error_msg = msg;
				    *errstr = xasprintf(
					    _("the server does not accept mail data"));
					//jimmy modified
				    //save2file(LOG_FILE_HTTP,"[email failed]the server does not accept mail data, %s\n",buf); 
					syslog(LOG_ERR,"[email failed]the server does not accept mail data, %s\n",buf); 
				    return SMTP_EUNAVAIL;
				}
				list_xfree(msg, free);
				data_reply_was_rcvd = 1;
		    }
		    piped_commands--;
		}
    }
	
	DEBUG_MSG("smtp_send_envelope: end\n");
    return SMTP_EOK;
}

int edit_log_file()
{
	FILE *fp_bak, *fp;
	struct stat file_buf;
	char ch;
//	char *hostname = nvram_get("hostname");
	char buffer[MAIL_BUFSIZE] ={0};
	
	DEBUG_MSG("edit_log_file: LOG_FILE_HTTP=%s,LOG_FILE_BAK=%s\n",LOG_FILE_HTTP,LOG_FILE_BAK);
	/* Ken modify for log full check */
	fp_bak=fopen(LOG_FILE_BAK, "w+");
	if(fp_bak==NULL){
		printf("edit_log_file fopen messages_bak failed\n");
		return 1;
	} 
	 
	//log full check
	if( !stat(LOG_FILE_FULL, &file_buf) ){
		DEBUG_MSG("Had messages_full file\n");
		// log is full
		if( file_buf.st_size){
			DEBUG_MSG("log is full\n");
			fp=fopen(LOG_FILE_FULL, "r");	
			if(fp==NULL){
				printf("edit_log_file fopen messages_full failed\n");
				//jimmy added
				fclose(fp_bak);
				unlink(LOG_FILE_BAK);
				// ------------
				return 1;
			}
		}	
	}
	else{
		DEBUG_MSG("No messages_full file\n");
		fp=fopen(LOG_FILE_HTTP, "r");	
		if(fp==NULL){
			printf("edit_log_file fopen messages failed\n");
			//jimmy added
			fclose(fp_bak);
			unlink(LOG_FILE_BAK);
			// ------------
			return 1;
		}
	}	
/*
* Date: 2009-01-07
* Name: Albert Chen
* Detail: remove daemon use nvram get configuration value
*/	
//	fprintf(fp_bak, "Subject: %s Log\n", hostname);
	fprintf(fp_bak, "Subject: %s Log\n", LocalHostName);
	
	fprintf(fp_bak, "\n");
	
	while(fgets(buffer, MAIL_BUFSIZE, fp)) 
	{
		fprintf(fp_bak, "\n");
		fputs(buffer, fp_bak); 
	}

	/*indicate it's the end!*/
	fprintf(fp_bak, "\n");
	fprintf(fp_bak, "e");
	fclose(fp);
	fclose(fp_bak);		
	return 0;
}
/*
* Date :2009-01-07
* Name : Albert Chen
* Add init_file function
*/
/* Init File and clear the content */
int init_file(char *file)
{
	FILE *fp;

	if ((fp = fopen(file ,"w")) == NULL) {
		printf("Can't open %s\n", file);
		exit(1);
	}

	fclose(fp);
	return 0;
}

/*
 * smtp_send_mail()
 *
 * see smtp.h
 */

int smtp_send_mail(smtp_server_t *srv, FILE *mailf, int keep_bcc, 
	long *mailsize, char **errstr)
{
	char bigbuffer[MAIL_BUFSIZE + 3];	/* buffer + leading dot + ending CRLF */
	char *buffer;
	char time_buf[256]={0};
	size_t len;
	char *send_buf;
	size_t send_len;
	int in_header;
	int in_bcc;
	int line_starts;
	int line_continues;
	int e;
	int k=0;
	FILE *fp_bak;
	struct stat file_buf;
    time_t clock;
    struct tm *tm;
    long totalsize = 0;
	
	DEBUG_MSG("smtp_send_mail: start\n");
	
  	if(edit_log_file()!=0)
	{
		printf("smtp_send_mail: edit_log_file error");
		return SMTP_EIO;
  	}
  			
	fp_bak=fopen(LOG_FILE_BAK, "r");
	
	if(fp_bak==NULL)
	{
		printf("smtp_send_mail: open LOG_FILE_BAK failed\n");
		return SMTP_EIO;
	} 
	 	
	bigbuffer[0] = '.';
	buffer = bigbuffer + 1;
	in_header = 1;
	in_bcc = 0;
	line_continues = 0;
	e = SMTP_EOK;
	for (;;)
	{
		if(stream_gets(fp_bak, buffer, MAIL_BUFSIZE, &len, errstr) != STREAM_EOK)
		{
		    printf("smtp_send_mail: stream_gets error\n");
		    return SMTP_EIO;
		}
		
		if (buffer[0] == 'e')
		{
			printf("smtp_send_mail: reading LOG_FILE_BAK finished\n");
			break;
		}
		
		line_starts = !line_continues;
		if (len > 0 && buffer[len - 1] == '\n')
		{
		    /* first case: we have a line end */
		    buffer[--len] = '\0';
		    if (len > 0 && buffer[len - 1] == '\r')
		    {
				buffer[--len] = '\0';
		    }
		    line_continues = 0;
		    DEBUG_MSG("smtp_send_mail: have a line end\n");
		}
		else if (len == MAIL_BUFSIZE - 1)
		{
		    /* second case: the line continues */
		    if (buffer[len - 1] == '\r')
		    {
				/* We have CRLF that is divided by the buffer boundary. Since CR
				 * may not appear alone in a mail according to RFC2822, we
				 * know that the next buffer will be "\n\0", so it's safe to
				 * just delete the CR. */
				buffer[--len] = '\0';
		    }
		    line_continues = 1;
		}
		else
		{
		    /* third case: this is the last line, and it lacks a newline 
		     * character */
		    line_continues = 0;
		}
		
		if (!keep_bcc)
		{
		    if (line_starts && in_header && buffer[0] == '\0')
		    {
				in_header = 0;
		    }
		    if (in_header)
		    {
				if (line_starts)
				{
				    if (!in_bcc)
				    {
						if (strncasecmp(buffer, "Bcc:", 4) == 0)
						{
						    in_bcc = 1;
						    /* remove Bcc header by ignoring this line */
						    continue;
						}
				    }
				    else
				    {
						/* continued header lines begin with "horizontal 
						 * whitespace" (RFC 2822, section 2.2.3) */
						if (buffer[0] == '\t' || buffer[0] == ' ')
						{
						    /* remove Bcc header by ignoring this line */
						    continue;
						}
						else
						{
						    in_bcc = 0;
						}
				    }
				}
				else
				{
				    if (in_bcc)
				    {
						/* remove Bcc header by ignoring this line */
				    	continue;
				    }
				}
		    }
		}
	
		send_buf = buffer;
		send_len = len;
		
		if (line_starts && buffer[0] == '.')
		{
		    /* Quote the leading dot with another dot */
		    send_buf = bigbuffer;
		    send_len = len + 1;
		    DEBUG_MSG("smtp_send_mail: Quote the leading dot with another dot\n");
		}
		
		if (!line_continues)
		{
		    /* Append CRLF */
		    buffer[len] = '\r';
		    buffer[len + 1] = '\n';
		    buffer[len + 2] = '\0';
		    send_len += 2;
		    DEBUG_MSG("smtp_send_mail: Append CRLF\n");
		}
		
		/* Update mailsize. Do not count a quote dot. Count CRLF as one
		 * character. */
		*mailsize += (long)len + (line_continues ? 0 : 1);
		
		DEBUG_MSG("smtp_send_mail: send_len=%d\n", send_len);
		DEBUG_MSG("smtp_send_mail: send_buf=%s,len=%d\n", send_buf,strlen(send_buf));
		/* 
		Kenchiang add, send contine is to long will be smtp_put error so if 
		totalsize is over 10K to do delay 
		*/
		if(totalsize > (10*1000)){
			DEBUG_MSG("smtp_send_mail: totalsize =%d\n",totalsize);
			sleep(1);
			totalsize = 0;
		}	
		if ((e = smtp_put(srv, send_buf, send_len, errstr)) != SMTP_EOK)
		{
	    	printf("smtp_send_mail: smtp_put error\n");
	    	/* NickChou add, if smtp_put error will be always error unless reboot or clear log file*/
	    	init_file(LOG_FILE_HTTP);
	    	return e;
		}
		totalsize += (long)send_len;
	}

	time(&clock);
    tm = localtime(&clock) ;
    strftime(time_buf,sizeof(time_buf),"%A, %B %d, %Y %X",tm);	
/*
* Date: 2009-01-07
* Name: Albert Chen
* Detail: remove nvram access
*/	
//	syslog(LOG_ERR,"[email sent to: %s ] %s\n",nvram_safe_get("log_email_sender"),time_buf);
	syslog(LOG_ERR,"[email sent to: %s ] %s\n",SenderEmail,time_buf);
	fclose(fp_bak);	
	DEBUG_MSG("smtp_send_mail end\n");
	return SMTP_EOK;
}


/*
 * smtp_end_mail()
 *
 * see smtp.h
 */

int smtp_end_mail(smtp_server_t *srv, list_t **error_msg, char **errstr)
{
    int e;
    list_t *msg;
    char buf[256]={};
    time_t clock;
    struct tm *tm;
    time(&clock);
    tm = localtime(&clock) ;
    strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
    *error_msg = NULL;
    
     DEBUG_MSG("smtp_end_mail : star\n");
    
    if ((e = smtp_send_cmd(srv, errstr, ".")) != SMTP_EOK)
    {
		return e;
    }
    
#if 0    //NickChou
    if ((e = smtp_get_msg(srv, &msg, errstr)) != SMTP_EOK)
    {
		return e;
    }
    
    if (smtp_msg_status(msg) != 250)  /* OK, queuing for node <x> started */
    {
		*error_msg = msg;
		*errstr = xasprintf(_("the server did not accept the mail"));
		save2file(LOG_FILE_HTTP,"[email failed]the server did not accept the mail, %s\n",buf);
		return SMTP_EUNAVAIL;
    }
    
    list_xfree(msg, free);
#else	
	sleep(3);    
#endif    
    DEBUG_MSG("smtp_end_mail : end\n");
    return SMTP_EOK;
}


/*
 * smtp_end_mail_lmtp()
 *
 * see smtp.h
 * 
 */

void _smtp_free_list_of_lists(void *l)
{
    list_xfree((list_t *)l, free);
}

int smtp_end_mail_lmtp(smtp_server_t *srv, 
	list_t *recipients, 
	list_t **errstrs,
	list_t **error_msgs,
	char **errstr)
{
    int e;
    list_t *msg;
    list_t *lp_recipients;
    list_t *lp_errstrs;
    list_t *lp_error_msgs;
    int all_recipients_accepted;
    char *tmp;
    char buf[256]={};
    time_t clock;
    struct tm *tm;
    time(&clock);
    tm = localtime(&clock) ;
    strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);

    if ((e = smtp_send_cmd(srv, errstr, ".")) != SMTP_EOK)
    {
	*errstrs = NULL;
	*error_msgs = NULL;
	return e;
    }
    
    *errstrs = list_new();
    *error_msgs = list_new();
    lp_errstrs = *errstrs;
    lp_error_msgs = *error_msgs;
    lp_recipients = recipients;
    all_recipients_accepted = 1;
    while (!list_is_empty(lp_recipients))
    {
	lp_recipients = lp_recipients->next;
	if ((e = smtp_get_msg(srv, &msg, errstr)) != SMTP_EOK)
	{
	    list_xfree(*errstrs, free);
	    *errstrs = NULL;
	    list_xfree(*error_msgs, _smtp_free_list_of_lists);
	    *error_msgs = NULL;
	    return e;
	}
	if (smtp_msg_status(msg) != 250)
	{
	    all_recipients_accepted = 0;
	    tmp = xasprintf(_("the server refuses to send the mail to %s"),
		    (char *)(lp_recipients->data));
		//jimmy modified
	    //save2file(LOG_FILE_HTTP,"[email failed]the server refuses to send the mail to %s, %s\n",(char *)(lp_recipients->data),buf);
		syslog(LOG_ERR,"[email failed]the server refuses to send the mail to %s, %s\n",(char *)(lp_recipients->data),buf);
	    list_insert(lp_errstrs, tmp);
	    list_insert(lp_error_msgs, msg);
	}
	else
	{
	    list_xfree(msg, free);
	    list_insert(lp_errstrs, NULL);
	    list_insert(lp_error_msgs, NULL);
	}
	lp_errstrs = lp_errstrs->next;
	lp_error_msgs = lp_error_msgs->next;
    }
    
    if (all_recipients_accepted)
    {
	/* we can use list_free() here since all list entries are just NULL */
	list_free(*errstrs);
	*errstrs = NULL;
	list_free(*error_msgs);
	*error_msgs = NULL;
	return SMTP_EOK;
    }
    else
    {
	return SMTP_EUNAVAIL;
    }
}


/*
 * smtp_etrn()
 *
 * see smtp.h
 */

int smtp_etrn(smtp_server_t *srv, const char *etrn_argument, 
	list_t **error_msg, char **errstr)
{
    int e;
    list_t *msg;
    char buf[256]={};
    time_t clock;
    struct tm *tm;
    time(&clock);
    tm = localtime(&clock) ;
    strftime(buf,sizeof(buf),"%A, %B %d, %Y %X",tm);
    
    *error_msg = NULL;
    if ((e = smtp_send_cmd(srv, errstr, "ETRN %s", etrn_argument)) != SMTP_EOK)
    {
	return e;
    }
    if ((e = smtp_get_msg(srv, &msg, errstr)) != SMTP_EOK)
    {
	return e;
    }
    switch (smtp_msg_status(msg))
    {
	case 250: /* OK, queuing for node <x> started */
	case 251: /* OK, no messages waiting for node <x> */
	case 252: /* OK, pending messages for node <x> started */
	case 253: /* OK, <n> pending messages for node <x> started */
	    break;

	case 458: /* Unable to queue messages for node <x> */
	case 459: /* Node <x> not allowed: <reason> */
	    *error_msg = msg;
	    *errstr = xasprintf(
		    _("the server is unable to fulfill the request"));
		//jimmy modified
	    //save2file(LOG_FILE_HTTP,"[email failed]the server is unable to fulfill the request,%s\n",buf);
		syslog(LOG_ERR,"[email failed]the server is unable to fulfill the request,%s\n",buf);
	    return SMTP_EUNAVAIL;
	    break;
	    
	case 500: /* Syntax Error */
	case 501: /* 501 Syntax Error in Parameters */
	    *error_msg = msg;
	    *errstr = xasprintf(
		    _("invalid argument for Remote Message Queue Starting"));
		//jimmy modified
	    //save2file(LOG_FILE_HTTP,"[email failed]invalid argument for Remote Message Queue Starting,%s\n",buf);
		syslog(LOG_ERR,"[email failed]invalid argument for Remote Message Queue Starting,%s\n",buf);
	    return SMTP_EINVAL;
	    break;
	    
	default:
	    *error_msg = msg;
	    *errstr = xasprintf(_("command %s failed"), "ETRN");
		//jimmy modifed
	    //save2file(LOG_FILE_HTTP,"[email failed]command ETRN failed, %s\n",buf);
		syslog(LOG_ERR,"[email failed]command ETRN failed, %s\n",buf);
	    return SMTP_EPROTO;
	    break;
    }
    list_xfree(msg, free);

    return SMTP_EOK;
}


/*
 * smtp_quit()
 *
 * see smtp.h
 */

int smtp_quit(smtp_server_t *srv, char **errstr)
{
    int e;
    list_t *msg;

    if ((e = smtp_send_cmd(srv, errstr, "QUIT")) == SMTP_EOK)
    {
    	DEBUG_MSG("smtp_quit\n");
		//e = smtp_get_msg(srv, &msg, errstr);
    }
    
//    if (msg)
//    {
//		list_xfree(msg, free);
//    }
    return e;
}


/*
 * smtp_close()
 *
 * see smtp.h
 */

void smtp_close(smtp_server_t *srv)
{
#ifdef HAVE_TLS
    if (tls_is_active(&srv->tls))
    {
	tls_close(&srv->tls);
    }
#endif /* HAVE_TLS */
    net_close_socket(srv->fd);
}
