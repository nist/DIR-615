/*
 * files.c -- DHCP server file manipulation *
 * Rewrite by Russ Dill <Russ.Dill@asu.edu> July 2001
 */

#include <sys/socket.h>
#include <arpa/inet.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <netdb.h>

#include <netinet/ether.h>
#include "static_leases.h"

#include "dhcpd.h"
#include "files.h"
#include "options.h"
#include "common.h"
int getDomainNameFromGUI = 0;
/*
 * Domain names may have 254 chars, and string options can be 254
 * chars long. However, 80 bytes will be enough for most, and won't
 * hog up memory. If you have a special application, change it
 */
#ifdef UDHCPD_ALWAYS_BROADCAST
unsigned int always_bcast;
#endif
 
#define READ_CONFIG_BUF_SIZE 80

/* on these functions, make sure you datatype matches */
static int read_ip(const char *line, void *arg)
{
	struct in_addr *addr = arg;
	struct hostent *host;
	int retval = 1;

	if (!inet_aton(line, addr)) {
		if ((host = gethostbyname(line)))
			addr->s_addr = *((unsigned long *) host->h_addr_list[0]);
		else retval = 0;
	}
	return retval;
}

static int read_mac(const char *line, void *arg)
{
	uint8_t *mac_bytes = arg;
	struct ether_addr *temp_ether_addr;
	int retval = 1;

	temp_ether_addr = ether_aton(line);

	if(temp_ether_addr == NULL)
		retval = 0;
	else
		memcpy(mac_bytes, temp_ether_addr, 6);

	return retval;
}


static int read_str(const char *line, void *arg)
{
	char **dest = arg;

	if (*dest) free(*dest);
	*dest = strdup(line);

	return 1;
}


static int read_u32(const char *line, void *arg)
{
	uint32_t *dest = arg;
	char *endptr;
	*dest = strtoul(line, &endptr, 0);
	return endptr[0] == '\0';
}


static int read_yn(const char *line, void *arg)
{
	char *dest = arg;
	int retval = 1;

	if (!strcasecmp("yes", line))
		*dest = 1;
	else if (!strcasecmp("no", line))
		*dest = 0;
	else retval = 0;

	return retval;
}


/* read a dhcp option and add it to opt_list */
static int read_opt(const char *const_line, void *arg)
{
	struct option_set **opt_list = arg;
	char *opt, *val, *endptr;
	struct dhcp_option *option;
	int retval = 0, length;
	char buffer[8];
	char *line;
	uint16_t *result_u16 = (uint16_t *) buffer;
	uint32_t *result_u32 = (uint32_t *) buffer;

	/* Cheat, the only const line we'll actually get is "" */
	line = (char *) const_line;
	if (!(opt = strtok(line, " \t="))) 
		return 0;

	for (option = dhcp_options; option->code; option++)
		if (!strcasecmp(option->name, opt))
			break;

	if (!option->code) 
		return 0;

	do {
		if(!strcmp(opt, "domain"))
		{
			if (!(val = strtok(NULL, "\n"))) 
			{ 
				printf("domain empty\n");
				getDomainNameFromGUI = 0;
				retval = 1;
				break;
			}	
			printf("udhcpd domain = %s\n", val);
			getDomainNameFromGUI = 1;
		}
		else
			if (!(val = strtok(NULL, ", \t"))) \
				break;
			
		length = option_lengths[option->flags & TYPE_MASK];
		retval = 0;
		opt = buffer; /* new meaning for variable opt */
		switch (option->flags & TYPE_MASK) {
			case OPTION_IP:
				retval = read_ip(val, buffer);
				break;
			case OPTION_IP_PAIR:
				retval = read_ip(val, buffer);
				if (!(val = strtok(NULL, ", \t/-"))) retval = 0;
				if (retval) retval = read_ip(val, buffer + 4);
				break;
			case OPTION_STRING:
				length = strlen(val);
				if (length > 0) {
					if (length > 254) 
						length = 254;
					opt = val;
					retval = 1;
				}
				break;
			case OPTION_BOOLEAN:
				retval = read_yn(val, buffer);
				break;
			case OPTION_U8:
				buffer[0] = strtoul(val, &endptr, 0);
				retval = (endptr[0] == '\0');
				break;
			case OPTION_U16:
				*result_u16 = htons(strtoul(val, &endptr, 0));
				retval = (endptr[0] == '\0');
				break;
			case OPTION_S16:
				*result_u16 = htons(strtol(val, &endptr, 0));
				retval = (endptr[0] == '\0');
				break;
			case OPTION_U32:
				*result_u32 = htonl(strtoul(val, &endptr, 0));
				retval = (endptr[0] == '\0');
				break;
			case OPTION_S32:
				*result_u32 = htonl(strtol(val, &endptr, 0));
				retval = (endptr[0] == '\0');
				break;
			default:
				break;
		}
		if (retval)
			attach_option(opt_list, option, opt, length);
	} while (retval && option->flags & OPTION_LIST);
	return retval;
}

