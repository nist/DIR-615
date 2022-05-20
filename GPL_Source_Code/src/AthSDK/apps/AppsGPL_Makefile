include .config

export TARGET := $(FS_PATH)
export KERNEL_DIR := $(KERNEL_PATH)
export TOP := $(APPS_PATH)
export CFLAGS := $(APPS_CFLAG)

export CONFIG_MODEL_NAME := $(CONFIG_MODEL_NAME)
export CONFIG_HTTPD_PURE := $(CONFIG_HTTPD_PURE)
export CONFIG_XML_AGENT := $(CONFIG_XML_AGENT)
export CONFIG_AJAX := $(CONFIG_AJAX)
export IPROUTE2_IP := $(IPROUTE2_IP)
export CONFIG_TC := $(CONFIG_TC)
export CROSS_COMPILE = $(APPS_CROSS)
export CC := $(CROSS_COMPILE)gcc
export CXX := $(CROSS_COMPILE)g++
export AR := $(CROSS_COMPILE)ar
export AS := $(CROSS_COMPILE)as
export LD := $(CROSS_COMPILE)ld
export NM := $(CROSS_COMPILE)nm
export RANLIB := $(CROSS_COMPILE)ranlib
export STRIP := $(CROSS_COMPILE)strip
export SIZE := $(CROSS_COMPILE)size
export CONFIG_AUTHGRAPH := $(CONFIG_AUTHGRAPH)
export CONFIG_HTTPS := $(CONFIG_HTTPS)
export CONFIG_PPP_USED_CHAT := $(CONFIG_PPP_USED_CHAT)


# radvd support
ifeq ($(CONFIG_RADVD),y)
obj-$(CONFIG_RADVD) += flex radvd
endif

#wpa supplicant for Atheros solution
ifeq ($(CONFIG_SUPPLICANT_ATH),y)
obj-$(CONFIG_SUPPLICANT_ATH) += wpa/wpa_supplicant-0.5.5
endif

#wan 8021x support
ifeq ($(CONFIG_WAN_8021X),y)
	CFLAGS += -DCONFIG_WAN_8021X
endif

ifneq ($(PLATFORM),AthSDK_AP61)
obj-$(CONFIG_BUSYBOX) += busybox-1.01
else
obj-$(CONFIG_BUSYBOX) += busybox-1.00-pre10
endif

# Application
obj-$(CONFIG_OPENSSL) += openssl
obj-$(CONFIG_HTTPD) += httpd
obj-$(CONFIG_DNSMASQ) += dnsmasq-2.41
ifeq ($(CONFIG_OPENDNS),y)
CFLAGS += -DOPENDNS
endif

ifeq ($(CONFIG_DDNS_ORAY),y)
	CFLAGS += -DDDNS_ORAY_ENABLE
else
obj-$(CONFIG_DDNS) += noip2
endif

ifeq ($(CONFIG_HEARTBEAT),y)
CFLAGS += -DCONFIG_HEARTBEAT
endif

ifeq ($(CONFIG_LCM_FEATURE_INFOD),y)
CFLAGS += -DLCM_FEATURE_INFOD
endif

ifeq ($(PLATFORM), AthSDK_AP61)
obj-$(CONFIG_IPTABLES) += iptables
else
ifeq ($(PLATFORM), MV88F6281) 
# it is better to use iptabels-1.4.3.2
obj-$(CONFIG_IPTABLES) += iptables-1.3.8
else
obj-$(CONFIG_IPTABLES) += iptables_2_6
endif
endif

ifeq ($(CONFIG_DHCP_RELAY),y)
	obj-$(CONFIG_DHCP_RELAY) += dhcp-forwarder-0.7
	CFLAGS +=-DDHCP_RELAY
endif

obj-$(CONFIG_UDHCP) += udhcp
#obj-$(CONFIG_IPV6_DHCP) += dhcpv6
obj-$(CONFIG_IPV6_DHCP) += wide-dhcpv6
ifeq ($(PLATFORM), sl3516)
obj-$(CONFIG_PPPD) += ppp-2.4.4
else
obj-$(CONFIG_PPPD) += ppp
endif

obj-$(CONFIG_RP_PPPoE) += rp-pppoe
# 	Date: 2009-7-14
# 	Name: Ken_Chiang
# 	Reason: modify for support pppoe relay feature.
# 	Notice :
ifeq ($(CONFIG_PPPOE_RELAY),y)
	CFLAGS +=-DPPPOE_RELAY
