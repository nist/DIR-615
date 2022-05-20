/*
 * Crowd Control HTTP Proxy, version 0.4 beta
 *
 * Copyright (c) 2005 Tokachu. Portions copyright (c) 2004, 2005 Christopher
 * Devine.
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation; either version 2 of the License, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for 
 * more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
 * Place, Suite 330, Boston, MA 02111-1307 U.S.A.
 */
 
#ifndef WIN32

#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/wait.h>
#include <unistd.h>
#include <netdb.h>
#include <syslog.h>
#include <linux/sockios.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <netinet/in.h>
#define recv(a,b,c,d) read(a,b,c)
#define send(a,b,c,d) write(a,b,c)

#else

#pragma comment(lib, "ws2_32.lib")

#include <winsock2.h>
#include <windows.h>

#endif

#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <ctype.h>
#include <regex.h>
#include <errno.h>
#include <string.h>

#ifndef uint32
#define uint32 unsigned long int
#endif

#define MAXIMUM_FILE_DESCRIPTORS 1024
#define URLBUF_SIZE 4096
#define URLBUF_STRL 4095
#define HOST_SIZE 128

#ifndef TCP_WINDOW_SIZE
#define TCP_WINDOW_SIZE 8192
#endif

#define child_exit(ret)     \
	shutdown(client_fd, 2); \
	shutdown(remote_fd, 2); \
	close(client_fd);       \
	close(remote_fd);       \
	return(ret);

#ifdef __USE_DNS_RESOLVED__
#include "clist.h"
#else
#define add_domain2ip(str) do{}while(0)
#define search_addr(str) (0)
#endif //__USE_DNS_RESOLVED__

//#define __USE_SYSLOG__
#ifdef __USE_SYSLOG__
#define SYSLOG(LOG_INFO, fmt, args...) syslog(LOG_INFO, fmt, ##args)
#else
#define SYSLOG(LOG_INFO, fmt, args...) do {} while(0)
#endif

//#define __USE_FPRINTF__
#ifdef __USE_FPRINTF__
#define FPRINTF(stderr, fmt, args...) fprintf(stderr, fmt, ##args)
#else
#define FPRINTF(stderr, fmt, args...) do {} while(0)
#endif

#define LAN_IFNAME	"br0"
#define DENY_REDIRECT_PAGE	"/reject.html"

/* Constants. */
const int REGFLAGS = REG_NOSUB | REG_EXTENDED | REG_ICASE;
const int PERMITTED = 0, BLOCKED = 1;

/* Structure to hold a linked list of regular expressions. */
struct regex_item
{
	//regex_t reg;
	int isdom;
	char *domain;
	struct regex_item *next;
};

/* Linked list of regular expressions. */
struct regex_item *permitted_urls = NULL, *blocked_urls = NULL;

/* Global identifiers. */
int _GLOBAL_MAX_CONNECTIONS = 16;
int _GLOBAL_IMPLICITACTION  = 0;
char *_GLOBAL_FILEMODE      = "rt";
char *_GLOBAL_ERRPARAM      = "%s: Parameter required for %s.\n";
char *_GLOBAL_ERRNOFILE     = "%s: Cannot open \"%s\".\n";
char *_GLOBAL_ERRNOMEM      = "%s: Out of memory.\n";
char *_GLOBAL_ERRREGEX      = "%s: Error converting \'%s\' to regex.\n";

/* Web-based error messages. */
int _GLOBAL_SIZEOF_BLOCKTEXT = 67 + 18;
char *_GLOBAL_BLOCKTEXT      =
"HTTP/1.0 200 OK\r\n"
"Content-type: text/plain\r\n"
"Content-length: 18\r\n"
"\r\n\r\n"
"<html>Block</html>";

int _GLOBAL_SIZEOF_BLOCKIMG  = 117;
char *_GLOBAL_BLOCKIMG       =
"HTTP/1.0 410 Gone\r\n"
"Content-type: image/gif\r\n"
"Content-length: 49\r\n\r\n"
"GIF89a\x01\x00\x01\x00\xa1\x01\x00\x00\x00\x00\xff\xff\xff\xff\xff\xff\xff"
"\xff\xff\x21\xf9\x04\x01\n\x00\x01\x00\x2c\x00\x00\x00\x00\x01\x00\x01\x00"
"\x00\x02\x02L\x01\x00;\r\n";

enum
{
	PARAM_PORT = 1,
	PARAM_BIND,
	PARAM_SUBNET,
	PARAM_MAXCONNECTIONS,
	PARAM_HTTPONLY,
	PARAM_HTTPWITHSSL,
	PARAM_HTTPTUNNEL,
	PARAM_IMPLICITLYDENY,
	PARAM_IMPLICITLYPERMIT,
	PARAM_PERMITDOMAINS,
	PARAM_PERMITURLS,
	PARAM_PERMITEXPRESSIONS,
	PARAM_DENYDOMAINS,
	PARAM_DENYURLS,
	PARAM_DENYEXPRESSIONS,
	PARAM_TESTURL,
/* 
 Date: 2009-1-05 
 Name: Ken_Chiang
 Reason: modify for the crowdcontrol can open and close used the log.
 Notice :
*/	
	PARAM_USEDLOG,
/* Date: 2009-01-08
 * Name: Fred Hung
 * Reason: let crowdcontrol identify schedule file
 */
	PARAM_SCHEDULE
};

struct thread_data
{
	int client_fd;
	int log_fd;
	uint32 server_ip;
	uint32 auth_ip;
	uint32 netmask;
	uint32 client_ip;
	int connect;
};

/* Date: 2009-01-08
 * Name: Fred Hung
 * Reason: This struct defined for reading schedule info from schedule config file
 */
static struct schedule_struct {
	char key[32];
	char content[64];
};

#define SYS_SCHEDULE	25	/* the number of system schedule rule */
#define URL_SCHEDULE	50	/* the number of urlfilter schedule rule */

static int do_schedule = 0;	/* 0: schedule checking unnecessary */
static struct schedule_struct sys_sch[SYS_SCHEDULE];
static struct schedule_struct url_sch[URL_SCHEDULE];
static int syssch_certain_exists = 0;
static int urlsch_certain_exists = 0;

/* 
 Date: 2009-1-05 
 Name: Ken_Chiang
 Reason: modify for the crowdcontrol can open and close used the log.
 Notice :
*/	
struct logip_item
{
	uint32 logip;
	uint32 isip;
	char mac[18];		
	struct logip_item *next;
};
struct logip_item *log_iplists = NULL;
struct logip_item *loadiplogfile(char *argv0, char *filename, struct logip_item *iplist);
static int mac_flag=0;
#define ARP_FILE "/proc/net/arp"

/* Function declarations. */
char *dgets(FILE *stream);
struct regex_item *loaddomainfile(char *argv0, char *filename,
                                  struct regex_item *urllist);
struct regex_item *loadurlfile(char *argv0, char *filename,
                                   struct regex_item *urllist);
struct regex_item *loadexpressionfile(char *argv0, char *filename,
                                      struct regex_item *urllist);
struct regex_item *add_url(char *url, int isdom, struct regex_item *list);
/* 
 Date: 2009-1-05 
 Name: Ken_Chiang
 Reason: modify for the crowdcontrol can open and close used the log.
 Notice :
*/	
struct logip_item *add_ip(char *ip, struct logip_item *list);
int domainmatches(char *domain, int domain_s, char *filter, int filter_s);
int check_url(char *url, int isdom, struct regex_item *item);
int check_urls(char *url, int isdom);
/* 
 Date: 2009-1-05 
 Name: Ken_Chiang
 Reason: modify for the crowdcontrol can open and close used the log.
 Notice :
*/	
int chk_logip(uint32 currentip, struct logip_item *ip_list, int allow_url, char *current_url);
int isregchar(char c);
int isurlchar(char c);
char x2c(char *what);
char *unescape_url(char *url, int len);
char *url2regex(char *domain);
void deny_access(int client_fd, int c_flag, char *url);
void log_request(uint32 client_ip, char *headers, int headers_len,
				 uint32 auth_ip, uint32 netmask);
int client_thread(struct thread_data *td);

static char *chop(char *io)
{
	char *p;

	p = io + strlen(io) -1;
	while ( *p == '\n' || *p == '\r') {
		*p = '\0';
		p --;
	}
	return io;
}

/* This function used in check_url function for get schedule key.
 * Either url_domain_filter_schedule_X or schedule_ruleX.
 * The function name never changed because we don't change the
 * code behaviors. However, the schedule key contents obtain from
 * schedule config file, not from nvram. The schedule config file
 * used depend on '-S' parameters.
 *
 * Parameters:
 * 	@key := nvram key
 * 	@buf := content, send from caller
 * 	@len := length of @buf
 *
 */
static void nvram_safe_get(const char *key, char *buf, int len)
{
	int i = 0, ret = -1;

	bzero(buf, len);

	if (strncmp(key, "schedule_rule", 13) == 0) {
		for (; i < syssch_certain_exists; i++)
			if (strcmp(key, sys_sch[i].key) == 0) {
				strcpy(buf, sys_sch[i].content);
				goto normal;
			}
	} else {
		for (; i < urlsch_certain_exists; i++)
			if (strcmp(key, url_sch[i].key) == 0) {
				strcpy(buf, url_sch[i].content);
				goto normal;
			}
	}

normal:
	ret = 0;
out:
	return ret;
}

/*
 * char *dgets(FILE *stream, int &n)
 *
 * Reads a line from a file, allocates memory to hold the line, and returns a
 * pointer to the string.
 */