static int read_staticlease(const char *const_line, void *arg)
{

	char *line;
	char *mac_string;
	char *ip_string;
	uint8_t *mac_bytes;
	uint32_t *ip;


	/* Allocate memory for addresses */
	mac_bytes = xmalloc(sizeof(unsigned char) * 8);
	ip = xmalloc(sizeof(uint32_t));

	/* Read mac */
	line = (char *) const_line;
	mac_string = strtok(line, " \t");
	read_mac(mac_string, mac_bytes);

	/* Read ip */
	ip_string = strtok(NULL, " \t");
	read_ip(ip_string, ip);

	addStaticLease(arg, mac_bytes, ip);

#ifdef UDHCP_DEBUG
	printStaticLeases(arg);
#endif

	return 1;

}


static const struct config_keyword keywords[] = {
	/* keyword	handler   variable address		default */
	{"server", read_ip, &(server_config.server), "192.168.0.1"},
	{"start",	read_ip,  &(server_config.start),	"192.168.0.20"},
	{"end",		read_ip,  &(server_config.end),		"192.168.0.254"},
	{"interface",	read_str, &(server_config.interface),	"eth0"},
	{"option",	read_opt, &(server_config.options),	""},
	{"opt",		read_opt, &(server_config.options),	""},
	{"max_leases",	read_u32, &(server_config.max_leases),	"254"},
	{"remaining",	read_yn,  &(server_config.remaining),	"yes"},
	{"auto_time",	read_u32, &(server_config.auto_time),	"7200"},
	{"decline_time",read_u32, &(server_config.decline_time),"3600"},
	{"conflict_time",read_u32,&(server_config.conflict_time),"3600"},
	{"offer_time",	read_u32, &(server_config.offer_time),	"60"},
	{"min_lease",	read_u32, &(server_config.min_lease),	"60"},
	{"lease_file",	read_str, &(server_config.lease_file),	LEASES_FILE},
	{"pidfile",	read_str, &(server_config.pidfile),	"/var/run/udhcpd.pid"},
	{"notify_file", read_str, &(server_config.notify_file),	""},
	{"siaddr",	read_ip,  &(server_config.siaddr),	"0.0.0.0"},
	{"sname",	read_str, &(server_config.sname),	""},
	{"boot_file",	read_str, &(server_config.boot_file),	""},
	{"static_lease",read_staticlease, &(server_config.static_leases),	""},
#ifdef UDHCPD_ALWAYS_BROADCAST
	{"always_bcast",read_u32, &(always_bcast),		"0"},
#endif
	/*ADDME: static lease */
	{"",		NULL, 	  NULL,				""}
};
#ifdef UDHCPD_REVOKE
static const struct config_keyword revokes[] = {
	/* keyword	handler   variable address		default */
	{"ip",		read_ip,  &(dhcpd_revoke.ip),	""},
	{"mac",		read_mac, &(dhcpd_revoke.mac),	""},
	{"",		NULL, 	  NULL,				""}
};
#endif
int read_config(const char *file)
{
	FILE *in;
	char buffer[READ_CONFIG_BUF_SIZE], *token, *line;
#ifdef UDHCP_DEBUG
	char orig[READ_CONFIG_BUF_SIZE];
#endif
	int i, lm = 0;

	for (i = 0; keywords[i].keyword[0]; i++)
		if (keywords[i].def[0])
			keywords[i].handler(keywords[i].def, keywords[i].var);

	if (!(in = fopen(file, "r"))) {
		LOG(LOG_ERR, "unable to open config file: %s", file);
		return 0;
	}

	while (fgets(buffer, READ_CONFIG_BUF_SIZE, in)) {
		lm++;
		if (strchr(buffer, '\n')) 
			*(strchr(buffer, '\n')) = '\0';
#ifdef UDHCP_DEBUG
		strcpy(orig, buffer);
#endif
		if (strchr(buffer, '#')) 
			*(strchr(buffer, '#')) = '\0';

		if (!(token = strtok(buffer, " \t"))) continue;
		if (!(line = strtok(NULL, ""))) continue;

		/* eat leading whitespace */
		line = line + strspn(line, " \t=");
		/* eat trailing whitespace */
		for (i = strlen(line); i > 0 && isspace(line[i - 1]); i--);
		line[i] = '\0';

		for (i = 0; keywords[i].keyword[0]; i++)
			if (!strcasecmp(token, keywords[i].keyword))
				if (!keywords[i].handler(line, keywords[i].var)) 
				{
					LOG(LOG_ERR, "Failure parsing line %d of %s", lm, file);
					DEBUG(LOG_ERR, "unable to parse '%s'", orig);
					/* reset back to the default value */
					keywords[i].handler(keywords[i].def, keywords[i].var);
				}
	}
	fclose(in);
	return 1;
}

