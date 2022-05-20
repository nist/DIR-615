#ifndef _SHVAR_H
#define _SHVAR_H

/* Include Project.h */
#include "project.h"

/* config file define */
#define DHCPD_CONF				"/var/etc/udhcpd.conf"			// rc/udhcp
#define IGMPPROXY				"/var/etc/igmpproxy.conf"		// rc/httpd/igmpproxy
#define SMTP_CONF				"/var/etc/smtp.conf"			// cgi/rc
#define RC_FLAG_FILE			"/var/etc/rc_flag.conf"			// httpd/ppp/rc/udhcp
#define L2TP_CONF				"/var/etc/l2tp.conf"			// cmds/rc
#define WLAN_EAP_CONFIG_FILE	"/etc/hostapd.conf"			
#define NVRAM_TMP_FILE 		"/var/tmp/nvram_tmp_data.txt"			

/* PID define */
#define RC_PID				"/var/run/rc.pid"
#define WCND_PID			"/var/run/wcnd.pid"
#define PPTP_PID			"/var/run/ppp-pptp.pid"
#define L2TP_PID			"/var/run/l2tp.pid"
#define UPNP_PID			"/var/run/upnpd.pid"
#define GPIO_PID			"/var/run/gpio.pid"
#define HTTPD_PID			"/var/run/httpd.pid"
#define NVRAM_UPGRADE_PID	"/var/run/nvram_upgrade.pid"
#define WANTIMER_PID		"/var/run/wan_timer.pid"
#define WAN_MONITOR_PID		"/var/run/monitor.pid"
#define UDHCPD_PID			"/var/run/udhcpd.pid"
#define IGMPPROXY_PID		"/var/run/igmpproxy.pid"
#define TIMER_PID			"/var/run/timer.pid"
#define TRACEGW_PID			"/var/run/tracegw.pid"
#define WPASUP_PID			"/var/run/wpa_supp.pid"
/*
* 	Date: 2009-1-19
* 	Name: Ken_Chiang
* 	Reason: modify for 3g usb client card to used.
* 	Notice :
*/	
#ifdef CONFIG_3G_USB_CLIENT	
#define USB_3G_PID			"/var/run/ppp0.pid"
#endif

#define INTERFACE_INFO		"/var/tmp/interface_info"		// rc/sutil
#define CLIENT_LIST_FILE	"/var/tmp/local_lan_ip"			// httpd/ip_lookup/timer
#define CLIENT_LIST_TMP_FILE	"/var/tmp/local_lan_ip_tmp"			// httpd/ip_lookup/timer
#define HTML_LEASES_FILE	"/var/misc/html.leases"			// rc/udhcp
#define LEASES_FILE			"/var/misc/udhcpd.leases"		// rc/udhcp
#define DHCPD_REVOKE_FILE	"/var/tmp/dhcp_revoke"			// httpd/udhcp

//#ifdef RADVD
#define RADVD_CONF_FILE		"/var/etc/radvd.conf"			// httpd/sutil/timer
#define LINK_LOCAL_INFO		"/var/etc/link_local_info"		// httpd/sutil
//#endif

#ifdef DHCPv6
#define DHCPD6_CONF_FILE	"/var/etc/dhcpd6.conf"			// rc/sutil
#define DHCPD6_LEASE_FILE	"/var/misc/dhcpd6.lease"		// rc/sutil
#endif

#ifdef MRD_ENABLE
#define	MRD_CONF_FILE		"/var/etc/mrd.conf"				// sutil
#endif

#define AP_RT_INFO			"/var/tmp/ap_rt_info"			// rc/sutil