char *dgets(FILE *stream)
{
	register char c;
	int size = 1;
	char *mystr = malloc(size);

	char *tmp;
	tmp = malloc(100);
	bzero(tmp, 100);
	
	if(!fgets(tmp, 99, stream))
		return NULL;
	chop(tmp);	
	return tmp;
	
	/* Go through the stream until we hit the end of the file or line. */
	while (!feof(stream) && (c = fgetc(stream)) & 0xE0)
	{
		if (c == '#' || c == ' ')
		{
			while (!feof(stream) && (fgetc(stream) != '\n'));
			return mystr;
		}
		
		/* Skip funny characters. */
		if (feof(stream) || !(c & 0xE0))
			continue;
		
		if ((mystr = realloc(mystr, ++size)))
		{
			mystr[size - 2] = c;
		}
		else
		{
			free(mystr);
			return NULL;
		}
	}
	
	if (size > 1)
	{
		mystr[size - 1] = '\0';
		return mystr;
	}
	else
	{
		free(mystr);
		return NULL;
	}
	
	free(mystr);
	return NULL;
}

static void
list_item(struct regex_item *p)
{
	while(p){
		SYSLOG(LOG_INFO, "LIST:[%s][%d]", p->domain, p->isdom);
		FPRINTF(stderr, "LIST:[%s][%d]\n", p->domain, p->isdom);
		p = p->next;
	}
	FPRINTF(stderr, "----------------------------------------\n");
}

/* 
 	Date: 2009-1-05 
 	Name: Ken_Chiang
 	Reason: modify for the crowdcontrol can open and close used the log.
 	Notice : for list the all log ip
*/ 	
static void
list_ipitem(struct logip_item *p)
{
	while(p){
		if(p->isip){
			SYSLOG(LOG_INFO, "LIST:logip=%x",p->logip);
			FPRINTF(stderr, "LIST:logip=%x\n", p->logip);
		}	
		else{
			SYSLOG(LOG_INFO, "LIST:logmac=%s",p->mac);
			FPRINTF(stderr, "LIST:logmac=%s\n", p->mac);
		}		
		p = p->next;
	}	
	FPRINTF(stderr, "----------------------------------------\n");
}

/*
 * struct regex_item *loaddomainfile(char *argv0, char *filename,
 *                                   struct regex_item *urllist)
 *
 * Loads a list of domains from file "filename" into list "urllist". Returns a
 * pointer to the list upon success, NULL if it failed.
 */
struct regex_item *loaddomainfile(char *argv0, char *filename,
                                  struct regex_item *urllist)
{
	FILE *in;
	char *fileline = NULL;
	
	/* Process a list of domains. */
	if (filename)
	{
		SYSLOG(LOG_INFO,"filename=%s",filename);
		if (!(in = fopen(filename, _GLOBAL_FILEMODE)))
		{
			SYSLOG(LOG_INFO, _GLOBAL_ERRNOFILE, argv0, urllist);
			exit(1);
		}
		
		while (!feof(in))
		{
			SYSLOG(LOG_INFO, "Loop:\n");
			list_item(urllist);
			if (!(fileline = dgets(in))) {
				SYSLOG(LOG_INFO, "break\n");
				continue;
			}
			list_item(urllist);
			SYSLOG(LOG_INFO, "load:[%s]\n", fileline);
			if (!(urllist = add_url(fileline, strlen(fileline), urllist)))
			{
				SYSLOG(LOG_INFO, _GLOBAL_ERRNOMEM, argv0);
				free(fileline);
				exit(1);
			}
		}
		
		free(fileline);
		fclose(in);
	}
	
	return urllist;
}

/*
 * struct regex_item *loadurlfile(char *argv0, char *filename,
 *                                struct regex_item *urllist)
 *
 * Loads a list of URLs from file "filename" into list "urllist". Returns a
 * pointer to the list upon success, NULL if it failed.
 */
struct regex_item *loadurlfile(char *argv0, char *filename,
                               struct regex_item *urllist)
{
	FILE *in;
	char *fileline = NULL;
	
	if (filename)
	{
		SYSLOG(LOG_INFO, "filename=%s",filename);
		if (!(in = fopen(filename, _GLOBAL_FILEMODE)))
		{
			SYSLOG(LOG_INFO, _GLOBAL_ERRNOFILE, argv0, urllist);
			exit(1);
		}
		
		while (!feof(in))
		{
			if (!(fileline = dgets(in)))
				continue;
			/*
			if (!(fileline = url2regex(fileline)))
			{
				SYSLOG(LOG_INFO, _GLOBAL_ERRNOMEM, argv0);
				free(fileline);
				return NULL;
			}
			*/
			if (!(urllist = add_url(fileline, 0, urllist)))
			{
				SYSLOG(LOG_INFO, _GLOBAL_ERRNOMEM, argv0, fileline);
				free(fileline);
				exit(1);
			}
		}
		
		free(fileline);
		fclose(in);
	}
	
	return urllist;
}

/*
 * struct regex_item *loadexpressionfile(char *argv0, char *filename,
 *                                       struct regex_item *urllist)
 *
 * Loads a list of regular expressions from file "filename" into list
 * "urllist". Returns a pointer to the list upon success, NULL if it failed.
 */
struct regex_item *loadexpressionfile(char *argv0, char *filename,
                                      struct regex_item *urllist)
{
	FILE *in;
	char *fileline = NULL;
	
	if (filename)
	{
		SYSLOG(LOG_INFO, "filename=%s",filename);
		if (!(in = fopen(filename, _GLOBAL_FILEMODE)))
		{
			SYSLOG(LOG_INFO, _GLOBAL_ERRNOFILE, argv0, filename);
			exit(1);
		}
		
		while (!feof(in))
		{
			if (!(fileline = dgets(in)))
				continue;
			
			if (!(urllist = add_url(fileline, 0, urllist)))
			{
				SYSLOG(LOG_INFO, _GLOBAL_ERRREGEX, argv0, fileline);
				free(fileline);
				exit(1);
			}
		}
		
		free(fileline);
		fclose(in);
	}
	
	return urllist;
}

/* 
 	Date: 2009-1-05 
 	Name: Ken_Chiang
 	Reason: modify for the crowdcontrol can open and close used the log.
 	Notice :
 	
 * struct logip_item *loadiplogfile(char *argv0, char *filename, *struct logip_item *iplist)
 *
 * Loads a list of log ip from file "filename" into list "iplist". Returns a
 * pointer to the list upon success, NULL if it failed.
 */
struct logip_item *loadiplogfile(char *argv0, char *filename,
                               struct logip_item *iplist)
{
	FILE *in;
	char *fileline = NULL;
	
	if (filename)
	{
		SYSLOG(LOG_INFO, "filename=%s",filename);
		if (!(in = fopen(filename, _GLOBAL_FILEMODE)))
		{
			SYSLOG(LOG_INFO, _GLOBAL_ERRNOFILE, argv0, iplist);
			exit(1);
		}
		list_ipitem(iplist);
		while (!feof(in))
		{			
			if (!(fileline = dgets(in)))
				continue;
			
			if (!(iplist = add_ip(fileline, iplist)))
			{
				SYSLOG(LOG_INFO, _GLOBAL_ERRNOMEM, argv0, fileline);
				free(fileline);
				exit(1);
			}
		}
		
		free(fileline);
		fclose(in);
	}	
	list_ipitem(iplist);
	return iplist;
}

/*
 * struct regex_item *add_url(char *url, int isdom, struct regex_item *list)
 *
 * Add a regular expression to the linked list. It returns a pointer to the
 * beginning of the linked list if the addition succeeds, or NULL otherwise.
 */
struct regex_item *add_url(char *url, int isdom, struct regex_item *list)
{	
	if (!list)
	{
		SYSLOG(LOG_INFO, "%s: If the list is empty",__func__);
		/* If the list is empty, create the first item in the linked list. */
		if ((list = malloc(sizeof(*list))))
		{
			if (isdom)
			{
				SYSLOG(LOG_INFO, "isdome\n");
				list->isdom = strlen(url);
				
				/* If the memory cannot be allocated, bail out. */
				if (!(list->domain = malloc(list->isdom + 1))){
					SYSLOG(LOG_INFO, "list->domain malloc fail\n");
					return NULL;
				}	
				bzero(list->domain, list->isdom + 1);
				strncpy(list->domain, url, list->isdom + 1);
			}
			else
			{
				SYSLOG(LOG_INFO, "not isdome\n");
				/* If the regex can't be compiled, bail out. */
				//if (regcomp(&list->reg, url, REGFLAGS))
				//	return NULL;
				if (!(list->domain = strdup(url))){
					SYSLOG(LOG_INFO, "list->domain strdup fail");
					return NULL;
				}	
				list->isdom = 0;
				//list->domain = NULL;
			}
			
			list->next = NULL;
			SYSLOG(LOG_INFO, "New domain:[%s]\n", list->domain);
			return list;
		}
		else{
			SYSLOG(LOG_INFO, "list malloc fail\n");
			return NULL;
		}	
	}
	else
	{
		/* If the list has items, add another item to the linked list. */
		struct regex_item *current;
		current = list;
		SYSLOG(LOG_INFO, "%s: If the list isn't empty",__func__);
		/* Seek to the end of the list. */
		while (current->next) {
			current = current->next;
		}
		/* Create a new item. */
		if ((current->next = malloc(sizeof(*current))))
		{
			SYSLOG(LOG_INFO, "Create a new item");
			current = current->next;
			if (isdom)
			{
				SYSLOG(LOG_INFO, "isdom");
				current->isdom = strlen(url);
				/* If the memory cannot be allocated, bail out. */
				if (!(current->domain = malloc(list->isdom + 10))){
					SYSLOG(LOG_INFO, "list->domain malloc fail");
					return NULL;
				}	
				bzero(current->domain, list->isdom + 10);
				SYSLOG(LOG_INFO, "added url:[%s]", url);				
				strncpy(current->domain, url, current->isdom + 1);
			}
			else
			{
				SYSLOG(LOG_INFO, "not isdome\n");
				/* If the regex can't be compiled, bail out. */
				//if (regcomp(&current->reg, url, REGFLAGS))
				//	return NULL;
				if (!(current->domain = strdup(url))){
					SYSLOG(LOG_INFO, "current->domain strdup fail");
					return NULL;
				}	
				current->isdom = 0;
			}
			current->next = NULL;
			SYSLOG(LOG_INFO, "current domain:[%s]\n", current->domain);
			return list;
		}
		else{
			SYSLOG(LOG_INFO, "Create a new item fail");
			return NULL;
		}	
	}
	