#ifdef UDHCPD_REVOKE
int read_revoke(const char *file)
{
	FILE *in;
	char buffer[READ_CONFIG_BUF_SIZE], *token, *line;
#ifdef UDHCP_DEBUG
	char orig[READ_CONFIG_BUF_SIZE];
#endif
	int i, lm = 0;

	for (i = 0; revokes[i].keyword[0]; i++)
		if (revokes[i].def[0])
			revokes[i].handler(revokes[i].def, revokes[i].var);

	if (!(in = fopen(file, "r"))) {
		LOG(LOG_ERR, "unable to open config file: %s", file);
		return 0;
	}

	while (fgets(buffer, READ_CONFIG_BUF_SIZE, in)) {
		lm++;
		if (strchr(buffer, '\n')) 
			*(strchr(buffer, '\n')) = '\0';
#ifdef UDHCP_DEBUG
		strcpy(orig, buffer);
#endif
		if (strchr(buffer, '#')) 
			*(strchr(buffer, '#')) = '\0';

		if (!(token = strtok(buffer, " \t"))) continue;
		if (!(line = strtok(NULL, ""))) continue;

		/* eat leading whitespace */
		line = line + strspn(line, " \t=");
		/* eat trailing whitespace */
		for (i = strlen(line); i > 0 && isspace(line[i - 1]); i--);
		line[i] = '\0';

		for (i = 0; revokes[i].keyword[0]; i++)
			if (!strcasecmp(token, revokes[i].keyword))
				if (!revokes[i].handler(line, revokes[i].var)) 
				{
					LOG(LOG_ERR, "Failure parsing line %d of %s", lm, file);
					DEBUG(LOG_ERR, "unable to parse '%s'", orig);
					/* reset back to the default value */
					revokes[i].handler(revokes[i].def, revokes[i].var);
				}
	}
	fclose(in);
	printf("revoke ip = %x, mac = %s\n", dhcpd_revoke.ip, dhcpd_revoke.mac);
	return 1;
}
#endif
void write_leases(void)
{
	FILE *fp, *fp1;
	unsigned int i;
	char buf[255];
	char file[255] = HTML_LEASES_FILE;
	time_t curr = time(0);
	unsigned long tmp_time;

	struct html_leases_s user_leases, curr_user_lease;
	struct in_addr addr;

	fp = fopen(server_config.lease_file, "w");
	if (fp == NULL) 
	{
		LOG(LOG_ERR, "Unable to open %s for writing", server_config.lease_file);
		return;
	}

	/* For http show dhcp client list (html.leases) */
	fp1 = fopen(file, "w");
	if (fp1 == NULL) 
	{
		LOG(LOG_ERR, "Unable to open %s for writing", file);
		return;
	}

	/* write to html.leases */
	for (i = 0; i < server_config.max_leases; i++) {
		if ( !lease_expired(&(leases[i])) && (leases[i].yiaddr != 0) )  {	

			memset(&user_leases, 0 , sizeof(struct html_leases_s));
			sprintf(user_leases.mac_addr,"%02x:%02x:%02x:%02x:%02x:%02x",leases[i].chaddr[0], leases[i].chaddr[1], leases[i].chaddr[2], leases[i].chaddr[3], leases[i].chaddr[4], leases[i].chaddr[5]);
//			LOG(LOG_DEBUG,"user_leases.mac_addr =%02x:%02x:%02x:%02x:%02x:%02x\n",leases[i].chaddr[0], leases[i].chaddr[1], leases[i].chaddr[2], leases[i].chaddr[3], leases[i].chaddr[4], leases[i].chaddr[5]);
			addr.s_addr = leases[i].yiaddr;
			sprintf(user_leases.ip_addr, "%s", inet_ntoa(addr));
//			LOG(LOG_DEBUG,"user_leases.yiaddr =%s\n", inet_ntoa(addr));
			//strcpy(user_leases.expires, ctime(&leases[i].expires));
			/*	Date: 2009-01-07
			*	Name: jimmy huang
			*	Reason:	to avoid compiler warning message
			*	Note: Modified the codes above
			*/
			strcpy(user_leases.expires, ctime((time_t *)&leases[i].expires));
			
			memset(user_leases.expires+strlen(user_leases.expires)-1, 0, (sizeof(user_leases.expires)-strlen(user_leases.expires)+1));
//			LOG(LOG_DEBUG,"user_leases.expires =%s\n", user_leases.expires);
			strcpy(user_leases.hostname, leases[i].hostname);
//			LOG(LOG_DEBUG,"user_leases.hostname =%s\n", user_leases.hostname);
			if(!feof(fp1))
			{	
				fread(&curr_user_lease, sizeof(struct html_leases_s), 1, fp1);
				if(strcmp(curr_user_lease.mac_addr, user_leases.mac_addr) != 0)
					fwrite(&user_leases, sizeof(struct html_leases_s), 1, fp1); 
			}
			else
			{
				fwrite(&user_leases, sizeof(struct html_leases_s), 1, fp1); 
			}
		}
	}
	
#if 1
	for (i = 0; i < server_config.max_leases; i++) {
		if (leases[i].yiaddr != 0) {

			/* screw with the time in the struct, for easier writing */
			tmp_time = leases[i].expires;

			if (server_config.remaining) {
				if (lease_expired(&(leases[i])))
					leases[i].expires = 0;
				else leases[i].expires -= curr;
			} /* else stick with the time we got */
			leases[i].expires = htonl(leases[i].expires);
			fwrite(&leases[i], sizeof(struct dhcpOfferedAddr), 1, fp);

			/* Then restore it when done. */
			leases[i].expires = tmp_time;
		}
	}
#endif
	fclose(fp1);
	fclose(fp);

	if (server_config.notify_file) {
		sprintf(buf, "%s %s", server_config.notify_file, server_config.lease_file);
		system(buf);
	}
}