endif
obj-$(CONFIG_NTP)   += ntpclient
obj-$(CONFIG_MFORWARD)	+= igmpproxy
obj-$(CONFIG_BIGPOND) += bpalogin
obj-$(CONFIG_PPTP_CLIENT) += accel-pptp-0.7.12
obj-$(CONFIG_PPTP_CLIENT_V082) += accel-pptp-0.8.2
ifeq ($(CONFIG_OPENAGENT),y)
	obj-$(CONFIG_OPENAGENT) += openssl openagent-2.0
	CFLAGS += -DCONFIG_OPENAGENT
endif

obj-$(CONFIG_ZLIB)		+= zlib
ifeq ($(CONFIG_DROPBEAR),y)
	obj-$(CONFIG_DROPBEAR) += zlib dropbear
	CFLAGS += -DCONFIG_DROPBEAR
endif

ifeq ($(CONFIG_IPV6_LLMNR),y)
	obj-$(CONFIG_IPV6_LLMNR) += llmnr
	CFLAGS += -DCONFIG_IPV6_LLMNR
endif


obj-$(CONFIG_PCIUTILS)		+= pciutils
obj-$(CONFIG_L2TP_CLIENT) += rp-l2tp
obj-$(CONFIG_LLD2D) += lld2d
obj-$(CONFIG_SNMP) += snmp
obj-$(CONFIG_ZEBRA) += zebra
obj-$(CONFIG_WPASUPPLICANT) += wpa_supplicant
obj-$(CONFIG_SMTP) += mail_client
obj-$(CONFIG_NMBD) += nmbd
obj-$(CONFIG_MRD) += mrd
obj-$(CONFIG_IP) += iproute2
obj-$(CONFIG_UUID) += uuid

ifeq ($(CONFIG_WPS),y)
ifeq ($(CONFIG_WPS_WPATALK), y)
CFLAGS += -DWPS_WPATALK
endif
endif


ifeq ($(CONFIG_WAKE_ON_LAN),y)
obj-$(CONFIG_WAKE_ON_LAN) += wake-on-lan-proxy
CFLAGS += -DWAKE_ON_LAN
endif

ifeq ($(CONFIG_MIREDO),y)
obj-$(CONFIG_MIREDO) += miredo
export MIREDO_CC := $(CROSS_COMPILE)gcc -std=gnu99
endif


ifeq ($(CONFIG_CROWDCONTROL),y)
obj-$(CONFIG_CROWDCONTROL) += crowdcontrol
CFLAGS += -DHTTP_FILTER_PROXY
endif

# Tools
obj-$(CONFIG_BRCTL) += bridge-utils
obj-$(CONFIG_VLAN) += vlan

ifeq ($(CONFIG_IP_MATCH_3),y)
CFLAGS += -DIP_MATCH_3
endif

ifeq ($(CONFIG_IP_MATCH_4),y)
CFLAGS += -DIP_MATCH_4
endif

# Atheros support MAC filter or not
ifeq ($(CONFIG_WL_ATH_MAC_FILTER),y)
CFLAGS += -DATH_MAC_FILTER
endif

# Only support WLAN MAC Address filter  
ifeq ($(CONFIG_ONLY_FILTER_WLAN_MAC),y)
CFLAGS += -DONLY_FILTER_WLAN_MAC
endif

# Atheros support 5GHz or not
ifeq ($(CONFIG_WL_ATH_5GHZ),y)
CFLAGS += -DATH_5GHZ
endif

# Atheros support Guest Zone or not
ifeq ($(CONFIG_WL_ATH_GUEST_ZONE),y)
CFLAGS += -DATH_GUEST_ZONE
endif

# Atheros support WDS AP or not
ifeq ($(CONFIG_WL_ATH_WDS_AP),y)
CFLAGS += -DATH_WDS_AP
endif

# Atheros support WDS BR or not
ifeq ($(CONFIG_WL_ATH_WDS_BR),y)
CFLAGS += -DATH_WDS_BR
endif

# Atheros support WDS RPT or not
ifeq ($(CONFIG_WL_ATH_WDS_RPT),y)
CFLAGS += -DATH_WDS_RPT
endif

# Wireless SSID Support HEX mode in NVRAM or not
ifeq ($(CONFIG_HEX_MODE_WITH_WIRELESS),y)
CFLAGS += -DSSID_HEX_MODE
endif

# Support MRD or not
ifeq ($(CONFIG_MRD),y)
        CFLAGS +=-DMRD_ENABLE
endif