	/* As a default measure, return NULL. */
	return NULL;
}

/* 
 	Date: 2009-1-05 
 	Name: Ken_Chiang
 	Reason: modify for the crowdcontrol can open and close used the log.
 	Notice :
 	
 * struct logip_item *add_ip(char *ip, struct logip_item *list)
 *
 * Add a log ip to the linked list. It returns a pointer to the
 * beginning of the linked list if the addition succeeds, or NULL otherwise.
 */
struct logip_item *add_ip(char *ip, struct logip_item *list)
{	
	struct in_addr myip;
	if (!list)
	{
		SYSLOG(LOG_INFO, "%s: If the list is empty",__func__);
		/* If the list is empty, create the first item in the linked list. */
		if ((list = malloc(sizeof(*list))))
		{
			if(strchr(ip,':')){
				strcpy(list->mac,ip);
				list->isip = 0;
				mac_flag++;
				SYSLOG(LOG_INFO, "first log_mac:%s[%s]",ip , list->mac);
			}	
			else{
				inet_aton(ip,&myip);	
				list->logip = myip.s_addr;
				list->isip = 1;				
				SYSLOG(LOG_INFO, "first log_ip:%s[%x]",ip , list->logip);	
			}	
			list->next = NULL;	
			return list;
		}
		else{
			SYSLOG(LOG_INFO, "%s: list malloc fail",__func__);
			return NULL;
		}	
	}
	else
	{
		/* If the list has items, add another item to the linked list. */
		struct logip_item *current;
		current = list;
		SYSLOG(LOG_INFO, "%s: If the list isn't empty",__func__);
		/* Seek to the end of the list. */
		while (current->next) {
			current = current->next;
		}
		/* Create a new item. */
		if ((current->next = malloc(sizeof(*current))))
		{
			SYSLOG(LOG_INFO, "Create a new item");
			current = current->next;
			if(strchr(ip,':')){
				strcpy(current->mac,ip);
				current->isip = 0;
				mac_flag++;
				SYSLOG(LOG_INFO, "new log_mac:%s[%s]",ip , current->mac);
			}	
			else{
				inet_aton(ip,&myip);	
				current->logip = myip.s_addr;
				current->isip = 1;				
				SYSLOG(LOG_INFO, "new log_ip:%s[%x]",ip , current->logip);	
			}						
			current->next = NULL;							
			return list;
		}
		else{
			SYSLOG(LOG_INFO, "%s: Create a new item fail",__func__);
			return NULL;
		}	
	}
	
	/* As a default measure, return NULL. */
	return NULL;
}

#ifndef __USE_PTHREAD__

#define ADD_DOMAIN2IP(args)  add_domain2ip(args)
#define search_addr_r(str) search_addr(str)

#else
/* POSIX thread  support and wrapper */
#include <pthread.h>
pthread_mutex_t plock;
int count_thread = 0;
#define ADD_DOMAIN2IP(args) { 		\
	pthread_mutex_lock(&plock);	\
	add_domain2ip(args);		\
	pthread_mutex_unlock(&plock);	\
}

int 
search_addr_r(const char *str) {
	int rev;

	pthread_mutex_lock(&plock);
	rev = search_addr(str);
	pthread_mutex_unlock(&plock);
	return rev;
}

static void *
__client_pthread(void *args)
{
	struct thread_data td;
	int rev;
	
	pthread_mutex_lock(&plock);
	count_thread++;
	pthread_mutex_unlock(&plock);
	
	if ((rev = pthread_detach(pthread_self())) != 0) {
		switch (rev) {
		case EINVAL:
			SYSLOG(LOG_INFO, "pthread_detach(%lu)->EINVAL:%d", pthread_self(), rev);			
			break;
		case ESRCH:
			SYSLOG(LOG_INFO, "pthread_detach(%lu)->ESRCH:%d", pthread_self(), rev);			
			break;
		default:
			SYSLOG(LOG_INFO, "pthread_detach(%lu)->UNKNOW:%d", pthread_self(), rev);			
			break;
		}
		return NULL;
	}
	SYSLOG(LOG_INFO, "self:%lu", pthread_self());	
	memcpy(&td, args, sizeof(struct thread_data));
	rev = client_thread(&td);
	
	SYSLOG(LOG_INFO, "%lu ->client_thread:%d", pthread_self(), rev);	
	
	pthread_mutex_lock(&plock);
	shutdown(td.client_fd, 2);
	close(td.client_fd);
	count_thread--;
	pthread_mutex_unlock(&plock);
	
	return NULL;
}

/*  
 *  Return:
 *  0: Error; otherwise, pthread_t is returned.
 */
static inline int
use_pthread(struct thread_data *td)
{
		pthread_t id_thrd;
		int perr;
		if ((perr = pthread_create(&id_thrd, NULL, __client_pthread, td)) != 0) {
			switch (perr){
				case EAGAIN:
				SYSLOG(LOG_INFO, "pthread_create():EAGAIN,%d:threads limited %d",
						perr, count_thread);			
					break;
				case EINVAL:
				SYSLOG(LOG_INFO, "pthread_create():FINVAL,%d", perr);			
					break;
				case EPERM:
				SYSLOG(LOG_INFO, "pthread_create():EPERM,%d", perr);			
					break;
				default:
				SYSLOG(LOG_INFO, "pthread_create():UNKNOW,%d", perr);			
					break;
			};
			return 0;
		}
		SYSLOG(LOG_INFO, "pthread(%lu) returned,continue to accept()",id_thrd);	
		return id_thrd;
}

#endif //__USE_PTHREAD__


/*
 * check URL match
 * Checks to see if the string "url" is finded in "filter".
 * return 1 is finded
 */
int chk_special(char *url,int url_s, char *filter, int filter_s){
	SYSLOG(LOG_INFO, "s: d[%s][%d]f[%s][%d]",__func__, url, url_s, filter, filter_s);
	/*
	char *p;
	if (!(p = strchr(url, '/')))	//check "www.foo.com/index.html"
		return 0;
	if (strlen(p) <= 1)
		return 0;	//return if format "www.foo.com/" ...
	*/
	if (url_s < filter_s){
		SYSLOG(LOG_INFO, "url_s < filter_s");
		return 0;
	}	
	if (strstr(url_s, filter))
		return 1;
	
	return 0;
}

/* 
 	Date: 2009-1-05 
 	Name: Ken_Chiang
 	Input : char mac_addr 
 	Output: char ip_addr, return 1 is find ip addr and return 0 no find ip addr
 	Description: input mac addr to find ip addr in arp file.
 	Sample :
*/ 	
int macaddrs_to_ipaddrs(char *macaddr, char *ipaddr)
{
	FILE *fp1;
	int i;
	char tmp[100],ip[16];	
	/* open arp file */
	fp1 = fopen(ARP_FILE, "rt");
	if (fp1 == NULL) 
	{
		SYSLOG(LOG_INFO, "open %s fail",ARP_FILE);
		return 0;					
	}
			
	for(i=0; i<strlen(macaddr); i++){
		*(macaddr+i)= toupper(*(macaddr+i));
	}	
	SYSLOG(LOG_INFO, "macaddr up=%s",macaddr);
		
	while (!feof(fp1)){
		bzero(tmp, 100);	
		if(!fgets(tmp, 99, fp1)){
			SYSLOG(LOG_INFO,"fgets fail");
			continue;
		}	
		SYSLOG(LOG_INFO,"tmp %s", tmp);
		if(strstr(tmp,macaddr)){			
			strncpy(ip,tmp,15);
			ip[15]='\0';
			strcpy(ipaddr,ip);
			SYSLOG(LOG_INFO,"ipaddr %s", ipaddr);
			return 1;			
		}	
	}					
	
	return 0;
}	

/* 
 	Date: 2009-1-05 
 	Name: Ken_Chiang
 	Reason: modify for the crowdcontrol can open and close used the log.
 	Notice :
 * check ip addreses match
 * Checks to see if the ip is finded in "ip_list".
 * return 1 is finded
 */ 
int chk_logip(uint32 currentip, struct logip_item* ip_list, int allow_url, char *current_url)
{		
	char ipaddr[16];
	struct in_addr myip;
	SYSLOG(LOG_INFO, "mac_flag=%d", mac_flag);
	while(ip_list){		
		if(mac_flag)//had mac addr
		{			
			if(ip_list->isip){//ip addr
				SYSLOG(LOG_INFO, "ip addr=%x",ip_list->logip);
				if( currentip == ip_list->logip){
					SYSLOG(LOG_INFO, "find logip=%x",currentip);			
					myip.s_addr = currentip;
					if(allow_url)
						syslog(LOG_INFO, "%s accessed from %s (%s)\n", current_url, inet_ntoa(myip), ip_list->mac);
					else
						syslog(LOG_INFO, "%s blocked for %s (%s)", current_url, inet_ntoa(myip), ip_list->mac);
								
					return 1;
				}
			}
			else{//mac addr
				SYSLOG(LOG_INFO, "mac addr=%s",ip_list->mac);
				if(macaddrs_to_ipaddrs(ip_list->mac,ipaddr)){
					inet_aton(ipaddr,&myip);
					SYSLOG(LOG_INFO, "find logmacip=%s[%x]",ipaddr,myip);	
					if( currentip == myip.s_addr){
						SYSLOG(LOG_INFO, "find logip=%x",currentip);			
						if(allow_url)
							syslog(LOG_INFO, "%s accessed from %s (%s)\n", current_url, ipaddr, ip_list->mac);
						else
							syslog(LOG_INFO, "%s blocked for %s (%s)", current_url, ipaddr, ip_list->mac);
									
						return 1;
					}
				}	
			}			
		}
		else{//just had ip addr
			if( currentip == ip_list->logip){
				SYSLOG(LOG_INFO, "find logip=%x",currentip);			
				myip.s_addr = currentip;
				if(allow_url)
					syslog(LOG_INFO, "%s accessed from %s\n", current_url, inet_ntoa(myip));	
				else
					syslog(LOG_INFO, "%s blocked for %s", current_url, inet_ntoa(myip));
							
				return 1;
			}	
		}		
		ip_list = ip_list->next;
	}	
	SYSLOG(LOG_INFO, "no find logip=%x",currentip);
	return 0;
}