void read_leases(const char *file)
{
	FILE *fp;
	unsigned int i = 0;
	struct dhcpOfferedAddr lease;
	uint8_t tmpHostName[MAX_HOSTNAME_LEN] = {0};
	fp = fopen(file, "r");
	if ( fp == NULL) 
	{
		LOG(LOG_ERR, "Unable to open %s for reading", file);
		return;
	}

	while (i < server_config.max_leases && (fread(&lease, sizeof(struct dhcpOfferedAddr), 1, fp) == 1)) {
		/* ADDME: is it a static lease */
		if (lease.yiaddr >= server_config.start && lease.yiaddr <= server_config.end) {
			lease.expires = ntohl(lease.expires);
			if (!server_config.remaining) 
				lease.expires -= time(0);
//			LOG(LOG_INFO, "111 lease.hostname = %d .", strlen(lease.hostname));				
			tmpHostName[0] = strlen(lease.hostname);
//			LOG(LOG_INFO, "111 lease.hostname = %s .", lease.hostname);
			memcpy(&tmpHostName[1], lease.hostname, tmpHostName[0]);
//			LOG(LOG_INFO, "222 lease.hostname = %d .", tmpHostName[0]); 
//			LOG(LOG_INFO, "222 lease.hostname = %s .", (tmpHostName+1)); 	
			if (!(add_lease(lease.chaddr, lease.yiaddr, lease.expires, tmpHostName/*lease.hostname*/))) {
				LOG(LOG_WARNING, "Too many leases while loading %s\n", file);
				break;
			}
			i++;
		}
	}
	DEBUG(LOG_INFO, "Read %d leases", i);
	fclose(fp);
}
