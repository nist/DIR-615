#ifndef LAYER3FWD_CONF_H_
#define LAYER3FWD_CONF_H_

#define LAYER3FWD_SUCCESS 0
#define LAYER3FWD_FAIL -1

#define LAYER3FWD_PATH_LEN 256

#define CONN_SRV_LEN 256
//#define FWD_NUM_LEN
#define MAX_FWD_NUMS 3 // modify it to fix your device.
#define LAYER3FWD_DEF_CONN_SRV "InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1"
#define LAYER3FWD_FWD_NUMS MAX_FWD_NUMS
#define LAYER3FWD_FWDING_ENABLE 0
#define LAYER3FWD_FWDING_STATUS "Diabled"
#define LAYER3FWD_FWDING_TYPE "Default"
#define LAYER3FWD_FWDING_DEST_IPADDR "172.21.32.1"
#define LAYER3FWD_FWDING_DEST_SUB_MASK "255.255.255.0"
#define LAYER3FWD_FWDING_SRC_IPADDR "192.168.0.1"
#define LAYER3FWD_FWDING_SRC_SUB_MASK "255.255.255.0"
#define LAYER3FWD_FWDING_GW_IPADDR "172.21.1.1"
#define LAYER3FWD_FWDING_IFACE	"InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1"
#define LAYER3FWD_FWDING_METRIC -1
#define LAYER3FWD_FWDING_MTU 1540


char layer3fwd_conf_path[LAYER3FWD_PATH_LEN];
#define LAYER3FWD_CONF_PATH "/var/etc/openagent_layer3fwd.conf"
/************************************************************************
*
*	structure define
*
************************************************************************/
typedef struct {
	unsigned short enable;
	unsigned char status[16]; // Disabled, Enabled, Error
	unsigned char type[16]; // Default, Network, Host
	unsigned char dest_ipaddr[12];
	unsigned char dest_sub_mask[12];
	unsigned char src_ipaddr[12];
	unsigned char src_sub_mask[12];
	unsigned char gw_ipaddr[12];
	unsigned char iface[256];
	int fwd_metric; // -1 indicates not used
	unsigned int mtu; 
}layer3fwd_fwd_table_conf;

typedef struct {
    unsigned char def_conn_srv[CONN_SRV_LEN];
	unsigned int fwd_nums;
	layer3fwd_fwd_table_conf forwarding[MAX_FWD_NUMS]; 
}layer3fwd_conf;

/***********************************************************************
*
*	function declare
*
***********************************************************************/
int get_layer3fwd_conf(layer3fwd_conf *pconf);
int set_layer3fwd_conf(layer3fwd_conf *pconf);
int init_layer3fwd_conf();

#endif