/*
 * int domainmatches(char *domain, int domain_s, char *filter, int filter_s)
 *
 * Checks to see if the string "domain" is the same as "filter".
 * return 1 is matched
 */
int domainmatches(char *domain, int domain_s, char *filter, int filter_s)
{
	int rev = 0;
		
	SYSLOG(LOG_INFO, "%s: d[%s][%d]f[%s][%d]",__func__, domain, domain_s, filter, filter_s);	
	if (domain_s < filter_s){
		SYSLOG(LOG_INFO, "domain_s < filter_s");
		return 0;
	}	

	//Follow cameo's SPEC
	if (strstr(domain, filter)) {
		ADD_DOMAIN2IP(domain);
		SYSLOG(LOG_INFO, "domain[%s] is match filter[%s]\n",domain, filter);
		return 1;
	}
	/*
	 * Matched if format of @domain as "www.foo.com" and @filter as "www.foo." 
	 * or the sam length of both
	 */
	if (domain_s == filter_s || filter[filter_s - 1] == '.'){
		rev = strncmp(domain, filter, domain_s);
		
		if (rev == 0)
			ADD_DOMAIN2IP(domain);
		SYSLOG(LOG_INFO, "domain[%s] is match filter[%s]\n",domain, filter);	
		return !rev;
	}

	/*
	 * Matched  if format of @domain as "www.foo.com" and @filter as "foo.com"
	 */
	domain_s -= filter_s;
	
	if (domain[domain_s - 1] == '.')
	{
		if (!(rev = strncmp((char *)(domain + domain_s), filter, filter_s))) {
			ADD_DOMAIN2IP(domain);
			SYSLOG(LOG_INFO, "domain[%s] is match filter[%s]\n",domain, filter);
			return 1;
		}
	}
	if (search_addr_r(domain) ==1)
		return 1;
	return 0;
}

/*
 * int check_url(char *url, int isdom, struct regex_item *item)
 *
 * Go through a single list of regular expressions to find a match for "url".
 * Returns 1 (true) if a match was found, 0 (false) otherwise.
 */
int check_url(char *url, int isdom, struct regex_item *item)
{
	int i = 0, ttime;
	time_t t;
	struct tm *tm;
	char key[32], value[32], *name, *week, *s_min, *e_min;
	struct regex_item *current = item;
	/* If the list is empty, just return 0. */
	SYSLOG(LOG_INFO, "%s:url=%s,isdom=%d",__func__,url,isdom);
	if (!item){
		SYSLOG(LOG_INFO, "item null");
		return 0;
	}	
	while (current) {

		/* Date: 2009-01-08
		 * Name: Fred Hung
		 * Reason: if crowdcontrol has '-S' schedule request,
		 *         do_schedule be 1, otherwise be 0.
		 */
		if (do_schedule) {

			sprintf(key, "url_domain_filter_schedule_%d", i);
			i++;
			nvram_safe_get(key, value, sizeof(value));
			if (strlen(value) == 0) {
				continue;
			} else if (strcmp(value, "Always") != 0) {
				sprintf(key, "schedule_rule%d", atoi(value));
				value[0] = '\0';
				nvram_safe_get(key, value, sizeof(value));
				if (strlen(value) == 0) {
					perror("schedule_rule hvae no value");
					exit(1);
				}
				name = strtok(value, "/");
				week = strtok(NULL, "/");
				s_min = strtok(NULL, "/");
				e_min = strtok(NULL, "/");
				time(&t);
				tm = localtime(&t);
				ttime = (tm->tm_hour * 60) + tm->tm_min;
				if (week[tm->tm_wday] == '1') {
					SYSLOG(LOG_INFO, "today is in shedule\n"); 
					if (ttime < atoi(s_min) || ttime > (atoi(e_min) - 1)) {
						SYSLOG(LOG_INFO, "Not shedule\n"); 
						current = current->next;
						continue;
					}
					SYSLOG(LOG_INFO, "IN shedule\n"); 
				} else {
					SYSLOG(LOG_INFO, "today is NOT in shedule\n"); 
					current = current->next;
					continue;
				}
			}
		}

		/* If we reach the end of the domain list with matches, return 1. */
		if (isdom)
		{
			SYSLOG(LOG_INFO, "isdom\n");
			if (!(current->isdom)){
				current = current->next;
				continue;
			}
			SYSLOG(LOG_INFO, "check current domain[%s][%d]\n",current->domain, current->isdom);
			if (domainmatches(url, strlen(url), current->domain, current->isdom)){
				SYSLOG(LOG_INFO, "match current domain[%s][%d]\n", current->domain, current->isdom);	
				return 1;
			}	
		} else {			
			SYSLOG(LOG_INFO, "not isdom");			       	
			if (current->isdom) {
				current = current->next;
				continue;
			}
			SYSLOG(LOG_INFO, "chk current url[%s][%d]\n", current->domain, current->isdom);	
			if (chk_special(url, strlen(url), current->domain,
					       	strlen(current->domain))){
				SYSLOG(LOG_INFO, "match current url[%s][%d]\n", current->domain, current->isdom);	
				return 1;
			}	
			/* If we find a match, return 1. */
		//	if (!regexec(&current->reg, url, 0, NULL, 0))
		//		return 1;
		}
		/* Seek to the next element. */
		current = current->next;
	}
	
	/* If no match is found, return 2. */
	return 2;
}

/*
 * int check_urls(char *url, int isdom)
 *
 * Checks to see if a URL should be permitted or blocked. Returns 1 (true) if
 * the URL should be permitted, or 0 (false) if it should be blocked.
 */
int check_urls(char *url, int isdom)
{
	int match;

	SYSLOG(LOG_INFO, "%s:url=%s,isdom=%d",__func__,url,isdom);
	if (match = check_url(url, isdom, permitted_urls))
	{
		SYSLOG(LOG_INFO, "permitted match = %d", match);		
		if(match == 2){
			SYSLOG(LOG_INFO, "permitted no find match\n");
			return 0;
		}
		SYSLOG(LOG_INFO, "permitted");		
		return 1;
	}
	else
	{
		SYSLOG(LOG_INFO, "No match permitted_urls\n");
		if ((_GLOBAL_IMPLICITACTION == BLOCKED) && isdom) {
			SYSLOG(LOG_INFO, "Implicitation domain block[%s]", url);			
			return 0;
		}
		if (match = check_url(url, isdom, blocked_urls)) {
			SYSLOG(LOG_INFO, "blocked match = %d", match);			
			if(match == 2){
				SYSLOG(LOG_INFO, "blocked no find match\n");
				return 1;
			}				
			SYSLOG(LOG_INFO, "blocked");			
			return 0;
		}
		SYSLOG(LOG_INFO, "others");		
	}	
	return 1;
}

/*
 * int isregchar(char c)
 *
 * Checks to see if a character should be preceeded with a blackslash for a
 * regular expression. Returns 1 (true) if it should, 0 (false) otherwise.
 */
int isregchar(char c)
{
	return (c == '.' || c == '?' || c == '+' || c == '[' || c == ']' ||
			c == '\\'|| c == '{' || c == '}' || c == '*' || c == '(' ||
			c == ')' || c == '$' || c == '^' || c == '|');
}

/*
 * int isurlchar(char c)
 *
 * Checks to see if a character (in a URL) should NOT be percent-encoded.
 * Returns 0 (false) if the character should be percent-encoded, 1 (true)
 * otherwise.
 */
int isurlchar(char c)
{
	return (isalnum(c) || c == '-' || c == '_' || c == '.' || c == '~');
}

/*
 * char x2c(char *what)
 *
 * Decode a percent-encoded character (routine from the original NCSA server).
 */
char x2c(char *what)
{
	register char c;
	
	c = (what[0] >= 'A' ? ((what[0] & 0xDF) - 'A') + 10 : (what[0] - '0'));
	c *= 16;
	c +=(what[1] >= 'A' ? ((what[1] & 0xDF) - 'A') + 10 : (what[1] - '0'));
	
	return isurlchar(c) ? c : 0;
}

/*
 * char *unescape_url(char *url, int len)
 *
 * Unescape a URL (routine from the original NCSA server).
 */
char *unescape_url(char *url, int len)
{
	int x, y;
	char c, *newurl = malloc(len + 1);
	
	for (x = 0, y = 0; url[x] && x < len; ++x, ++y)
	{
		if ((newurl[x] = url[y]) == '%')
		{
			if ((c = x2c(&url[y + 1])))
			{
				newurl[x] = c;
				y += 2;
			}
		}
	}
	
	newurl[x] = '\0';
	return newurl;
}

/*
 * char *url2regex(char *domain)
 *
 * Converts a URL segment to a valid regular expression string.
 */
char *url2regex(char *domain)
{
	int i, domsize = 20, chars = 19;
	char *regex;
	
	for (i = 0; domain[i]; i++)
	{
		if (isregchar(domain[i]))
			domsize++;
		domsize++;
	}
	
	if (!(regex = malloc(domsize)))
		return NULL;
	
	strncpy(regex, "^([a-z0-9\\._-]+\\.)?", domsize);
	
	for (i = 0; domain[i] && chars < domsize; i++)
	{
		if (isregchar(domain[i]))
			regex[chars++] = '\\';
		regex[chars++] = domain[i];
	}
	
	regex[chars] = '\0';
	return regex;
}

