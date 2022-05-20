#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <unistd.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <time.h>
#include <sys/time.h>
#include <syslog.h>
#include <wait.h>
#include <sutil.h>
#include <net/if.h>

#ifdef NOIP_DEBUG
#define DEBUG_MSG(fmt, arg...)       printf(fmt, ##arg)
#else
#define DEBUG_MSG(fmt, arg...) 
#endif

static char wan_eth[32] = {0};
static char ddns_hostname[32] ={0};
static char ddns_type[32] = {0};
static char ddns_username[32] = {0};
static char ddns_password[32] = {0};
static char ddns_wildcards_enable[2] = {0};
static char ddns_dyndns_kinds[32] = {0};
static int ddns_sync_interval = 3600;
static char model_name[32] = {0};
static char model_number[32] = {0};
#if 0
static char old_wan_ip[32] = {0};
static char old_hostname[32] = {0};
#endif
static char wan_ip[16] ={0};


char *get_ipaddr(char *if_name)
{
	int sockfd;
	struct ifreq ifr;
	struct in_addr temp_ip;

	if ((sockfd = socket(AF_INET, SOCK_RAW, IPPROTO_RAW)) < 0)
		return 0;

	strcpy(ifr.ifr_name, if_name);
	if( ioctl(sockfd, SIOCGIFADDR, &ifr) < 0) {
		close(sockfd);
		return 0;
	}

	close(sockfd);

	temp_ip.s_addr = sin_addr(&ifr.ifr_addr).s_addr;
	return inet_ntoa(temp_ip);
}

int ddns_update(int type)
{
	int wan_status = 1;
	char wildcards[3]={};
	
	if((wan_status = wan_connected_cofirm(wan_eth)))// Don't execute during upgrading
	{ 
		DEBUG_MSG("NOIP \n\n\n");
		/* enable dyndns wildcard*/	
		if((strcmp(ddns_wildcards_enable,"1") == 0) && (type == 0) )
			strcpy(wildcards,"-w");
		else
			strcpy(wildcards," ");
			
		_system("/sbin/noip2 -T %d -R %s -u %s -p %s %s -I %s -k %s -a %s -n %s &", \
				type, ddns_hostname, ddns_username, ddns_password, wildcards, \
				wan_eth, ddns_dyndns_kinds, model_name, model_number);
		return 0;
	}

	DEBUG_MSG("noip: nothing to do...\n");  
	return -1;
}

void usage(void)
{
	printf("Usage: noiptime [-t interval in sec] [-i wan interface ] [-h hostname]"\
			"[-y type] [-u username ] [-p password] [-w wildcards_enable]"\
			"[-k dyndns_kinds ] [-a model_name] [-n model_number] [-o old_wan_ip] [-O old_hostname]\n");
}
/* The deamon is used to decide when to perform update with ddns server.
 * If either of the following conditions is satisfied, we will perform ddns update.
 * 1. wan ip or hostname has been changed.
 * 2. time limit has expired .
 */