#define PPP_OPTIONS 		"/var/etc/options"				// sutil
#define CHAP_SECRETS		"/var/etc/chap-secrets"			// cmds/rc
#define PAP_SECRETS			"/var/etc/pap-secrets"			// cmds/rc
#define L2TP_CONF_PATH		"/var/etc"				
/*
* 	Date: 2009-1-19
* 	Name: Ken_Chiang
* 	Reason: modify for 3g usb client card to used.
* 	Notice :
*/	
#ifdef CONFIG_3G_USB_CLIENT	
#define PPP_3G_IP_UP		   "/var/etc/ip-up"
#define PPP_3G_IP_DOWN		   "/var/etc/ip-down"
#define PPP_3G_CONNECT_CHAT	   "/var/etc/peers/3g-connect-chat"		
#define PPP_3G_DIAL			"/var/etc/ppp/peers/3g-dial"			
/*
* 	Date: 2009-1-20
* 	Name: jimmy huang
* 	Reason: for detect 3g usb device connect status
* 	Notice :
*/
#define PPP_3G_VID_PATH "/proc/sys/dev/usb/usbVendorID"
#define PPP_3G_PID_PATH "/proc/sys/dev/usb/usbProductID"
#endif
		
#define CHAP_REMOTE_NAME 	"CAMEO"							// cmds/rc/sutil
#ifdef MPPPOE
#define DNS_FILE_00			"/var/etc/resolve_00"			// httpd/rc/sutil
#define DNS_FILE_01			"/var/etc/resolve_01"			// httpd/rc/sutil
#define DNS_FILE_02			"/var/etc/resolve_02"			// httpd/rc/sutil
#define DNS_FILE_03			"/var/etc/resolve_03"			// httpd/rc/sutil
#define DNS_FILE_04			"/var/etc/resolve_04"			// httpd/rc/sutil
#endif

#define L2TP_PORT			1701							// rc/snort-2.8.2.2
#define PPTP_PORT			1723							// rc/accel-pptp-0.7.12/pptp

/* wpa supplicant */
#define WPASUP_CONFIG		"/var/etc/wpa.conf"				// rc/sutil
#define WPASUP_TLS_CONFIG	"/var/etc/tls.conf"				// ?????????? no one use it
#define WPASUP_TTLS_CONFIG	"/var/etc/ttls.conf"			// ?????????? no one use it
#define WPASUP_PEAP_CONFIG	"/var/etc/peap.conf"			// ?????????? no one use it

/* nvram tmp */
#define NVRAM_UPGRADE_TMP	"/var/tmp/nvram.tmp"			// httpd/nvram
#define NVRAM_CONFIG_TMP	"/var/tmp/nvram.bin"			// httpd/nvram

/* Wlan.c */
#define WLAN_DRIVER_PATH		"/lib/modules/2.4.25-LSDK-5.2.0.47/net/wlan.o"	// ?????????? no one use it
#define HOSTAPD_TMP_CONFIG_0	"/tmp/hostapd.conf.0.0"		// sutil
#define HOSTAPD_TMP_CONFIG_1	"/tmp/hostapd.conf.0.1"		// sutil
#define HOSTAPD_TMP_CONFIG_2	"/tmp/hostapd.conf.0.2"		// sutil
#define HOSTAPD_TMP_CONFIG_3	"/tmp/hostapd.conf.0.3"		// sutil

/*for smtp.c*/
#define LOG_FILE				"/var/log/FW_log"				// busybox-1.01/httpd/rc
#define LOG_FILE_HTTP			"/var/log/messages"				// busybox-1.00-pre10/busybox-1.01/httpd/mail_client/Mail-On-Schedule
#define LOG_FILE_FULL			"/var/log/messages_full"		// busybox-1.00-pre10/busybox-1.01/mail_client/Mail-On-Schedule
#define LOG_FILE_BAK			"/var/log/messages_bak"			// mail_client/
#define LOG_MAX_SIZE			20 /* KB */						// httpd/rc
#define STATUS_OF_EMAIL_LOG		"/var/tmp/status_of_email_log"
#define EMAIL_LOG_STATUS_INIT	2
#define EMAIL_LOG_SUCCESS		1
#define EMAIL_LOG_FAIL			0