static char *
get_lan_ip(char *buf, int len)
{
	int s, r;
	struct ifreq ifr;
	struct sockaddr_in in;
	
	s = socket(AF_INET, SOCK_DGRAM, 0);
	memset(&ifr,0, sizeof(struct ifreq));
	strcpy(ifr.ifr_name, LAN_IFNAME);
	r = ioctl(s, SIOCGIFADDR,&ifr);
	if (r < 0){
		SYSLOG(LOG_INFO, "ioctl fail");
		return NULL;
	}
	memcpy(&in, &ifr.ifr_addr, sizeof(struct sockaddr_in));
	strncpy(buf, inet_ntoa(in.sin_addr), len);
	return buf;
}

static char *
redirect(char *buf, int len){
	char ip[16];

	if (get_lan_ip(ip, sizeof(ip)) == NULL){
		SYSLOG(LOG_INFO, "get_lan_ip fail");
		return NULL;
	}	
	snprintf(buf, len,
	"HTTP/1.1 302 found\r\n"
	"Location: http://%s%s\r\n"
	"Content-Length: 0\r\n"
	"Connection: close\r\n\r\n", 
	ip, DENY_REDIRECT_PAGE);	
	return buf;
}

/*
 * void deny_access(struct thread_data *td, int c_flag)
 *
 * Returns a "410 Gone" error with an appropriate file (for HTTP requests), or
 * just closes the connection (for HTTPS/tunnel connections).
 */
 
void deny_access(int client_fd, int c_flag, char *url)
{
	if (!c_flag)
	{
		SYSLOG(LOG_INFO, "%s: !c_flag\n",__func__);
		/* Quick and dirty way to find the file extension. */
		int i = 0, loc = 0;
		
		while (url[i++])
		{
			if (url[i] == '.')
			{
				loc = i + 1;
			}
			
			if (url[i] == '?')
				break;
		}
		
		char *ext = malloc(4);
		strncpy(ext, (char *)(url + loc), 3);
		ext[3] = '\0';
		
		if (!strcasecmp(ext, "gif") || !strcasecmp(ext, "jpg") ||
			!strcasecmp(ext, "png") || !strcasecmp(ext, "jpe"))
		{
			SYSLOG(LOG_INFO, "blocked[%s] is picture",url);
			SYSLOG(LOG_INFO, "No redirect[%s]\n",_GLOBAL_BLOCKIMG);
			send(client_fd, _GLOBAL_BLOCKIMG, _GLOBAL_SIZEOF_BLOCKIMG, 0);
		}
		else
		{
			char *buf;
			SYSLOG(LOG_INFO, "blocked[%s] isn't picture",url);		
			buf = malloc(1024);
			if(!buf){
				SYSLOG(LOG_INFO, "buf malloc fail\n");
				return ;
			}	
			bzero(buf, 1024);
			
			if (redirect(buf, 1024)) {
				SYSLOG(LOG_INFO, "Redirect[%s]", buf);					
				send(client_fd, buf, strlen(buf), 0);
			} else {
				SYSLOG(LOG_INFO, "No redirect[%s]",_GLOBAL_BLOCKTEXT);
				send(client_fd, _GLOBAL_BLOCKTEXT,	_GLOBAL_SIZEOF_BLOCKTEXT, 0);
			}
			free(buf);
		}
	}
}

/*
 * void log_request(uint32 client_ip, char *headers, int headers_len,
 *                  uint32 auth_ip, uint32 netmask)
 *
 * Logs a request.
 * TODO: Change this to make an SNMP broadcast.
 */
void log_request(uint32 client_ip, char *headers, int headers_len,
				 uint32 auth_ip, uint32 netmask)
{
	int i;
	time_t t;
	struct tm *lt;
	char hyphen[2] = "-";
	char *buffer;
	char strbuf[16];
	char *ref, *u_a;
	
	buffer = malloc(headers_len + 1);
	memcpy(buffer, headers, headers_len + 1);
	
	/* Find the Referer: and User-Agent: headers. */
	strncpy(strbuf, "Referer: ", sizeof(strbuf));
	ref = strstr(buffer, strbuf);
	ref = ((ref) ? ref + 9 : hyphen);
	
	strncpy(strbuf, "User-Agent: ", sizeof(strbuf));
	u_a = strstr(buffer, strbuf);
	u_a = ((u_a) ? u_a + 12 : hyphen);
	
	/* Replace special characters with a space. */
	for (i = 0; i < headers_len; i++)
	{
		if (buffer[i] < ' ' || buffer[i] > '~')
		{
			if (buffer[i] == '\r' && buffer[i + 1] == '\n')
				buffer[i] = '\0';
			else
				buffer[i] = ' ';
		}
	}
	
	/* Put the information together and send it out. */
	t = time(NULL);
	lt = localtime(&t);
	lt->tm_year += 1900;
	lt->tm_mon++;
	
	int quads[4] = {
		(int)(client_ip)       & 0xFF,
		(int)(client_ip >>  8) & 0xFF,
		(int)(client_ip >> 16) & 0xFF,
		(int)(client_ip >> 24) & 0xFF
	};
	
	free(buffer);
	
	char *logstr = malloc(headers_len + 1);
	sprintf(logstr, "[%04d-%02d-%02d %02d:%02d:%02d] "
			"%d.%d.%d.%d \"%s\" \"%s\" \"%s\"", lt->tm_year,
			lt->tm_mon, lt->tm_mday, lt->tm_hour, lt->tm_min, lt->tm_sec,
		    quads[0], quads[1], quads[2], quads[3], buffer, ref, u_a);
	
	/* Insert SNMP-sending thing here. */
	auth_ip |= (~netmask);
}

#ifdef WIN32
HANDLE tdSem;
#define close(fd) closesocket(fd)
#endif

#define SKIP_SPACE(p) while (isspace(*(p)) && *(p) != '\0'){(p)++;}
#define JUMP_SPACE(p) while (!isspace(*(p)) && *(p) != '\0'){(p)++;}
/*
 * Get HTTP head's context
 * @header - Header string, such as "Host", case insensitive.
 * @s - Point to buffer of HTTP where MUST start with string @header
 *	such as "Host: foo.com\r\nOtherHead: ...."
 * Return:
 *	Return a string buffer. Caller should free() the buffer.
 *	Return NULL on error.
 */
static char *
header_from_line(const char *header, char *s)
{
	char *p, *e, *new = NULL;
	
	if (strncasecmp(s, header, strlen(header)))
		return NULL;
	
	p = s + strlen(header);
	SKIP_SPACE(p);
	if (*p != ':')		//header should be "Host:" 
		return NULL;
	
	p++;
	SKIP_SPACE(p);
	
	if (!(e = strchr(p, '\n'))) //header shoule end with a newline '\n'
		return NULL;
	new = strndup(p, (e - p));
	chop(new);
	return new;
	
}

static char *
fakeheader(char *buffer, int len)
{
	char *ptmp;
	
	ptmp = strstr(buffer, "\nHost:");

	if (ptmp) {
		char *h_host, *p, *stmp = NULL;
		char cmd[20];
		
		ptmp++;
		
		//get header "www.foo.com" from 'Host' header such as "Host: www.foo.com"
		h_host = header_from_line("Host", ptmp);
		if (!h_host){
			SYSLOG(LOG_INFO, "header_from_line fail");
			return NULL;
		}	
		stmp = strdup(buffer);
		p = stmp;
		JUMP_SPACE(p);	//jump "GET" commmand
		bzero(cmd,sizeof(cmd));
		strncpy(cmd, stmp, p - stmp); //store command, "GET", "POST" ...
		SKIP_SPACE(p);	//skip space to "/url/..."
		
		
		if (*p != '/') {
			SYSLOG(LOG_INFO, "Err HTTP Cmd: GET: [%s]", buffer);			
			free(h_host);
			free(stmp);
			return NULL;
			//child_exit(15);
		}
		
		SYSLOG(LOG_INFO, "Old:[%s]", buffer);		
		sprintf(buffer, "%s http://%s%s", cmd, h_host, p);
		SYSLOG(LOG_INFO, "New:[%s]", buffer);		
		free(h_host);
		free(stmp);
	} else {
		SYSLOG(LOG_INFO, "Err HTTP header: Host: [%s]", buffer);		
		return NULL;
		//child_exit(15);
	}
	return buffer;
}