# Support Pure network or not
ifeq ($(CONFIG_HTTPD_PURE),y)
	CFLAGS += -DPURE_NETWORK_ENABLE
endif

ifeq ($(CONFIG_UUID),y)
	CFLAGS += -DUUID
endif

ifeq ($(HTTPD_DENY_USERID),y)
	CFLAGS += -DHTTPD_DENY_USERID
endif

ifeq ($(HTTPD_USED_SP_ADMINID),y)
	CFLAGS += -DHTTPD_USED_SP_ADMINID
endif

ifeq ($(HTTPD_USED_MUTIL_AUTH),y)
	CFLAGS += -DHTTPD_USED_MUTIL_AUTH
endif

ifeq ($(HTTPD_LOGOUT_ADMIN_CHANGED),y)
	CFLAGS += -DHTTPD_LOGOUT_ADMIN_CHANGED
endif

# Support OWERA or not
ifeq ($(CONFIG_OWERA),y)
	CFLAGS +=-DCONFIG_OWERA
endif

# Support Multiple PPPOE or not
ifeq ($(CONFIG_MULTIPLE_PPPoE),y)
	CFLAGS +=-DMPPPOE
endif

# Support Russia PPPOE or not
ifeq ($(CONFIG_RUSSIA_PPPoE),y)
	CFLAGS +=-DRPPPOE
endif

# Support NAT or not
ifeq ($(CONFIG_NAT_ENABLE),y)
	CFLAGS +=-DNAT_ENABLE
endif

# Support SPI or not
ifeq ($(CONFIG_SPI),y)
	CFLAGS +=-DSPI
endif

# Support Access Control or not
ifeq ($(CONFIG_ACCESS_CONTROL),y)
	CFLAGS +=-DACCESS_CONTROL
endif

# Support Port Forward Both or not
ifeq ($(CONFIG_PORT_FORWARD_BOTH),y)
	CFLAGS +=-DPORT_FORWARD_BOTH
endif

ifeq ($(CONFIG_PORT_FORWARD_TO_LOG),y)
	CFLAGS +=-DPORT_FORWARD_TO_LOG
endif

# Support Inbound Filter or not
ifeq ($(CONFIG_INBOUND_FILTER),y)
	CFLAGS +=-DINBOUND_FILTER
endif

# Support netbios for udhcpd or not
ifeq ($(CONFIG_UDHCPD_NETBIOS),y)
        CFLAGS +=-DUDHCPD_NETBIOS
endif

# Support unicast for udhcpc or not
ifeq ($(CONFIG_UDHCPC_UNICAST),y)
        CFLAGS +=-DUDHCPC_UNICAST
endif

# Support Static Route option (33) for udhcpc or not
ifeq ($(CONFIG_UDHCPC_STATIC_ROUTE),y)
	CFLAGS += -DUDHCPC_STATIC_ROUTE
endif

# Support ip look up in status page
ifeq ($(CONFIG_IP_LOOKUP),y)
	CFLAGS += -DCONFIG_IP_LOOKUP
endif

ifeq ($(CLASSLESS_STATIC_ROUTE_SHOW_UI),y)
	CFLAGS += -DCLASSLESS_STATIC_ROUTE_SHOW_UI
endif

ifeq ($(CONFIG_WIRELESS_SCHEDULE),y)
	CFLAGS += -DCONFIG_WIRELESS_SCHEDULE
endif

# Support classess static route for udhcpc or not
ifeq ($(CONFIG_UDHCPC_CLASSLESS_STATIC_ROUTE),y)
	ifeq ($(CONFIG_RFC_UDHCPC_CLASSLESS_STATIC_ROUTE),y)
		CFLAGS +=-DUDHCPC_RFC_CLASSLESS_STATIC_ROUTE
	else
		CFLAGS +=-DUDHCPC_MS_CLASSLESS_STATIC_ROUTE
	endif
endif

ifeq ($(CONFIG_AUTO_MODE_SELECT),y)
	CFLAGS += -DAUTO_MODE_SELECT
endif

# Support revoke for udhcpd or not
ifeq ($(CONFIG_UDHCPD_REVOKE),y)
        CFLAGS +=-DUDHCPD_REVOKE
endif

# Check udhcpd reservation table setting by GUI or not
ifeq ($(CONFIG_UDHCPD_CHECK_RESERV_BY_GUI),y)
	CFLAGS +=-DDHCPD_CHECK_RESERV_BY_GUI
endif

# Support always broadcast for udhcpd or not
ifeq ($(CONFIG_UDHCPD_ALWAYS_BROADCAST),y)
        CFLAGS +=-DUDHCPD_ALWAYS_BROADCAST