#define IGMP_GROUP_FILE		"/var/tmp/igmp_group.conf"		// httpd
#define SNMPV3_CONF_FILE	"/var/etc/snmpd.conf"			// rc
#define SNMPV3_AUTH_FILE	"/var/net-snmp/snmpd.conf"		// rc
#define UPNP_CONF_FILE		"/var/etc/miniupnpd.conf"		// rc
#define RESOLVFILE			"/var/etc/resolv.conf"			// rc

/* For CONFIG_WAN_8021X */
#define EAP_CA_FILE		"/var/etc/ca.txt"
#define EAP_CLIENT_FILE		"/var/etc/ca_client.txt"
#define EAP_PKEY_FILE		"/var/etc/ca_pkey.txt"


#define DNS_QUERY_RESULT	"/var/tmp/dns_quesy_result"		// httpd/rc
#define DOMAIN_INFO			"/var/tmp/domain_info"			// rc
#define DOMAIN_RECORDS		"/var/tmp/domain_records"		// rc

#define FW_FILTER			"/var/tmp/fw_filter"			// rc
#define FW_NAT				"/var/tmp/fw_nat"				// rc
#define FW_MANGLE			"/var/tmp/fw_mangle"			// rc
#define LAN_BRIDGE_INFO		"/var/tmp/lanbrinfo"			// rc
#define HTTP_PORT			80								// rc
#define ISAKMP_PORT			500								// rc
#define SIP_PORT			5060							// rc
#define RTSP_PORT			554								// rc
#define IDENT_PORT			113								// rc
#define IP_MULTICAST		"224.0.0.0/4"					// rc
#define IP_FORWARD			"/proc/sys/net/ipv4/ip_forward"	// rc


#ifdef IPv6_SUPPORT
/*
* 	Date: 2009-05-26
* 	Name: jimmy huang
* 	Reason: for compile warning
*			/home/AthSDK/apps/sutil/shvar.h:155:1: warning: "IPV6_CLIENT_LIST" redefined
* 	Notice : 
*			1. First defined in apps/.config, for feature used
*			   Second defined here, for file used
*			2. if only use 
*				#ifndef IPV6_CLIENT_LIST
*					#define IPV6_CLIENT_LIST    "/var/tmp/ipv6_client_list"
*				#endif
*				will cause kernel 
*				"CPU 0 Unable to handle paging request at virtual address ..." then reboot
*			3. So by now, let it warning...
*				when compile apps, 
*				"/home/AthSDK/apps/sutil/shvar.h:155:1: warning: "IPV6_CLIENT_LIST" redefined"
*/
//#ifndef IPV6_CLIENT_LIST
#define IPV6_CLIENT_LIST	"/var/tmp/ipv6_client_list"		// timer
//#endif

#define IPV6_CLIENT_INFO	"/var/tmp/ipv6_client_info"		// timer/httpd
#define IPV6_CLIENT_RESULT	"/var/tmp/ipv6_client_result"	// httpd
#endif

#ifdef DHCPv6
//#define DHCPD6_PID_FILE		"/var/run/dhcpd6.pid"			// rc
//#define DHCLIENT6_SCRIPT	"/etc/dhc6.script"				// rc
//#define DHCLIENT6_NODNS_SCRIPT	"/etc/dhc6nodns.script"		// rc
//#define DHCLIENT6_LEASE_FILE	"/var/misc/dhc6.lease"		// rc
#define DHCP6C_CONF_FILE	"/var/etc/dhcp6c.conf"	// rc/wan.c
#define DHCP6C_SCRIPT_FILE	"/etc/dhcp6c-script"	// rc/wan.c	
#endif

#ifdef IPv6_SUPPORT
#define RESOLVFILE_IPV6			"/var/etc/resolv_ipv6.conf"		// httpd/rc 
#define RESOLVFILE_DUAL			"/var/etc/resolv_dual.conf"		// rc
#endif

/* For Russia Define */
#define RUSSIA_PHY_RESOLVFILE	"/var/tmp/russia_phy_dns.conf"	// rc