int client_thread(struct thread_data *td)
{
	int remote_fd = -1, remote_port, state, c_flag, n, client_fd, loc;
	uint32 client_ip;
	
	char *str_end, *current_url, c;
	char *url_host, buffer[URLBUF_SIZE], *url_port, last_host[HOST_SIZE];
	
	struct sockaddr_in remote_addr;
	struct hostent *remote_host;
	struct timeval timeout;
	struct in_addr addr;
	
	fd_set rfds;	
	
	client_fd = td->client_fd;
	client_ip = td->client_ip;
	
#ifdef WIN32
	/* Let the master thread continue. */
	ReleaseSemaphore(tdSem, 1, NULL);
#endif
	
	/* Fetch the HTTP request headers. */
	FD_ZERO(&rfds);
	FD_SET((unsigned int)client_fd, &rfds);
	
	timeout.tv_sec = 10;
	timeout.tv_usec = 0;
	SYSLOG(LOG_INFO, "%s start",__func__);
	if (select(client_fd + 1, &rfds, NULL, NULL, &timeout) <= 0)
	{
		SYSLOG(LOG_INFO, "select fail");
		child_exit(11);
	}
	
	if ((n = recv(client_fd, buffer, URLBUF_STRL, 0)) <= 0)
	{
		SYSLOG(LOG_INFO, "recv fail");
		child_exit(12);
	}
	memset(last_host, 0, sizeof(last_host));
	
process_request:
	buffer[n] = '\0';
	
	/* Log the client request. */
	/*
	if (td->logfile)
		log_request(td->client_ip, buffer, n, td->auth_ip, td->netmask);
	*/

	/* Look to see if the HTTP request is a CONNECT method or not. */
	c_flag = 0;
	
	if (!strncmp(buffer, "CONNECT ", 8))
	{
		if (!td->connect)
		{
			SYSLOG(LOG_INFO, "!td->connect fail");
			child_exit(13);
		}
		
		c_flag = 1;
	}
	
	/* Skip the HTTP method. */
	
	url_host = buffer;
	SYSLOG(LOG_INFO, "url_host=%s",url_host);
	while (*url_host != ' ')
	{
		if ((url_host - buffer) > 10 || !(*url_host))
		{
			SYSLOG(LOG_INFO, "url_host fail");
			child_exit(14);
		}		
		url_host++;
	}
	
	url_host++;
	
	/* Get the HTTP server hostname. */
	if (!c_flag)
	{
		if (!strncmp(url_host, "http://", 7))
			url_host += 7;
		else
		{
			SYSLOG(LOG_INFO, "fake header");			
			if (!fakeheader(buffer, strlen(buffer))) {
				SYSLOG(LOG_INFO,"fakeheader():NULL fail");				
				child_exit(15);
			}
			if (!strncmp(url_host, "http://", 7))
				url_host += 7;
		}
	}
	
	/* Copy the requested URL to a temporary buffer for access control. */
	for (loc = 0; url_host[loc] != (c_flag ? ':' : ' ') &&
	     url_host[loc]; loc++);
	current_url = malloc(loc + 1);
	strncpy(current_url, url_host, loc);
	SYSLOG(LOG_INFO, "current_url=%s",current_url);	
	char *new_url;
	new_url = unescape_url(current_url, loc);
	SYSLOG(LOG_INFO, "new_url=%s",new_url);
	free(current_url);
	current_url = new_url;
	/* Resolve the HTTP server hostname. */
	str_end = url_host;
	
	while (*str_end != ':' && *str_end != '/' && *str_end != '\0')
	{
		if ((str_end - url_host) >= HOST_SIZE || (!(*str_end)))
		{
			SYSLOG(LOG_INFO, "url_host size fail");
			child_exit(16);
		}
		
		str_end++;
	}

	c = *str_end;
	*str_end = '\0';
	//if (!check_urls(url_host, 1) || (!c_flag && !check_urls(current_url, 0)))
	if (!check_urls(url_host, 1))
	{
/* 
 Date: 2009-1-05 
 Name: Ken_Chiang
 Reason: modify for the crowdcontrol can open and close used the log.
 Notice :
*/	
		//list_ipitem(log_iplists);
		if(chk_logip(client_ip, log_iplists, 0, current_url)){
			addr.s_addr = client_ip;
			/*
				NickChou move syslog into chk_logip() 20090610
				To show MAC in GUI Log Page
				When using Access Control -> MAC Address filter for Block Some Access
			*/
			//syslog(LOG_INFO, "%s blocked for %s", current_url, inet_ntoa(addr));
		}		
			
		SYSLOG(LOG_INFO, "blocked[%s]", current_url);		
		deny_access(client_fd, c_flag, current_url);
		free(current_url);
		//if (!c_flag)
		if (c_flag) // I think that is right way to exit socket, peter		
		{
			SYSLOG(LOG_INFO, "c_flag close");			
			child_exit(17);
		}
		SYSLOG(LOG_INFO, "close\n");
		child_exit(17); //add by peter
		SYSLOG(LOG_INFO, "process_request\n");
		goto process_request;
	}
/* 
 Date: 2009-1-05 
 Name: Ken_Chiang
 Reason: modify for the crowdcontrol can open and close used the log.
 Notice :
*/	
	if(chk_logip(client_ip, log_iplists, 1, current_url)){
		addr.s_addr = client_ip;
		/*
			NickChou move syslog into chk_logip() 20090610
			To show MAC in GUI Log Page
			When using Access Control -> MAC Address filter for Block Some Access
		*/
		//syslog(LOG_INFO, "%s accessed from %s\n", current_url, inet_ntoa(addr));
	}		
	if (!(remote_host = gethostbyname(url_host)))
	{
		SYSLOG(LOG_INFO, "gethostbyname[%s] error\n", url_host);				
		child_exit(18);
	}
	SYSLOG(LOG_INFO, "remote_host->h_addr=%x\n",remote_host->h_addr);
	
	*str_end = c;
	
	/* Get the HTTP server port. */
	if (c != ':')
	{
		SYSLOG(LOG_INFO, "c != :");
		c           = *str_end;
		*str_end    = '\0';
		remote_port = 80;
	}
	else
	{
		SYSLOG(LOG_INFO, "c = :");
		url_port = ++str_end;
		while (*str_end != ' ' && *str_end != '/')
		{
			if (*str_end < '0' || *str_end > '9')
			{
				SYSLOG(LOG_INFO, "str_end fail");
				child_exit(19);
			}
			
			str_end++;
			
			if (str_end - url_port > 5)
			{
				SYSLOG(LOG_INFO, "str_end - url_port > 5 fail");
				child_exit(20);
			}
		}
		
		c           = *str_end;
		*str_end    = '\0';
		remote_port = atoi(url_port);
	}
	SYSLOG(LOG_INFO, "remote_port=%d",remote_port);
	if (c_flag)
	{
		if ((td->connect == 1 && remote_port != 443) ||
		    (remote_port < 1 || remote_port > 65535))
		{
			SYSLOG(LOG_INFO, "remote_port=%d fail",remote_port);
			child_exit(21);
		}
	}
	
	/* Connect to the remote server, if not already connected. */
	if (strcmp(url_host, last_host))
	{
		shutdown(remote_fd, 2);
		close(remote_fd);
		
		remote_fd = socket(AF_INET, SOCK_STREAM, IPPROTO_IP);
		
		if (remote_fd < 0)
		{
			SYSLOG(LOG_INFO, "remote_fd socket fail");
			child_exit(22);
		}
		
		remote_addr.sin_family = AF_INET;
		remote_addr.sin_port   = htons((unsigned short)remote_port);
		
		memcpy((void *)&remote_addr.sin_addr, (void *)remote_host->h_addr,
		       remote_host->h_length);
		
		if (connect(remote_fd, (struct sockaddr *)&remote_addr,
			sizeof(remote_addr)) < 0)
		{
			SYSLOG(LOG_INFO, "remote_fd connect fail");
			child_exit(23);
		}
		
		memset(last_host, 0, sizeof(last_host));
		strncpy(last_host, url_host, sizeof(last_host) - 1);
	}
	
	*str_end = c;
	SYSLOG(LOG_INFO, "session[%s]", current_url);		
	
	if (c_flag)
	{
		SYSLOG(LOG_INFO, "c_flag Accept[%s]", current_url);				
		strncpy(buffer, "HTTP/1.0 200 Connection Established\r\n\r\n",
				sizeof(buffer));
		
		if (send(client_fd, buffer, 39, 0) != 39)
		{
			SYSLOG(LOG_INFO, "accept[%s] send fail",current_url);
			child_exit(24);
		}
	}
	else
	{
		int m_len;

		/* Remote "http://hostname[:port]" and send headers. */
		SYSLOG(LOG_INFO, "!c_flag u[%s]h[%s]e[%s]", url_host, buffer, str_end);		
		m_len = url_host - 7 - buffer;
		n -= 7 + (str_end - url_host);
		memcpy(str_end -= m_len, buffer, m_len);
		SYSLOG(LOG_INFO, "send:[%s]", str_end);		
		
		if (n != strlen(str_end)) {
			SYSLOG(LOG_INFO, "length differ:%d:%d", n, strlen(str_end));			
			n = strlen(str_end);	
		}
		
		if (send(remote_fd, str_end, n, 0) != n)
		{
			SYSLOG(LOG_INFO, "str_end[%s] send fail",str_end);
			child_exit(25);
		}
	}
	
	/* Tunnel the data between the client and the server. */
	state = 0;
	
	while (1)
	{
		FD_ZERO(&rfds);
		FD_SET((unsigned int)client_fd, &rfds);
		FD_SET((unsigned int)remote_fd, &rfds);
		
		n = (client_fd > remote_fd) ? client_fd : remote_fd;
		
		if (select(n + 1, &rfds, NULL, NULL, NULL) < 0)
		{
			SYSLOG(LOG_INFO, "select fail");
			child_exit(26);
		}
		
		if (FD_ISSET(remote_fd, &rfds))
		{
			SYSLOG(LOG_INFO, "remote_fd FD_ISSET");
			if ((n = recv(remote_fd, buffer, URLBUF_STRL, 0)) <= 0)
			{
				SYSLOG(LOG_INFO, "remote_fd recv fail");
				child_exit(27);
			}
			
			state = 1;
			
			if (send(client_fd, buffer, n, 0) != n)
			{
				SYSLOG(LOG_INFO, "client_fd send fail");
				child_exit(28);
			}
		}
		
		if (FD_ISSET(client_fd, &rfds))
		{
			SYSLOG(LOG_INFO, "client_fd FD_ISSET");
			if ((n = recv(client_fd, buffer, URLBUF_STRL, 0)) <= 0)
			{
				SYSLOG(LOG_INFO, "client_fd recv fail");
				child_exit(29);
			}
			
			if (state && !c_flag)
			{
				/* New HTTP request. */
				SYSLOG(LOG_INFO, "New request process_request");
				goto process_request;
			}
			
			if (send(remote_fd, buffer, n, 0) != n)
			{
				SYSLOG(LOG_INFO, "remote_fd send fail");
				child_exit(30);
			}
		}
	}	
	/* Not reached. */
	return -1;
}