endif

# Support timer interval for ddns or not
ifeq ($(CONFIG_DDNS_TIME_INTERVAL),y)
        CFLAGS +=-DDDNS_TIME_INTERVAL
endif

# Support reservate wireless domain or not
ifeq ($(CONFIG_RESERVATE_WIRELESS_DOMAIN),y)
        CFLAGS +=-DRESERVATE_WIRELESS_DOMAIN
endif

# Support radvd or not
ifeq ($(CONFIG_RADVD),y)
	CFLAGS +=-DRADVD
endif

#Support nmbd or not
ifeq ($(CONFIG_NMBD),y)
	CFLAGS +=-DCONFIG_NMBD
endif

#Support SNMP or not
ifeq ($(CONFIG_SNMP),y)
	CFLAGS +=-DCONFIG_SNMP
endif

#Support SNMP trap or not
ifeq ($(CONFIG_SNMP_TRAP),y)
	CFLAGS +=-DCONFIG_SNMP_TRAP
endif

#Support WCN or not
ifeq ($(CONFIG_WCN),y)
	CFLAGS +=-DCONFIG_WCN
endif

#Support ZEBRA or not
ifeq ($(CONFIG_ZEBRA),y)
	CFLAGS +=-DCONFIG_ZEBRA
endif

# Support IPv6 or not
ifeq ($(CONFIG_IPV6_SUPPORT),y)
	CFLAGS +=-DIPv6_SUPPORT
endif

# Support static IPv6 or not
ifeq ($(CONFIG_IPV6_STATIC),y)
	CFLAGS +=-DIPv6_STATIC
endif

# Support DHCPv6 or not
ifeq ($(CONFIG_IPV6_DHCP),y)
        CFLAGS +=-DDHCPv6
endif

# Support IPv6 tunnel or not
ifeq ($(CONFIG_IPV6_TUNNEL),y)
        CFLAGS +=-DIPV6_TUNNEL
endif

# Support 6to4 tunnel or not
ifeq ($(CONFIG_6TO4_TUNNEL),y)
	CFLAGS +=-DSIX_TO4_TUNNEL
endif

# Support 6in4 tunnel or not
ifeq ($(CONFIG_6IN4_TUNNEL),y)
        CFLAGS +=-DSIX_IN4_TUNNEL
endif

# Support stateless autoconfiguration on WAN interface
ifeq ($(CONFIG_STATELESS_WAN),y)
        CFLAGS +=-DIPV6_STATELESS_WAN
endif

# Support monitor ipv6 clients in LAN side
ifeq ($(CONFIG_IPV6_CLIENT_LIST),y)
	CFLAGS +=-DIPV6_CLIENT_LIST
endif

# Support IPv6 test function for CHT or not
ifeq ($(CONFIG_IPv6_TEST_FUNCTION),y)
        CFLAGS +=-DIPv6_TEST
endif

# Support QoS or not
ifeq ($(CONFIG_QOS),y)
	CFLAGS +=-DQOS
endif

#Support WISH or not
ifeq ($(CONFIG_WISH),y)
	CFLAGS +=-DCONFIG_WISH
endif

#Support DLINK_ROUTER_LED_DEFINE or not
ifeq ($(CONFIG_DLINK_ROUTER_LED_DEFINE),y)
	CFLAGS +=-DDLINK_ROUTER_LED_DEFINE
endif

#Support DLINK_FW_QUERY or not
ifeq ($(CONFIG_DLINK_FW_QUERY),y)
	CFLAGS +=-DDLINK_FW_QUERY
endif

#Support CHECKSUM or not
ifeq ($(CONFIG_SHOW_CHECKSUM),y)
	CFLAGS +=-DCONFIG_SHOW_CHECKSUM
endif

# Support different wireless solution for HTTPD
ifeq ($(CONFIG_WL_ATH),y)
        CFLAGS +=-DCONFIG_WL_ATH
endif
ifeq ($(CONFIG_WL_BCM),y)
        CFLAGS +=-DCONFIG_WL_BCM
endif
ifeq ($(CONFIG_WL_MVL),y)
        CFLAGS +=-DCONFIG_WL_MVL
endif

# support 802.11n or not
ifeq ($(CONFIG_WL_ATH_WITH_N),y)
	CFLAGS +=-DAR9100
endif

# support miniupnpd or not
ifeq ($(CONFIG_UPNP_ATH_MINIUPNPD_RC),y)
	CFLAGS +=-DUPNP_ATH_MINIUPNPD_RC