#define DHCPC_DNS_SCRIPT		"/usr/share/udhcpc/default.bound-dns"	// rc
#define DHCPC_NODNS_SCRIPT		"/usr/share/udhcpc/default.bound-nodns"	// rc

#define AVERAGE_BYTES		"/var/tmp/average_bytes"		// httpd/rc
#define LAN_TX_BYTES		"/var/tmp/lan_tx_bytes"			// httpd/rc
#define LAN_RX_BYTES		"/var/tmp/lan_rx_bytes"			// httpd/rc
#define WAN_TX_BYTES		"/var/tmp/wan_tx_bytes"			// httpd/rc
#define WAN_RX_BYTES		"/var/tmp/wan_rx_bytes"			// httpd/rc
#define WLAN_TX_BYTES		"/var/tmp/wlan_tx_bytes"		// httpd/rc
#define WLAN_RX_BYTES		"/var/tmp/wlan_rx_bytes"		// httpd/rc
#define TX_BYTES			"/var/tmp/tx_bytes"				// httpd
#define RX_BYTES			"/var/tmp/rx_bytes"				// httpd

#ifdef MPPPOE
#define MAX_PPPOE_CONNECTION	5							// httpd/rc
#define PPP_GATEWAY_IP		"/var/tmp/mpppoe_gw_ip"			// httpd/rc
#define PPP_WAN_IP			"/var/tmp/ppp_wan_ip"			// httpd/rc
#define MULTIPLE_ROUTING	"/var/tmp/multiple_routing"		// rc
#define DEL_MPPPOE_GW		"/var/tmp/del_mpppoe_gw"		// rc
#define DNS_FINAL_FILE		"/var/etc/dns_final"			// rc
#define DNS_MPPPOE			"/var/tmp/dns_mpppoe"			// rc
#define PPP_IDLE_00			"/var/tmp/ppp_idle_00"			// httpd/rc
#define PPP_IDLE_01			"/var/tmp/ppp_idle_01"			// httpd/rc
#define PPP_IDLE_02			"/var/tmp/ppp_idle_02"			// httpd/rc
#define PPP_IDLE_03			"/var/tmp/ppp_idle_03"			// httpd/rc
#define PPP_IDLE_04			"/var/tmp/ppp_idle_04"			// httpd/rc
#define PPP_START_IDLE_00	"/var/tmp/ppp_start_idle_00"	// rc
#define PPP_START_IDLE_01	"/var/tmp/ppp_start_idle_01"	// rc
#define PPP_START_IDLE_02	"/var/tmp/ppp_start_idle_02"	// rc	
#define PPP_START_IDLE_03	"/var/tmp/ppp_start_idle_03"	// rc
#define PPP_START_IDLE_04	"/var/tmp/ppp_start_idle_04"	// rc
#define PPP_RESET_00		"/var/tmp/ppp_reset_00"			// rc
#define PPP_RESET_01		"/var/tmp/ppp_reset_01"			// rc
#define PPP_RESET_02		"/var/tmp/ppp_reset_02"			// rc
#define PPP_RESET_03		"/var/tmp/ppp_reset_03"			// rc
#define PPP_RESET_04		"/var/tmp/ppp_reset_04"			// rc
#else
#define MAX_PPPOE_CONNECTION	1							// httpd/rc
#endif

/* For route */
#define ZEBRA_CONF			"/var/etc/zebra.conf"			// rc
#define RIPD_CONF			"/var/etc/ripd.conf"			// rc

#ifdef MPPPOE
#define ROUTING_INFO		"/var/etc/routing_info"			// rc		
#else
#define ROUTING_INFO		"/var/etc/routing.txt"			// rc
#endif

#define HOSTAPD_DUMP_FILE_0		"/tmp/hostapd.dump.0.0"		// rc
#define HOSTAPD_DUMP_FILE_1		"/tmp/hostapd.dump.0.1"		// rc
#define HOSTAPD_DUMP_FILE_2		"/tmp/hostapd.dump.0.2"		// rc
#define HOSTAPD_DUMP_FILE_3		"/tmp/hostapd.dump.0.3"		// rc