static int read_schedule_from_config(const char *sch_cfg)
{
	int ret = -1;
	char *p, line[128];
	FILE *fp = fopen(sch_cfg, "r");

	if (fp == NULL)
		goto out;

	while (fscanf(fp, "%s", line) != EOF) {
		char *key;

		p = line;
		key = strsep(&p, "=");

		if (strncmp(key, "schedule_rule", 13) == 0) {
			strcpy(sys_sch[syssch_certain_exists].key, key);
			strcpy(sys_sch[syssch_certain_exists++].content, p);
		} else {
			strcpy(url_sch[urlsch_certain_exists].key, key);
			strcpy(url_sch[urlsch_certain_exists++].content, p);
		}
	}

	fclose(fp);
	do_schedule = 1;	/* open schedule checking procedure */
	ret = 0;
out:
	return ret;
}

int main(int argc, char **argv)
{
	int i, param = 0, rp = 0, proxy_port = 32800, proxy_fd, log_fd;
	char *permitdomains = NULL, *permiturls = NULL, *permitexpressions = NULL;
	char *denydomains = NULL, *denyurls = NULL, *denyexpressions = NULL;
	char *testurl = NULL;
	/* 
 	Date: 2009-1-05 
 	Name: Ken_Chiang
 	Reason: modify for the crowdcontrol can open and close used the log.
 	Notice :
	*/	
	char *logips = NULL;
	/* Date: 2009-01-08
	 * Name: Fred Hung
	 * Reason: let crowdcontrol identify schedule rule
	 */
	char *sch_cfg = NULL;

	socklen_t n;
	
	struct sockaddr_in proxy_addr, client_addr;
	struct thread_data td;
	
	/* Read the program arguments. */
	td.server_ip = INADDR_ANY;
	td.auth_ip   = INADDR_ANY;
	td.netmask   = 0xFFFFFFFF;
	td.connect   = 2;
	openlog("urlblock", LOG_PID, LOG_USER);
	for (i = 1; i < argc; i++)
	{
		if (argv[i][0] == '-')
		{
			FPRINTF(stderr, "argv[%d][0]==\'-\'\n",i);
			if (rp)
			{
				FPRINTF(stderr, _GLOBAL_ERRPARAM, argv[0], argv[i - rp]);
			}
			
			if (argv[i][1] == '-')
			{
				FPRINTF(stderr, "argv[%d][1]==\'-\'\n",i);
				if (!strcmp(argv[i], "--port"))
				{
					FPRINTF(stderr, "argv[%d] --port\n",i);
					param = PARAM_PORT;
					rp    = 1;
					continue;
				}
				
				if (!strcmp(argv[i], "--bind"))
				{
					FPRINTF(stderr, "argv[%d] --bind\n",i);
					param = PARAM_BIND;
					rp    = 1;
					continue;
				}
				
				if (!strcmp(argv[i], "--subnet"))
				{
					FPRINTF(stderr, "argv[%d] --subnet\n",i);
					param = PARAM_SUBNET;
					rp    = 1;
					continue;
				}
				
				if (!strcmp(argv[i], "--max-connections"))
				{
					FPRINTF(stderr, "argv[%d] --max-connections\n",i);
					param = PARAM_MAXCONNECTIONS;
					rp    = 1;
					continue;
				}
				
				if (!strcmp(argv[i], "--http-only"))
				{
					FPRINTF(stderr, "argv[%d] --http-only\n",i);
					param = PARAM_HTTPONLY;
					continue;
				}
				
				if (!strcmp(argv[i], "--http-with-ssl"))
				{
					FPRINTF(stderr, "argv[%d] --http-with-ssl\n",i);
					param = PARAM_HTTPWITHSSL;
					continue;
				}
				
				if (!strcmp(argv[i], "--http-tunnel"))
				{
					FPRINTF(stderr, "argv[%d] --http-tunnel\n",i);
					param = PARAM_HTTPTUNNEL;
					continue;
				}
				
				if (!strcmp(argv[i], "--implicitly-deny"))
				{
					FPRINTF(stderr, "argv[%d] --implicitly-deny\n",i);					
					param = PARAM_IMPLICITLYDENY;
					_GLOBAL_IMPLICITACTION = BLOCKED;
					continue;
				}
				
				if (!strcmp(argv[i], "--implicitly-permit"))
				{
					FPRINTF(stderr, "argv[%d] --implicitly-permit\n",i);
					param = PARAM_IMPLICITLYPERMIT;
					continue;
				}
				
				if (!strcmp(argv[i], "--permit-domains"))
				{
					FPRINTF(stderr, "argv[%d] --permit-domains\n",i);
					param = PARAM_PERMITDOMAINS;
					rp    = 1;
					continue;
				}
				
				if (!strcmp(argv[i], "--permit-urls"))
				{
					FPRINTF(stderr, "argv[%d] --permit-urls\n",i);
					param = PARAM_PERMITURLS;
					rp    = 1;
					continue;
				}
				
				if (!strcmp(argv[i], "--permit-expressions"))
				{
					FPRINTF(stderr, "argv[%d] --permit-expressions\n",i);
					param = PARAM_PERMITEXPRESSIONS;
					rp    = 1;
					continue;
				}
				
				if (!strcmp(argv[i], "--deny-domains"))
				{
					FPRINTF(stderr, "argv[%d] --deny-domains\n",i);
					param = PARAM_DENYDOMAINS;
					rp    = 1;
					continue;
				}
				
				if (!strcmp(argv[i], "--deny-urls"))
				{
					FPRINTF(stderr, "argv[%d] --deny-urls\n",i);
					param = PARAM_DENYURLS;
					rp = 1;
					continue;
				}
				
				if (!strcmp(argv[i], "--deny-expressions"))
				{
					FPRINTF(stderr, "argv[%d] --deny-expressions\n",i);
					param = PARAM_DENYEXPRESSIONS;
					rp    = 1;
					continue;
				}
				
				if (!strcmp(argv[i], "--test"))
				{
					FPRINTF(stderr, "argv[%d] --test\n",i);
					param = PARAM_TESTURL;
					rp    = 1;
					continue;
				}				
			}
			else
			{
				FPRINTF(stderr, "argv[%d][1]!=\'-\'\n",i);
				if (argv[i][1] == 'p')
				{
					FPRINTF(stderr, "argv[%d] -p\n",i);
					param = PARAM_PORT;
					rp    = 1;
					continue;
				}
				
				if (argv[i][1] == 'a')
				{
					FPRINTF(stderr, "argv[%d] -a\n",i);
					param = PARAM_BIND;
					rp    = 1;
					continue;
				}
				
				if (argv[i][1] == 's')
				{
					FPRINTF(stderr, "argv[%d] -s\n",i);
					param = PARAM_SUBNET;
					rp    = 1;
					continue;
				}
				
				if (argv[i][1] == 'm')
				{
					FPRINTF(stderr, "argv[%d] -m\n",i);
					param = PARAM_MAXCONNECTIONS;
					rp    = 1;
					continue;
				}
				/* 
 				Date: 2009-1-05 
 				Name: Ken_Chiang
 				Reason: modify for the crowdcontrol can open and close used the log.
 				Notice:
 				*/
 				if (argv[i][1] == 'l')
				{
					FPRINTF(stderr, "argv[%d] -l\n",i);									
					param = PARAM_USEDLOG;
					rp    = 1;
					continue;
				}

				/* Date: 2009-01-08
				 * Name: Fred Hung
				 * Reason: let crowdcontrol identify the schedule file
				 */
				if (argv[i][1] == 'S') {
					FPRINTF(stderr, "argv[%d] -S\n", i);
					param = PARAM_SCHEDULE;
					rp = 1;
					continue;
				}
			}
		}
		else
		{
			FPRINTF(stderr, "argv[%d][0]!=\'-\'\n",i);
			switch (param)
			{
				case 0:
					break;
					
				case PARAM_PORT:
					proxy_port = atoi(argv[i]);
					FPRINTF(stderr, "proxy_port=%x\n",proxy_port);
					--rp;
					break;
					
				case PARAM_BIND:
					td.auth_ip = td.server_ip = inet_addr(argv[i]);
					FPRINTF(stderr, "td.server_ip=%x\n",td.server_ip);
					--rp;
					break;
					
				case PARAM_SUBNET:
					td.netmask = inet_addr(argv[i]);
					FPRINTF(stderr, "td.netmask=%x\n",td.netmask);
					--rp;
					break;
					
				case PARAM_MAXCONNECTIONS:
					_GLOBAL_MAX_CONNECTIONS = atoi(argv[i]);
					if (!_GLOBAL_MAX_CONNECTIONS)
						_GLOBAL_MAX_CONNECTIONS = 16;
					FPRINTF(stderr, "_GLOBAL_MAX_CONNECTIONS=%x\n",_GLOBAL_MAX_CONNECTIONS);	
					--rp;
					break;
					
				case PARAM_HTTPONLY:
					td.connect = 0;
					FPRINTF(stderr, "td.connect=%x\n",td.connect);
					break;
					
				case PARAM_HTTPWITHSSL:
					td.connect = 1;
					FPRINTF(stderr, "td.connect=%x\n",td.connect);
					break;
					
				case PARAM_HTTPTUNNEL:
					td.connect = 2;
					FPRINTF(stderr, "td.connect=%x\n",td.connect);
					break;
					
				case PARAM_IMPLICITLYDENY:
					_GLOBAL_IMPLICITACTION = BLOCKED;
					FPRINTF(stderr, "_GLOBAL_IMPLICITACTION=%x\n",_GLOBAL_IMPLICITACTION);
					break;
					
				case PARAM_IMPLICITLYPERMIT:
					break;
					
				case PARAM_PERMITDOMAINS:
					permitdomains = argv[i];
					FPRINTF(stderr, "permitdomains=%s\n",permitdomains);
					--rp;
					break;
					
				case PARAM_PERMITURLS:
					permiturls = argv[i];
					FPRINTF(stderr, "permiturls=%s\n",permiturls);
					--rp;
					break;
					
				case PARAM_PERMITEXPRESSIONS:
					permitexpressions = argv[i];
					FPRINTF(stderr, "permitexpressions=%s\n",permitexpressions);
					--rp;
					break;
					
				case PARAM_DENYDOMAINS:
					denydomains = argv[i];
					FPRINTF(stderr, "denydomains=%s\n",denydomains);
					--rp;
					break;
					
				case PARAM_DENYURLS:
					denyurls = argv[i];
					FPRINTF(stderr, "denyurls=%s\n",denyurls);
					--rp;
					break;
					
				case PARAM_DENYEXPRESSIONS:
					denyexpressions = argv[i];
					FPRINTF(stderr, "PARAM_DENYEXPRESSIONS=%s\n",PARAM_DENYEXPRESSIONS);
					--rp;
					break;
					
				case PARAM_TESTURL:
					testurl = argv[i];
					FPRINTF(stderr, "testurl=%s\n",testurl);
					--rp;
					break;
				/* 
 				Date: 2009-1-05 
 				Name: Ken_Chiang
 				Reason: modify for the crowdcontrol can open and close used the log.
 				Notice:
 				*/	
				case PARAM_USEDLOG:
					logips = argv[i];
					FPRINTF(stderr, "logips=%s\n",logips);						
					--rp;
					break;
				/* Date: 2009-01-08
				 * Name: Fred Hung
				 * Reason: let crowdcontrol identify schedule file
				 */
				case PARAM_SCHEDULE:
					sch_cfg = argv[i];
					FPRINTF(stderr, "sch_cfg=%s\n", sch_cfg);
					--rp;
					break;
			}
			
			param = 0;
		}
	}
	
	if (rp)
	{
		FPRINTF(stderr, _GLOBAL_ERRPARAM, argv[0], argv[i - rp]);
		return 1;
	}
	/* Process a list of permitted domains. */
	permitted_urls = loaddomainfile(argv[0], permitdomains, permitted_urls);
	
	/* Process a list of permitted URLs. */
	permitted_urls = loadurlfile(argv[0], permiturls, permitted_urls);
	
	/* Process a list of permitted expressions. */
	permitted_urls = loadexpressionfile(argv[0], permitexpressions,
		                                      permitted_urls);
	
	/* Process a list of blocked domains. */
	blocked_urls = loaddomainfile(argv[0], denydomains, blocked_urls);
	
	/* Process a list of blocked URLs. */
	blocked_urls = loadurlfile(argv[0], denyurls, blocked_urls);
	
	/* Process a list of blocked expressions. */
	blocked_urls = loadexpressionfile(argv[0], denyexpressions, blocked_urls);
	
	/* 
 	Date: 2009-1-05 
 	Name: Ken_Chiang
 	Reason: modify for the crowdcontrol can open and close used the log.
 	Notice :
	*/	
	/* Process a list of log ip. */
	log_iplists = loadiplogfile(argv[0], logips, log_iplists);

	/* Date: 2009-01-08
	 * Name: Fred Hung
	 * Reason: read schedule info from schedule config file
	 */

	sch_cfg ? read_schedule_from_config(sch_cfg):0;

	if (testurl)
	{
		if (!check_urls(testurl, 1))
		{
			FPRINTF(stderr, "%s Domain blocked.\n", testurl);
			return 0;
		}
		
		if (!check_urls(testurl, 0))
		{
			FPRINTF(stderr, "%s URL/regex blocked.\n", testurl);
			return 0;
		}
		
		FPRINTF(stderr, "%s Permitted.\n", testurl);
		return 0;
	}
	
	td.auth_ip  &= td.netmask;
	td.client_ip = 0;
	
#ifdef WIN32
	int tid;
	WSADATA wsaData;
	
	tdSem = CreateSemaphore(NULL, 0, 1, NULL);
	
	if (WSAStartup(MAKEWORD(2, 0), &wsaData) == SOCKET_ERROR)
		return 3;
#else
	int pid;
	
	/* If inetd mode is enabled, use stdin. */
	if (!proxy_port)
	{
		SYSLOG(LOG_INFO, "no proxy_port\n");
		td.client_fd = 0;		
		return (client_thread(&td));
	}
	
	/* Fork into background. */
	if ((pid = fork()) < 0)
	{
		SYSLOG(LOG_INFO, "fork fail\n");
		return 2;
	}
	
	if (pid){
		SYSLOG(LOG_INFO, "pid fail\n");
		//return 0;
		exit(0);
	}	
	
	/* Create a new session. */
	SYSLOG(LOG_INFO, "child process: %d\n", pid);
	if (setsid() < 0){
		SYSLOG(LOG_INFO, "setsid fail\n");
		return 3;
	}	
	SYSLOG(LOG_INFO, "setsid success\n");
	
	/* Close all file descriptors. */
	while (!close(n) && n++ < MAXIMUM_FILE_DESCRIPTORS);
#endif
	/* Create a socket. */
	proxy_fd = socket(AF_INET, SOCK_STREAM, IPPROTO_IP);
	
	if (proxy_fd < 0){
		SYSLOG(LOG_INFO, "Create proxy a socket fail\n");
		return 4;
	}	
	/*
	log_fd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);	
	if (log_fd < 0){
		SYSLOG(LOG_INFO, "Create log a socket fail\n");
		return 4;
	}	
	*/
	/* Bind the proxy on the local port and listen. */
#ifndef WIN32
	n = 1;
	
	if (setsockopt(proxy_fd, SOL_SOCKET, SO_REUSEADDR, (void *)&n, sizeof(n))< 0){
		SYSLOG(LOG_INFO, "bind proxy a socket SO_REUSEADDR fail\n");
		return 5;
	}	
	n = TCP_WINDOW_SIZE;
	
	if (setsockopt(proxy_fd, SOL_SOCKET, SO_SNDBUF, (void *)&n, sizeof(n)) < 0){
		SYSLOG(LOG_INFO, "bind proxy a socket SO_SNDBUF fail\n");
		return 5;
	}	

	if (setsockopt(proxy_fd, SOL_SOCKET, SO_RCVBUF, (void *)&n, sizeof(n)) < 0){
		SYSLOG(LOG_INFO, "bind proxy a socket SO_RCVBUF fail\n");
		return 5;
	}	
#endif
	/*
	n = 1;
	if (setsockopt(log_fd, SOL_SOCKET, SO_BROADCAST, (void *)&n, sizeof(n))< 0){
		SYSLOG(LOG_INFO, "bind log a socket SO_BROADCAST fail\n");
		return 5;
	}	
	
	td.log_fd = log_fd;
	*/
	td.auth_ip &= td.netmask;
	SYSLOG(LOG_INFO, "proxy_port=%d,proxy.server_ip=%x\n",proxy_port,td.server_ip);
	memset(&proxy_addr, 0, sizeof(proxy_addr));
	proxy_addr.sin_family      = AF_INET;
	proxy_addr.sin_port        = htons((unsigned short)proxy_port);
	proxy_addr.sin_addr.s_addr = td.server_ip;
	
	if (bind(proxy_fd, (struct sockaddr *)&proxy_addr, sizeof(proxy_addr)) < 0) {
		SYSLOG(LOG_INFO, "bind() fail:%s", strerror(errno));		
		return 6;
	}

	if (listen(proxy_fd, _GLOBAL_MAX_CONNECTIONS)){
		SYSLOG(LOG_INFO, "proxy_fd listen fail\n");
		return 7;
	}	
#ifdef __USE_PTHREAD__
	pthread_mutex_init(&plock, NULL);
#endif
	while (1)
	{
		n = sizeof(client_addr);

		/* Wait for an inbound connection. */

		if ((td.client_fd = accept(proxy_fd, (struct sockaddr *)&client_addr,
			 &n)) < 0) {
			SYSLOG(LOG_INFO, "proxy_fd accept():%s", strerror(errno));			
			return 8;
		}
		td.client_ip = client_addr.sin_addr.s_addr;
		
		/* Verify that the client is authorized. */
		
		if ((td.client_ip & td.netmask) != td.auth_ip)
		{
			SYSLOG(LOG_INFO, "client_fd client_ip=%x fail close\n", td.client_ip);
			close(td.client_fd);
			continue;
		}
		SYSLOG(LOG_INFO, "accept():ip=%x", td.client_ip);		
#ifndef WIN32
#ifdef __USE_PTHREAD__
		if(!use_pthread(&td)){
			exit(-1);
		}
		continue;
#endif // __USE_PTHREAD__
		/* Fork a child process to handle the connection. */
		if ((pid = fork()) < 0)
		{
			SYSLOG(LOG_INFO, "client_fd fork fail close\n");
			close(td.client_fd);
			continue;
		}
		
		if (pid)
		{
			/* In parent thread: wait for child to finish. */
			SYSLOG(LOG_INFO, "client_fd waitpid close\n");
			close(td.client_fd);
			waitpid(pid, NULL, 0);
			continue;
		}
		
		/* In child: fork and exit so that the parent thread becomes init. */
		if ((pid = fork()) < 0){
			SYSLOG(LOG_INFO, "In child: fork fail\n");
			return 9;
		}			
		if (pid){
			SYSLOG(LOG_INFO, "In child: pid fail\n");
			return 0;
		}	
		SYSLOG(LOG_INFO, "client_thread\n");
		return client_thread(&td);		

#else
		/* Spawn a thread to handle the connection. */
		CloseHandle(CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)
		            client_thread, &td, 0, &tid));
		
		/* Wait until the thread has read its data. */
		WaitForSingleObject(tdSem, INFINITE);
#endif
	}	
	/* Not reached. */
	return -1;
}