endif

ifeq ($(CONFIG_UPNP_ATH_LIBUPNP),y)
	CFLAGS +=-DUPNP_ATH_LIBUPNP
	ifeq ($(CONFIG_UPNP_ATH_LIBUPNP_SAVE2FILE),y)
		CFLAGS +=-DUPNP_PORTMAPPING_SAVE
		endif
	ifeq ($(CONFIG_UPNP_ATH_LIBUPNP_CHECK_NVRAM),y)
		CFLAGS +=-DUPNP_PORTMAPPING_CHECK_NVRAM
	endif
endif

ifeq ($(CONFIG_WPS_PIN_GENERATE),y)
	CFLAGS +=-DWPS_PIN_GENERATE
endif

ifeq ($(CONFIG_UPNP_ATH_MINIUPNPD_1_3),y)
	CFLAGS +=-DUPNP_ATH_MINIUPNPD_1_3
	ifeq ($(CONFIG_UPNP_ATH_MINIUPNPD_1_3_LEASE_FILES),y)
		CFLAGS +=-DUPNP_ATH_MINIUPNPD_1_3_LEASE_FILES
	endif
	ifeq ($(CONFIG_UPNP_ATH_MINIUPNPD_1_3_CHECK_VS_NVRAM),y)
		CFLAGS += -DUPNP_CHECK_VS_NVRAM
	endif
	#	Date:	2009-07-08
	#	Name:	jimmy huang
	#	Reason:	for miniupnpd-1.3 hairpin feature used
	#	Note:	for rc, httpd to read this definitions
	#			miniupnpd-1.3 use his own Makefile to read the definition
	# 
	ifeq ($(CONFIG_UPNP_ATH_MINIUPNPD_1_3_HAIRPIN),y)
		CFLAGS += -DUPNP_ATH_MINIUPNPD_1_3_HAIRPIN
	endif
endif

# support httpd time out to login page 
ifeq ($(CONFIG_HTTP_TIMEOUT),y)
	CFLAGS +=-DHTTP_TIMEOUT
endif

# support login fail alert message 
ifeq ($(CONFIG_LOGIN_ALERT),y)
	CFLAGS +=-DGUI_LOGIN_ALERT
endif

# support get/set hwversion,lanmac,wanmac for ART mtdblock 
ifeq ($(CONFIG_GET_SET_ARTBLOCK),y)
	CFLAGS +=-DSET_GET_FROM_ARTBLOCK
endif

# support get/set hwversion,lanmac,wanmac for MAC mtdblock
ifeq ($(CONFIG_GET_SET_MACBLOCK),y)
        CFLAGS +=-DSET_GET_FROM_MACBLOCK
endif

# support chklist show hwversion 
ifeq ($(CONFIG_SHOW_HW_VERSION),y)
	CFLAGS +=-DSHOW_HW_VERSION
endif

# support igmp privacy mulit-cast ip address
ifeq ($(CONFIG_SUPPORT_PRIVACY_ADDRESS),y)
	CFLAGS +=-DCONFIG_SUPPORT_PRIVACY_ADDRESS
endif

ifeq ($(CONFIG_3G_USB_CLIENT),y)
	CFLAGS +=-DCONFIG_3G_USB_CLIENT
endif

ifeq ($(CONFIG_KCODES),y)
	CFLAGS += -DUSE_KCODES
else
	ifeq ($(CONFIG_SILEX),y)
		CFLAGS += -DUSE_SILEX
	endif	
endif

ifeq ($(CONFIG_SUPPORT_BIND),y)
	CFLAGS += -DSUPPORT_BIND
endif

ifneq ($(CONFIG_IP_CONNTRACK_NUMBER),) 
	CFLAGS += -DCONFIG_IP_CONNTRACK_NUMBER=$(CONFIG_IP_CONNTRACK_NUMBER)
endif


ifeq ($(CONFIG_DFS_NOT_SUPPORT), y)
	CFLAGS +=-DDFS_NOT_SUPPORT
endif

#   Date: 2009-6-26
#   Name: Albert Chen
ifneq ($(CONFIG_NVRAM_BLK),) 
	CFLAGS += -DCONFIG_NVRAM_BLK=$(CONFIG_NVRAM_BLK)
endif