/* SSL Cer */
#define CA_CERTIFICATION		"/tmp/etc/cert/ca.cer"		// httpd
#define CLIENT_CERTIFICATION		"/tmp/etc/cert/client.cer"		// httpd
#define PRIVATE_KEY			"/tmp/etc/cert/pkey.pfx"			// httpd
#define CA_NVRAM_TAG			"ca"						// httpd	
#define CLIENT_NVRAM_TAG		"cl"						// httpd
#define PRIVATE_TAG			"pk"						// httpd

/* firmware upgrade */
#define FW_UPGRADE_FILE					"/var/firm/image.bin"
#define HWID_LEN						24
#define MAX_WISH_NUMBER					25		// rc

#ifdef CONFIG_FIREWALL_NUMBER
#define MAX_FIREWALL_RULE_NUMBER		CONFIG_FIREWALL_NUMBER
#else
#define MAX_FIREWALL_RULE_NUMBER		20		// rc
#endif

#ifdef CONFIG_APPLICATION_NUMBER
#define MAX_APPLICATION_RULE_NUMBER		CONFIG_APPLICATION_NUMBER	
#else
#define MAX_APPLICATION_RULE_NUMBER		20		// rc
#endif

#ifdef CONFIG_PORT_FORWARD_NUMBER
#define MAX_PORT_FORWARDING_NUMBER		CONFIG_PORT_FORWARD_NUMBER
#else
#define MAX_PORT_FORWARDING_NUMBER		20		// rc
#endif

#ifdef CONFIG_VIRTUAL_SERVER_NUMBER
#define MAX_VIRTUAL_SERVER_NUMBER		CONFIG_VIRTUAL_SERVER_NUMBER
#else
#define MAX_VIRTUAL_SERVER_NUMBER		20		// rc
#endif

#ifdef CONFIG_URL_FILTER_NUMBER
#define MAX_URL_FILTER_NUMBER			CONFIG_URL_FILTER_NUMBER
#else
#define MAX_URL_FILTER_NUMBER			20		// rc
#endif

#ifdef CONFIG_SCHEDULE_NUMBER
#define MAX_SCHEDULE_NUMBER				CONFIG_SCHEDULE_NUMBER
#else
#define MAX_SCHEDULE_NUMBER				10		// rc
#endif

#ifdef CONFIG_STATIC_ROUTE_NUMBER
#define MAX_STATIC_ROUTING_NUMBER		CONFIG_STATIC_ROUTE_NUMBER
#else
#define MAX_STATIC_ROUTING_NUMBER		20		// httpd/rc
#endif

#ifdef CONFIG_BLOCK_SERVICE_NUMBER
#define MAX_BLOCK_SERVICE_NUMBER		CONFIG_BLOCK_SERVICE_NUMBER
#else
#define MAX_BLOCK_SERVICE_NUMBER		10		// rc
#endif

#ifdef CONFIG_TRUST_IP_NUMBER
#define MAX_TRUST_IP_NUMBER				CONFIG_TRUST_IP_NUMBER
#else
#define MAX_TRUST_IP_NUMBER				20		// rc
#endif

#ifdef CONFIG_DHCPD_RESERVATION_NUMBER
#define MAX_DHCPD_RESERVATION_NUMBER	CONFIG_DHCPD_RESERVATION_NUMBER
#else
#define MAX_DHCPD_RESERVATION_NUMBER 	25		// httpd/rc
#endif

#ifdef CONFIG_MULTIPLE_ROUTING_NUMBER
#define MAX_MULTIPLE_ROUTING_NUMBER		CONFIG_MULTIPLE_ROUTING_NUMBER
#else
#define MAX_MULTIPLE_ROUTING_NUMBER		20		// rc
#endif

#ifdef CONFIG_QOS_NUMBER
#define MAX_QOS_NUMBER					CONFIG_QOS_NUMBER
#else
#define MAX_QOS_NUMBER					20		// rc
#endif

