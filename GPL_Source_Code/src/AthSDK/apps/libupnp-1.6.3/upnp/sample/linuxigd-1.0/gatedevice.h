#ifndef _GATEDEVICE_H_
#define _GATEDEVICE_H_ 1

#include <upnp/upnp.h>

/* interface statistics */
typedef enum {
        STATS_TX_BYTES,
        STATS_RX_BYTES,
        STATS_TX_PACKETS,
        STATS_RX_PACKETS,
        STATS_LIMIT
} stats_t;

// IGD Device Globals
UpnpDevice_Handle deviceHandle;
char *gateUDN;
long int startup_time;
char *defConnDevice;// = "WANConnectionDevice:1";
char *defConnServiceID;// = "urn:upnp-org:serviceId:WANIPConn1";
char *WANDeviceUDN;// = NULL;
char *WANConnectionUDN;// = NULL;
char *defConnectionService;// = NULL;


// State Variables
char ConnectionType[50];
char PossibleConnectionTypes[50];
char ConnectionStatus[20];
long int StartupTime;
char LastConnectionError[35];
long int AutoDisconnectTime;
long int IdleDisconnectTime;
long int WarnDisconnectDelay;
int RSIPAvailable;
int NATEnabled;
char ExternalIPAddress[20];
int PortMappingNumberOfEntries;
int PortMappingEnabled;

// Helper routines
char* GetFirstDocumentItem( IN IXML_Document * doc, const char *item );

// Linked list for portmapping entries
struct portMap *pmlist_Head;
struct portMap *pmlist_Current;

// WanIPConnection Actions 
int EventHandler(Upnp_EventType EventType, void *Event, void *Cookie);
int StateTableInit(char *descDocUrl);
int HandleSubscriptionRequest(struct Upnp_Subscription_Request *sr_event);
int HandleGetVarRequest(struct Upnp_State_Var_Request *gv_event);
int HandleActionRequest(struct Upnp_Action_Request *ca_event);

int GetConnectionTypeInfo(struct Upnp_Action_Request *ca_event);
int GetNATRSIPStatus(struct Upnp_Action_Request *ca_event);
int SetConnectionType(struct Upnp_Action_Request *ca_event);
int RequestConnection(struct Upnp_Action_Request *ca_event);
int GetTotal(struct Upnp_Action_Request *ca_event, stats_t stat);
int GetCommonLinkProperties(struct Upnp_Action_Request *ca_event);
int InvalidAction(struct Upnp_Action_Request *ca_event);
int GetStatusInfo(struct Upnp_Action_Request *ca_event);
int AddPortMapping(struct Upnp_Action_Request *ca_event);
int GetGenericPortMappingEntry(struct Upnp_Action_Request *ca_event);
int GetSpecificPortMappingEntry(struct Upnp_Action_Request *ca_event);
int GetExternalIPAddress(struct Upnp_Action_Request *ca_event);
int DeletePortMapping(struct Upnp_Action_Request *ca_event);

// Definitions for mapping expiration timer thread
#define THREAD_IDLE_TIME 5000
#define JOBS_PER_THREAD 10
#define MIN_THREADS 2 
#define MAX_THREADS 12 

int ExpirationTimerThreadInit(void);
int ExpirationTimerThreadShutdown(void);
int ScheduleMappingExpiration(struct portMap *mapping, char *DevUDN, char *ServiceID);
int CancelMappingExpiration(int eventId);
void DeleteAllPortMappings(void);

/* jimmy added 20080201 for AutoNotify */
int NotificationTimerThreadInit();
int NotificationTimerThreadShutdown();
/* ----------------------------------- */


/*  jimmy added 20080918    */
#if defined(UPNP_PORTMAPPING_SAVE) || defined(UPNP_PORTMAPPING_CHECK_NVRAM)
#define UPNP_FORWARD_RULES_FILE "/tmp/upnp_portmapping_rules"
#define UPNP_FORWARD_RULES_FILE_TMP "/tmp/upnp_portmapping_rules.tmp"
#define PRO_LEN 5
#define HOST_LEN 16
#define PORT_LEN 6
#define DESC_LEN 64
#define DURATION_LEN 12
#define FILE_LINE_LEN (PRO_LEN + 2*HOST_LEN + 2*PORT_LEN + DESC_LEN + 2*DURATION_LEN + NAME_SIZE)
#define NVRAM_PATH "/var/etc/nvram.conf"
#define NVRAM_PATH_TMP "/tmp/nvram.conf.tmp"

int get_element(char *input, char *token, char *fmt, ...);

#endif

#ifdef UPNP_PORTMAPPING_SAVE
int find_update_file(int action, char *protocol, char *remoteHost, char *externalPort,
			char *internalClient, char *internalPort, long int duration, char *desc,char *devudn);

int save_file_rules(char *protocol, char *remoteHost, char *externalPort,
			char *internalClient, char *internalPort, long int duration, char *desc,char *devudn);

int reactivate_rules_from_file(void);
#endif

#ifdef UPNP_PORTMAPPING_CHECK_NVRAM
/* this fucntion gets virtual server rules from nvram for specific number */
int nvram_GetGenericPortMappingEntry(int index
			, char *externalPort_out
			, char *protocol_out
			, char *internalPort_out, char *internalClient_out
			, char *enable_out
			, char *desc_out
			, char *duration_out);

/* this fucntion gets virtual server rules from nvram for specific remoteHost,externalPort, protocol */
int nvram_GetSpecificPortMappingEntry(char *externalPort_in
			, char *protocol_in
			, char *internalPort_out, char *internalClient_out
			, char *enable_out
			, char *desc_out
			, char *duration_out);
#endif
/* ------------------------------------- */
#endif //_GATEDEVICE_H