CFLAGS +=-DCONFIG_NVRAM_SIZE=$(CONFIG_NVRAM_SIZE) -DCONFIG_FIREWALL_NUMBER=$(CONFIG_FIREWALL_NUMBER) \
	-DCONFIG_MAC_FILTER_NUMBER=$(CONFIG_MAC_FILTER_NUMBER) -DCONFIG_APPLICATION_NUMBER=$(CONFIG_APPLICATION_NUMBER) \
	-DCONFIG_PORT_FORWARD_NUMBER=$(CONFIG_PORT_FORWARD_NUMBER) -DCONFIG_VIRTUAL_SERVER_NUMBER=$(CONFIG_VIRTUAL_SERVER_NUMBER) \
	-DCONFIG_URL_FILTER_NUMBER=$(CONFIG_URL_FILTER_NUMBER) -DCONFIG_SCHEDULE_NUMBER=$(CONFIG_SCHEDULE_NUMBER) \
	-DCONFIG_STATIC_ROUTE_NUMBER=$(CONFIG_STATIC_ROUTE_NUMBER) -DCONFIG_BLOCK_SERVICE_NUMBER=$(CONFIG_BLOCK_SERVICE_NUMBER) \
	-DCONFIG_TRUST_IP_NUMBER=$(CONFIG_TRUST_IP_NUMBER) -DCONFIG_DHCPD_RESERVATION_NUMBER=$(CONFIG_DHCPD_RESERVATION_NUMBER) \
	-DCONFIG_MULTIPLE_ROUTING_NUMBER=$(CONFIG_MULTIPLE_ROUTING_NUMBER) -DCONFIG_QOS_NUMBER=$(CONFIG_QOS_NUMBER) \
	-DCONFIG_INBOUND_FILTER_NUMBER=$(CONFIG_INBOUND_FILTER_NUMBER) -DCONFIG_ACCESS_CONTROL_NUMBER=$(CONFIG_ACCESS_CONTROL_NUMBER) \
	-DCONFIG_SRC_MACHINE_NUMBER=$(CONFIG_SRC_MACHINE_NUMBER) \
	-DCONFIG_UPLOAD_TIME=$(CONFIG_UPLOAD_TIME) -DCONFIG_REBOOT_TIME=$(CONFIG_REBOOT_TIME) -DCONFIG_RESTORE_TIME=$(CONFIG_RESTORE_TIME) \
	-DCONFIG_RESTORE_WIRELESS_TIME=$(CONFIG_RESTORE_WIRELESS_TIME) -DCONFIG_RESET_TIME=$(CONFIG_RESET_TIME) \
	-DCONFIG_UPLOAD_CERTIFICATION_TIME=$(CONFIG_UPLOAD_CERTIFICATION_TIME) -DCONFIG_LAN_IP_CHANGE_REBOOT_TIME=$(CONFIG_LAN_IP_CHANGE_REBOOT_TIME) \
	-DCONFIG_SUPER_G_REBOOT_TIME=$(CONFIG_SUPER_G_REBOOT_TIME) -DCONFIG_UPGRADE_TIME=$(CONFIG_UPGRADE_TIME) -I$(WWW_PATH)/include

# Flash Type
#ifeq ($(CONFIG_FLASH_MXIC_29LV640TB),y)
#	CFLAGS += -DMXIC_FLASH
#else
#	CFLAGS += -DINTEL_FLASH
#endif

obj-clean := $(foreach obj,$(obj-y) $(obj-n),$(obj)-clean)
obj-install := $(foreach obj,$(obj-y),$(obj)-install)

all:

	for i in $(obj-y); do \
		(cd $$i; make) || exit 1; \
	done

ifeq ($(CONFIG_OWERA), y)
	cd ./owera/src/build/release; \
	make oppc; \
	cp -f ./app/oppc $(FS_PATH)/sbin; \
	chmod 777 $(FS_PATH)/sbin/oppc
endif


clean: $(obj-clean);
	$(MAKE) -C config clean	

install: $(obj-install)

conf mconf:
	$(MAKE) -C config
	@./config/$@ ./config/Config

menuconfig: mconf


# Default configurations
.config:
	cp config/defconfig $@
	$(MAKE) mconf
	
ifeq ($(PLATFORM), sl3516)
include Makefile.vpn
endif
#
## Generic rules
#

%:
	[ ! -d $* ] || $(MAKE) -C $*

%-clean:
	[ ! -d $* ] || $(MAKE) -C $* clean

%-install:
	[ ! -d $* ] || $(MAKE) -C $* install

$(obj-y) $(obj-n) $(obj-clean) $(obj-install): dummy

.PHONY: all clean install
.PHONY: conf mconf menuconfig
.PHONY: dummy