#ifdef CONFIG_INBOUND_FILTER_NUMBER
#define MAX_INBOUND_FILTER_NUMBER		CONFIG_INBOUND_FILTER_NUMBER
#else
#define MAX_INBOUND_FILTER_NUMBER		24		// rc
#endif

#ifdef CONFIG_ACCESS_CONTROL_NUMBER
#define MAX_ACCESS_CONTROL_NUMBER		CONFIG_ACCESS_CONTROL_NUMBER
#else
#define MAX_ACCESS_CONTROL_NUMBER		15		// rc
#endif

#ifdef CONFIG_SRC_MACHINE_NUMBER
#define MAX_SRC_MACHINE_NUMBER			CONFIG_SRC_MACHINE_NUMBER
#else
#define MAX_SRC_MACHINE_NUMBER			8		// rc
#endif

#ifdef CONFIG_IP_CONNTRACK_NUMBER
#define MAX_IP_CONNTRACK_NUMBER			CONFIG_IP_CONNTRACK_NUMBER
#else
#define MAX_IP_CONNTRACK_NUMBER			4096		// rc
#endif

/* Httpd server page Count Down Value */
#ifdef CONFIG_UPLOAD_TIME
#define UPLOAD_COUNT_DOWN				core_itoa(CONFIG_UPLOAD_TIME)
#else
#define UPLOAD_COUNT_DOWN				"120"	// httpd
#endif

#ifdef CONFIG_REBOOT_TIME
#define REBOOT_COUNT_DOWN				core_itoa(CONFIG_REBOOT_TIME)
#else
#define REBOOT_COUNT_DOWN				"60"	// httpd
#endif

#ifdef CONFIG_RESTORE_TIME
#define RESTORE_COUNT_DOWN				core_itoa(CONFIG_RESTORE_TIME)
#else
#define RESTORE_COUNT_DOWN				"70"	// httpd
#endif

#ifdef CONFIG_RESTORE_WIRELESS_TIME
#define RESTORE_WIRELESS_COUNT_DOWN		core_itoa(CONFIG_RESTORE_WIRELESS_TIME)
#else
#define RESTORE_WIRELESS_COUNT_DOWN		"30"	// httpd
#endif

#ifdef CONFIG_RESET_TIME
#define RESET_COUNT_DOWN				core_itoa(CONFIG_RESET_TIME)
#else
#define RESET_COUNT_DOWN				"3"		// httpd
#endif

#ifdef CONFIG_UPLOAD_CERTIFICATION_TIME
#define UPLOAD_CERTIFICATION_COUNT_DOWN		core_itoa(CONFIG_UPLOAD_CERTIFICATION_TIME)
#else
#define UPLOAD_CERTIFICATION_COUNT_DOWN		"3"		// httpd
#endif

#ifdef CONFIG_LAN_IP_CHANGE_REBOOT_TIME
#define LANIP_CHANGED_REBOOT_COUNT_DOWN		core_itoa(CONFIG_LAN_IP_CHANGE_REBOOT_TIME)
#else
#define LANIP_CHANGED_REBOOT_COUNT_DOWN		"60"	
#endif

#ifdef CONFIG_SUPER_G_REBOOT_TIME
#define SUPERG_DOMAIN_CHANGED_REBOOT_COUNT_DOWN	core_itoa(CONFIG_SUPER_G_REBOOT_TIME)
#else
#define SUPERG_DOMAIN_CHANGED_REBOOT_COUNT_DOWN "70"	//	httpd
#endif

#ifdef CONFIG_UPGRADE_TIME
#define UPGRADE_COUNT_DOWN				core_itoa(CONFIG_UPGRADE_TIME)
#else
#define UPGRADE_COUNT_DOWN				"140"	// httpd
#endif

#ifdef CONFIG_MAC_FILTER_NUMBER
#define MAX_MAC_FILTER_NUMBER			CONFIG_MAC_FILTER_NUMBER
#else
#define MAX_MAC_FILTER_NUMBER			20		// rc/udhcp
#endif

#endif //#ifndef _SHVAR_H


