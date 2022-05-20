#ifndef _SUTIL_H
#define _SUTIL_H

//#include "project.h"

extern int _system(const char *fmt, ...);
extern int read_pid(char *file);
extern int init_file(char *file);
extern void save2file(const char *file, const char *fmt, ...);
extern char *replace(char *input, const char target, const char rechar );
extern int get_blk_region(char* region);
extern int get_blk_domain(char* domain);
extern int get_blk_hwver(char* hwver);
extern int get_blk_mac(char* mac);
extern int write_macblock(char* mac, char* hwver, char* domain, char* region);
extern int init_macblock(void);
/* 
 	Date: 2009-3-5 
 	Name: Ken_Chiang
 	Reason: modify for show chanel list used the space gap.
 	Notice :
*/ 
/*
extern int GetDomainChannelList(unsigned short number, int band, char wlan_channel_list[]);
*/
/* 
 	Date: 2009-3-5 
 	Name: Cosmo Chang
 	Reason: recover code modified by somebody 	
*/ 
/*
extern int GetDomainChannelList(unsigned short number, int band, char wlan_channel_list[], int show_used_space);
*/
#ifdef CONFIG_WL_ATH
extern int GetDomainChannelList(unsigned short number, int band, char wlan_channel_list[], int show_used_space);
#endif
#ifdef CONFIG_WL_RTL
int GetDomainChannelList(unsigned short number, int band, char wlan_channel_list[]);
#endif

extern char *time_format_for_log(void);
extern int wan_connected_cofirm(char *if_name);
extern int check_ip_match(const char *target, const char *model);
extern char *parse_special_char(char *p_string);
extern int getStrtok(char *input, char *token, char *fmt, ...);
extern void flash_get_checksum(void);
extern void string_insert(char *st, char insert[], int start);
extern char *ssid_transfer(char *wlan_ssid);
extern void generate_pin_by_mac(char *wps_pin);

/* IPv6 scope*/
#ifdef IPv6_SUPPORT
#define SCOPE_LOCAL     0
#define SCOPE_GLOBAL    1

#define MAX_IPV6_IP_LEN	45
#endif

//#ifdef RADVD
void write_radvd_conf(void);
void write_radvd_conf_cmd(void);
char *get_link_local_ip_l(char *interface_name);
//#endif

char *get_ipv6_prefix (char *ipv6_addr, int length);

#ifdef DHCPv6
void write_dhcpd6_conf (void);
#endif

void modify_ppp_options(void);
char* return_ap_rt_info(void);
struct mp_info check_mpppoe_info(int pppoe_unit);

struct mp_info {
	int pid;
	char pppoe_iface[5];
};

struct IpRange{
	char addr[38];
}; 

struct OtherMachineInfo{
	char filter[14];
	char log[4];
	char schedule[64];
	int index;
}; 

#define foreach(word, wordlist, next, match) \
	for (next = &wordlist[strspn(wordlist, match)], \
			strncpy(word, next, sizeof(word)), \
			word[strcspn(word, match)] = '\0', \
			word[sizeof(word) - 1] = '\0', \
			next = strstr(next, match); \
			strlen(word); \
			next = next ? &next[strspn(next, match)] : "", \
			strncpy(word, next, sizeof(word)), \
			word[strcspn(word, match)] = '\0', \
			word[sizeof(word) - 1] = '\0', \
			next = strstr(next, match))

#define sin_addr(s) (((struct sockaddr_in *)(s))->sin_addr)
#define run_rc_action(action) write_rc_action(action);kill(read_pid(RC_PID), SIGHUP)

#define cprintf(fmt, args...) do { \
	FILE *cfp = fopen("/dev/console", "w"); \
	if (cfp) { \
		fprintf(cfp, fmt, ## args); \
		fclose(cfp); \
	} \
} while (0)

/* Mac Block Struct */
typedef struct block_data {
	int init_flag;
	char mac[20];
	char hwver[4];
	char domain[4];
	char region[4];
};

/************************** Channel Parameter move to project.h in WWW model**************************/
//struct channel_list_s {
//};

//struct freq_table_s {
//};

//static struct freq_table_s wireless2_table[] = {
//};

//struct domain_name_s {
//};

//static struct domain_name_s  domain_name[] = {
//};

//struct country_name_s {
//};

//static struct country_name_s  country_name[] = {
//};

//struct region_s{
//};

//static struct region_s region[] = {
//};

/************************** Channel Parameter **************************/

#endif //#ifndef _SUTIL_H