int main (int argc, char *argv[])
{
	int c = 0;
	int type = 0;
	
		
	/*Parse the arguments*/
	for(;;){
		c = getopt(argc, argv, "t:i:h:y:u:p:w:k:a:n:o:O:");
		if ( c == EOF)
			break;
		
		switch(c)
		{
			case 't':
				ddns_sync_interval=atoi(optarg);
				if(ddns_sync_interval < 3600) /* 1 hour */
					ddns_sync_interval = 3600;
				break;
			case 'i':
				strcpy(wan_eth,optarg);
				break;
			case 'h':
				strcpy(ddns_hostname,optarg);
				break;
			case 'y':
				strcpy(ddns_type,optarg);
				break;
			case 'u':
				strcpy(ddns_username,optarg);
				break;
			case 'p':
				strcpy(ddns_password,optarg);
				break;
			case 'w':
				strcpy(ddns_wildcards_enable,optarg);
				break;
			case 'k':
				strcpy(ddns_dyndns_kinds,optarg);
				break;
			case 'a':
				strcpy(model_name,optarg);
				break;
			case 'n':
				strcpy(model_number,optarg);
				break;
#if 0
			case 'o':
				strcpy(old_wan_ip,optarg);
				break;
			case 'O':
				strcpy(old_hostname,optarg);
				break;
#endif
			default:
				usage();
				exit(1);
		} 
	}
	/* Make sure we get all the arguments. */
#if 0
	if( !ddns_sync_interval || !wan_eth || !ddns_hostname || !ddns_type || \
		!ddns_username || !ddns_password || !ddns_wildcards_enable || !ddns_dyndns_kinds ||\
		!model_name || !model_number || !old_wan_ip || !old_hostname )
	{
		DEBUG_MSG("NOIP ERROR: There is no enough arguments!");
		return	0;
	}
#endif

	/*Decide the type*/
	if (strcmp( ddns_type, "DynDns.org" ) == 0)
		type = 0;
	else if (strcmp( ddns_type, "EasyDns.com" ) == 0)
		type = 1;
	else if (strcmp( ddns_type, "dynupdate.no-ip.com" ) == 0)
		type = 2;
	else if (strcmp( ddns_type, "changeip.com" ) == 0)
		type = 3;
	else if (strcmp( ddns_type, "eurodyndns.com" ) == 0)
		type = 4;
	else if (strcmp( ddns_type, "ods.com" ) == 0)
		type = 5;
	else if (strcmp( ddns_type, "ovh.com" ) == 0)
		type = 6;
	else if (strcmp( ddns_type, "regfish.com" ) == 0)
		type = 7;
	else if (strcmp( ddns_type, "tzo.com" ) == 0)
		type = 8;
	else if (strcmp( ddns_type, "zoneedit.com" ) == 0)
		type = 9;
	else if (strcmp( ddns_type, "dlinkddns.com" ) == 0)
		type = 10;
	
	/* Make sure we have get wan ip address
	 * When router obtains wan ip, it will restart firewall only.
	 * Therefore, noip still runs.
	 */
	while(!get_ipaddr(wan_eth))
	{
		DEBUG_MSG("NOIP MSG: not obtain IP yet!\n");
		sleep(2);
	}
	strcpy(wan_ip , get_ipaddr(wan_eth));
	
#if 0//for cdrouter DynDns client doesn't rely upon DNS to determine if an update is necessary
	/*Check if need update ddns.
	 * 1.Both old_wan_ip and old_hostname are NULL(0.0.0.0): Never update before, this is the first time!
	 * 2.The wan ip has been changed: Update was performed before, need update new wan ip.
	 * 3.The wan ip is the same, but hostname is different with the last one:
	 *   Update was performed with another hostname before, but this hostname has not been updated with the wan ip.
	 */
	if( !strcmp(old_wan_ip , "0.0.0.0") || !strcmp(old_hostname , "0.0.0.0") \
		|| strcmp(get_ipaddr(wan_eth) , old_wan_ip) || strcmp(ddns_hostname , old_hostname))
	{
		printf("NOIP_TIME:first update\n");
		ddns_update(type);
	}
	//else /*(wan ip != ddns_hostname ip), we also need to update*/	
#else	
	{
		FILE *fp = NULL;
		char buf[80]={0}, host_ip[16]={0};
		char *ip_s=NULL, *ip_e=NULL;	
		
		_system("ping -c 1 \"%s\" > /var/tmp/ddns_check.txt 2>&1", ddns_hostname);

		fp = fopen("/var/tmp/ddns_check.txt", "r");
		if(fp)
		{		
			memset(buf, 0, 80);
			fgets(buf, sizeof(buf), fp);
			ip_s = strstr(buf, "(");
			ip_e = strstr(buf, ")");
			if(ip_s && ip_e)
			{
				strncpy(host_ip, ip_s+1, ip_e-(ip_s+1));
				if(strcmp(get_ipaddr(wan_eth), host_ip))
				{
					printf("NOIP_TIME: wan ip %s != %s %s\n", get_ipaddr(wan_eth), ddns_hostname, host_ip);
					ddns_update(type);
				}	
			}	
			else
				ddns_update(type);
					
			fclose(fp);	
		}
		else 
		{ 
			printf("NOIP_TIME: open /var/tmp/ddns_check.txt fail");
			return	0;	
		}	
	}
#endif	
	for(;;) 
	{		
		sleep(ddns_sync_interval);
		ddns_update(type);
	}	  
	
	return 0;
}


