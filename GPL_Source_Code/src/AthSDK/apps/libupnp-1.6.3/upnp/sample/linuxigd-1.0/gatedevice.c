#include <stdarg.h>
#include <syslog.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <upnp/upnp.h>
#include <upnp/upnptools.h>
#include <upnp/TimerThread.h>
#include <upnp/ixml.h>
#include "globals.h"
#include "gatedevice.h"
#include "pmlist.h"
#include "util.h"

/* jimmy added 20080201 for AutoNotify */
#include <sys/ioctl.h>
#include <signal.h>
#include <net/if.h>

#define AUTO_NOTIFY_TIME 10 //Seconds
static TimerThread gNotificationTimerThread;
static ThreadPool gNotificationThreadPool;
typedef struct NotificationEvent {
	UpnpDevice_Handle device_handle;
	int eventId;
	char DevUDN[NAME_SIZE];
	char ServiceID[NAME_SIZE];
	char sid[44];
} notification_event;

int ScheduleAutoNotification(IN UpnpDevice_Handle Hnd, char *DevUDN, char *ServiceID, char *sid);
int is_wanup(char *extIf);
/* ----------------------------------- */

/* jimmy added 20080918 */
#include <sys/types.h>
#include <sys/stat.h>
/* ------------------------------------------- */

//Definitions for mapping expiration timer thread
static TimerThread gExpirationTimerThread;
static ThreadPool gExpirationThreadPool;

// MUTEX for locking shared state variables whenver they are changed
static ithread_mutex_t DevMutex = PTHREAD_MUTEX_INITIALIZER;

// Main event handler for callbacks from the SDK.  Determine type of event
// and dispatch to the appropriate handler (Note: Get Var Request deprecated
int EventHandler(Upnp_EventType EventType, void *Event, void *Cookie)
{
	switch (EventType)
	{
		case UPNP_EVENT_SUBSCRIPTION_REQUEST:
			HandleSubscriptionRequest((struct Upnp_Subscription_Request *) Event);
			break;
		// -- Deprecated --
		case UPNP_CONTROL_GET_VAR_REQUEST:
			HandleGetVarRequest((struct Upnp_State_Var_Request *) Event);
			break;
		case UPNP_CONTROL_ACTION_REQUEST:
			HandleActionRequest((struct Upnp_Action_Request *) Event);
			break;
		default:
			trace(1, "Error in EventHandler: Unknown event type %d",
						EventType);
	}
	return (0);
}

// Grab our UDN from the Description Document.  This may not be needed, 
// the UDN comes with the request, but we leave this for other device initializations
int StateTableInit(char *descDocUrl)
{
	IXML_Document *ixmlDescDoc = NULL;

	int i, j, ret;
	IXML_NodeList *deviceNodes = NULL;
	unsigned long deviceCount;
	IXML_Node *devNode = NULL;
	IXML_Node *tmpNode = NULL;
	IXML_NodeList *deviceChildren = NULL;
	unsigned long childCount;
	char *devType = NULL;
	char *devUDN = NULL;

	defConnDevice = strdup("WANConnectionDevice:1");
	defConnServiceID = strdup("urn:upnp-org:serviceId:WANIPConn1");


	if ((ret = UpnpDownloadXmlDoc(descDocUrl, &ixmlDescDoc)) != UPNP_E_SUCCESS)
	{
		syslog(LOG_ERR, "Could not parse description document. Exiting ...");
		if(ixmlDescDoc){
			ixmlDocument_free(ixmlDescDoc);
		}
		UpnpFinish();
		exit(0);
	}

	// Get the UDN from the description document, then free the DescDoc's memory
	////gateUDN = GetFirstDocumentItem(ixmlDescDoc, "UDN");
	deviceNodes = ixmlDocument_getElementsByTagName(ixmlDescDoc, "device");
	if ( deviceNodes )	{
		deviceCount = ixmlNodeList_length(deviceNodes);
		for (i = 0; i < deviceCount; i++)
		{
			devNode = ixmlNodeList_item( deviceNodes, i );
			deviceChildren = ixmlNode_getChildNodes( devNode );
			if ( deviceChildren )
			{
				childCount = ixmlNodeList_length(deviceChildren);
				for ( j = 0; j < childCount && (devType == NULL || devUDN == NULL); j++ )
				{
					tmpNode = ixmlNodeList_item( deviceChildren, j );
					if ( devType == NULL )
						GetNodeTextConditional(tmpNode, "deviceType", &devType);
					if (devUDN == NULL )
						GetNodeTextConditional(tmpNode, "UDN", &devUDN);
				}
				if ( devType && devUDN )
				{
					if ( strcmp(devType, 
								"urn:schemas-upnp-org:device:InternetGatewayDevice:1") == 0 )
					{
						gateUDN = devUDN;
						devUDN = NULL;
					}
					else if ( strcmp(devType, 
								"urn:schemas-upnp-org:device:WANDevice:1") == 0 )
					{
						WANDeviceUDN = devUDN;
						devUDN = NULL;
					}
					else if ( strcmp(devType, 
								"urn:schemas-upnp-org:device:WANConnectionDevice:1") == 0 )
					{
						WANConnectionUDN = devUDN;
						devUDN = NULL;
					}
				}
				if ( devType ){
					free(devType);
				}
				if ( devUDN ){
					free(devUDN);
				}
				devType = devUDN = NULL;
				ixmlNodeList_free( deviceChildren );
			}
		}
        ixmlNodeList_free( deviceNodes );
	}
	if ( gateUDN == NULL )
	{
		trace(1, "Failed to retrieve UDN for InternetGatewayDevice");
		ret = -1;
	}
	if ( WANDeviceUDN == NULL )
	{
		trace(1, "Failed to retrieve UDN for WANDevice");
		ret = -1;
	}
	if ( WANConnectionUDN == NULL )
	{
		trace(1, "Failed to retrieve UDN for WANConnectionDevice");
		ret = -1;
	}
	else
	{
		if ( (defConnectionService = malloc( strlen(WANConnectionUDN) + 1 // UDN plus colon
						+ strlen(defConnDevice) + 1 //Device name plus comma
						+ strlen(defConnServiceID) + 1 //ServiceID plus termination
						) ) == NULL )
		{
		/* jimmy added 20080130 in case system did not free memory */
			if(defConnDevice)
				free(defConnDevice);
			if(defConnServiceID)
				free(defConnServiceID);
		/* ------------------------------------------------------- */
			trace(1, "Out of memory while allocating DefaultConnectionService SV value");
			ret = -1;
		}
		else
		{
			sprintf(defConnectionService, "%s:%s,%s", 
					WANConnectionUDN, defConnDevice, defConnServiceID);
		}
	}

	ixmlDocument_free(ixmlDescDoc);
		
	// Initialize our linked list of port mappings.
	pmlist_Head = pmlist_Current = NULL;
	PortMappingNumberOfEntries = 0;

	return (ret);
}

// Handles subscription request for state variable notifications
int HandleSubscriptionRequest(struct Upnp_Subscription_Request *sr_event)
{
	char num[5]; // Maximum number of port mapping entries 9999
	IXML_Document *propSet = NULL;
/* jimmy added 20080201 for AutoNotify */
	int scheduleflag = 0;
/* ----------------------------------- */

	ithread_mutex_lock(&DevMutex);

	if (strcmp(sr_event->UDN, gateUDN) == 0)
	{
/* jimmy modified 20080201 , 
	(1) in our gatedesc.xml, rootdevice has no service, 
	(2)the original code below is incorrect (due to take all gateUDN as the same) 	*/
		;
#if 0
		// WAN Common Interface Config Device Notifications
		if (strcmp(sr_event->ServiceId, "urn:upnp-org:serviceId:WANCommonIFC1") == 0)
		{
		        trace(3, "Recieved request to subscribe to WANCommonIFC1");
			UpnpAddToPropertySet(&propSet, "PhysicalLinkStatus", "Up");
			UpnpAcceptSubscriptionExt(deviceHandle, sr_event->UDN, sr_event->ServiceId,
						  propSet, sr_event->Sid);
			ixmlDocument_free(propSet);
		}
		// WAN IP Connection Device Notifications
		else if (strcmp(sr_event->ServiceId, "urn:upnp-org:serviceId:WANIPConn1") == 0)
		{
			GetIpAddressStr(ExternalIPAddress, g_vars.extInterfaceName);
			trace(3, "Received request to subscribe to WANIPConn1");
			UpnpAddToPropertySet(&propSet, "PossibleConnectionTypes","IP_Routed");
			UpnpAddToPropertySet(&propSet, "ConnectionStatus","Connected");
			UpnpAddToPropertySet(&propSet, "ExternalIPAddress", ExternalIPAddress);
			UpnpAddToPropertySet(&propSet, "PortMappingNumberOfEntries","0");
			UpnpAcceptSubscriptionExt(deviceHandle, sr_event->UDN, sr_event->ServiceId,
						  propSet, sr_event->Sid);
			ixmlDocument_free(propSet);
		}
#endif
/* ------------------------------------------------ */
	}
/* jimmy added 20080201 for cdrouter upnp_200 */
	else if (strcmp(sr_event->UDN, WANConnectionUDN) == 0){
		// WAN IP Connection Device Notifications
		if (strcmp(sr_event->ServiceId, "urn:upnp-org:serviceId:WANIPConn1") == 0)
		{
			trace(3, "Received request to subscribe to WANIPConn1");
		/* jimmy modified 20080201 for AutoNotify */
			//GetIpAddressStr(ExternalIPAddress, g_vars.extInterfaceName);
			if(!is_wanup(g_vars.extInterfaceName)){
				strcpy(ConnectionStatus, "Connected");
				GetIpAddressStr(ExternalIPAddress, g_vars.extInterfaceName);
			}else{
				strcpy(ConnectionStatus, "Disconnected");
			}
		/* ------------------------------------ */
			UpnpAddToPropertySet(&propSet, "PossibleConnectionTypes","IP_Routed");
		/* jimmy modified 20080201 for AutoNotify */
			//UpnpAddToPropertySet(&propSet, "ConnectionStatus","Connected");
			UpnpAddToPropertySet(&propSet, "ConnectionStatus", ConnectionStatus);
		/* -------------------------------------- */
			UpnpAddToPropertySet(&propSet, "ExternalIPAddress", ExternalIPAddress);
			sprintf(num,"%d",pmlist_Size());
			UpnpAddToPropertySet(&propSet, "PortMappingNumberOfEntries", num);
			UpnpAcceptSubscriptionExt(deviceHandle, sr_event->UDN, sr_event->ServiceId,
				propSet, sr_event->Sid);
			ixmlDocument_free(propSet);
		/* jimmy added 20080201 for AutoNotify */
			scheduleflag = 1;
		/* -------------------------------------- */
		}
	}else if (strcmp(sr_event->UDN, WANDeviceUDN) == 0){
		// WAN Common Interface Config Device Notifications
		if (strcmp(sr_event->ServiceId, "urn:upnp-org:serviceId:WANCommonIFC1") == 0)
		{
			trace(3, "Recieved request to subscribe to WANCommonIFC1");
			UpnpAddToPropertySet(&propSet, "PhysicalLinkStatus", "Up");
			UpnpAcceptSubscriptionExt(deviceHandle, sr_event->UDN, sr_event->ServiceId,
				propSet, sr_event->Sid);
			ixmlDocument_free(propSet);
		}
	}
/* ------------------------------------------ */
	ithread_mutex_unlock(&DevMutex);
	/* jimmy added 20080201 for AutoNotify */
	if(scheduleflag)
	{
		trace(2, "ScheduleAutoNotification for UDN:%s, ServiceId:%s\n", sr_event->UDN, sr_event->ServiceId);
		ScheduleAutoNotification(deviceHandle, sr_event->UDN, sr_event->ServiceId, sr_event->Sid);
	}
	/* ----------------------------------- */
	return(1);
}


/* jimmy added 20080201 for AutoNotify */
short ct_ifflags(const char *ifname){
	int sockfd;
	struct ifreq ifreq;
	short flags = 0;

	if ((sockfd = socket( AF_INET, SOCK_DGRAM, 0 )) < 0) {
		perror("socket");
		return flags;
    }

	strncpy(ifreq.ifr_name, ifname, IFNAMSIZ);
	if (ioctl(sockfd, SIOCGIFFLAGS, &ifreq) < 0) {
		flags = 0;
	} else {
		flags = ifreq.ifr_flags;
	}
	close(sockfd);
	return flags;
}

struct in_addr *ct_ifaddr(const char *ifname, struct in_addr *inaddr){
	int sockfd;
	struct ifreq ifreq;

	if(!(ct_ifflags(ifname) & IFF_UP))
		return NULL;

	if ((sockfd = socket( AF_INET, SOCK_DGRAM, 0 )) < 0) {
		perror("socket");
		return NULL;
	}
	strncpy(ifreq.ifr_name, ifname, IFNAMSIZ);
	if (ioctl(sockfd, SIOCGIFADDR, &ifreq) < 0) {
		inaddr = NULL;
	} else {
		memcpy(inaddr, &(((struct sockaddr_in *) &ifreq.ifr_addr)->sin_addr), sizeof(struct in_addr));
	}
	close(sockfd);
	return inaddr;
}

int is_wanup(char *extIf)
{
	int status = 1;
	struct in_addr inaddr = {0};

	if (ct_ifaddr(extIf, &inaddr)) {
		if (inaddr.s_addr != 0) {
			status = 0;
		}
	}

    return status;
}


/* ----------------------------------- */



int HandleGetVarRequest(struct Upnp_State_Var_Request *gv_request)
{
/* jimmy added 20080131 for cdrouter to test "QueryStateVariable" 
	currently only response NULL value as ubicome's to cdrouter,
	to let it pass upnp test pattern 25
*/

#if 0
	// GET VAR REQUEST DEPRECATED FROM UPnP SPECIFICATIONS 
	// Report this in debug and ignore requests.  If anyone experiences problems
	// please let us know.
        trace(3, "Deprecated Get Variable Request received. Ignoring.");
	
	return 1;
#endif
	int result = 0;
	
	ithread_mutex_lock(&DevMutex);

	if (strcmp(gv_request->DevUDN, gateUDN) == 0)
	{
		/*
			Currently, gateUDN would be the first UDN appears in root device in gatedesc.xml,
			and we do not provide any service in root device, we announce it to CPs as dummy,
			so any action request to here should not happen.
			In UPnP IGD v1.01, it defines Layer3Forwarding as option function in this area
		*/
		;
	}else if (strcmp(gv_request->DevUDN, WANConnectionUDN) == 0){//,
		if (strcmp(gv_request->ServiceID, "urn:upnp-org:serviceId:WANIPConn1") == 0)
		{
			if (strcmp(gv_request->StateVarName,"ConnectionStatus") == 0){
				//result = GetConnectionTypeInfo(gv_request);
				result = GetConnectionStatus(gv_request);
			}else{
				return 1;//maybe need to improve
			}
		}else{
			//invalid service id
			//result = ActionError(ca_event, UPNP_SOAP_E_INVALID_ACTION, 
			//		"Unsupported service id: %s", ca_event->ServiceID);
			return 1;//maybe need to improve
		}
	}else{//maybe WANDeviceUDN ??
		return 1;//maybe need to improve
	}
	ithread_mutex_unlock(&DevMutex);

	return (result);
/* --------------------------------------------- */
}

/* jimmy added 20080131 for cdrouter to test "QueryStateVariable" 
	currently only response NULL value as ubicome's to cdrouter,
	to let it pass upnp test pattern 25
*/
int GetConnectionStatus (struct Upnp_State_Var_Request *gv_request){
	char resultStr[RESULT_LEN];
	IXML_Document *result;
	
	snprintf(resultStr, RESULT_LEN,
		"<u:QueryStateVariableResponse xmlns:u=\"urn:schemas-upnp-org:control-1-0\">\n"
		"<return></return>"
		"</u:QueryStateVariableResponse>");
/* ubicom's response
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" soap:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
<soap:Body>
<u:QueryStateVariableResponse xmlns:u="urn:schemas-upnp-org:control-1-0">
<return></return>
</u:QueryStateVariableResponse>
</soap:Body>
</soap:Envelope>
*/
	// Create a IXML_Document from resultStr and return with gv_request
	if ((result = ixmlParseBuffer(resultStr)) != NULL)
	{
		gv_request->CurrentVal = result;
		gv_request->ErrCode = UPNP_E_SUCCESS;
	}else{
		gv_request->CurrentVal = NULL;
		gv_request->ErrCode = 402;
	}
	return(gv_request->ErrCode);
}
/* --------------------------------------------------- */

// Default Action when we receive unknown Action Requests
int ActionError(struct Upnp_Action_Request *ca_event, int errCode, const char *format, ...)
{
	va_list ap;
	char errStr[500];

	va_start(ap,format);
	vsprintf(errStr, format, ap);
	va_end(ap);

	trace(1, "%s: %s", ca_event->ActionName, errStr);
	ca_event->ErrCode = errCode;
	strcpy(ca_event->ErrStr, errStr);
        ca_event->ActionResult = NULL;
	return (errCode);
}

int HandleActionRequest(struct Upnp_Action_Request *ca_event)
{
	int result = 0;

	ithread_mutex_lock(&DevMutex);

	// Common debugging info, hopefully gets removed soon.
	trace(3, "ActionName = %s", ca_event->ActionName);

	if (strcmp(ca_event->DevUDN, gateUDN) == 0)
	{
		/*
			Currently, gateUDN would be the first UDN appears in root device in gatedesc.xml,
			and we do not provide any service in root device, we announce it to CPs as dummy,
			so any action request to here should not happen.
			In UPnP IGD v1.01, it defines Layer3Forwarding as option function in this area
		*/
		;
	}else if(strcmp(ca_event->DevUDN, WANConnectionUDN) == 0){
		if (strcmp(ca_event->ServiceID, "urn:upnp-org:serviceId:WANIPConn1") == 0)
		{
			if (strcmp(ca_event->ActionName,"GetConnectionTypeInfo") == 0){
				result = GetConnectionTypeInfo(ca_event);
			}else if (strcmp(ca_event->ActionName,"GetNATRSIPStatus") == 0){
				result = GetNATRSIPStatus(ca_event);
			}else if (strcmp(ca_event->ActionName,"SetConnectionType") == 0){
				result = SetConnectionType(ca_event);
			}else if (strcmp(ca_event->ActionName,"RequestConnection") == 0){
				result = RequestConnection(ca_event);
			}else if (strcmp(ca_event->ActionName,"AddPortMapping") == 0){
				result = AddPortMapping(ca_event);
			}else if (strcmp(ca_event->ActionName,"GetGenericPortMappingEntry") == 0){
				result = GetGenericPortMappingEntry(ca_event);
			}else if (strcmp(ca_event->ActionName,"GetSpecificPortMappingEntry") == 0){
				result = GetSpecificPortMappingEntry(ca_event);
			}else if (strcmp(ca_event->ActionName,"GetExternalIPAddress") == 0){
				result = GetExternalIPAddress(ca_event);
			}else if (strcmp(ca_event->ActionName,"DeletePortMapping") == 0){
				result = DeletePortMapping(ca_event);
			}else if (strcmp(ca_event->ActionName,"GetStatusInfo") == 0){
				result = GetStatusInfo(ca_event);
			}else{
				result = InvalidAction(ca_event);
			}
		}else{
			//invalid service id
			result = ActionError(ca_event, UPNP_SOAP_E_INVALID_ACTION, 
					"Unsupported service id: %s", ca_event->ServiceID);
		}
	}else if (strcmp(ca_event->DevUDN, WANDeviceUDN) == 0){
		if (strcmp(ca_event->ActionName,"GetTotalBytesSent") == 0){
			result = GetTotal(ca_event, STATS_TX_BYTES);
		}else if (strcmp(ca_event->ActionName,"GetTotalBytesReceived") == 0){
			result = GetTotal(ca_event, STATS_RX_BYTES);
		}else if (strcmp(ca_event->ActionName,"GetTotalPacketsSent") == 0){
			result = GetTotal(ca_event, STATS_TX_PACKETS);
		}else if (strcmp(ca_event->ActionName,"GetTotalPacketsReceived") == 0){
			result = GetTotal(ca_event, STATS_RX_PACKETS);
		}else if (strcmp(ca_event->ActionName,"GetCommonLinkProperties") == 0){
			result = GetCommonLinkProperties(ca_event);
		}else{
			trace(1, "Invalid Action Request : %s",ca_event->ActionName);
			result = InvalidAction(ca_event);
		}
	}else{
		result = ActionError(ca_event, UPNP_SOAP_E_INVALID_ACTION, 
					"DevUDN not found: %s", ca_event->DevUDN);
	}
	ithread_mutex_unlock(&DevMutex);

	return (result);
}



// Default Action when we receive unknown Action Requests
int InvalidAction(struct Upnp_Action_Request *ca_event)
{
        ca_event->ErrCode = 401;
        strcpy(ca_event->ErrStr, "Invalid Action");
        ca_event->ActionResult = NULL;
        return (ca_event->ErrCode);
}


int GetDefaultConnectionService (struct Upnp_Action_Request *ca_event)
{
	char resultStr[500];
	IXML_Document *result;
	sprintf(resultStr,
		"<u:GetDefaultConnectionService xmlns:u=\"urn:schemas-upnp-org:service:Layer3Forwarding:1\">\n"
		"<NewDefaultConnectionService>%s</NewDefaultConnectionService>"
		"</u:GetDefaultConnectionService>", defConnectionService);

	// Create a IXML_Document from resultStr and return with ca_event
	if ((result = ixmlParseBuffer(resultStr)) != NULL)
	{
		ca_event->ActionResult = result;
		ca_event->ErrCode = UPNP_E_SUCCESS;
	}
	else
		ActionError(ca_event, UPNP_SOAP_E_INVALID_ARGS,
				"Error parsing Response to GetDefaultConnectionService: %s", resultStr);

        return (ca_event->ErrCode);
}

// As IP_Routed is the only relevant Connection Type for Linux-IGD
// we respond with IP_Routed as both current type and only type
int GetConnectionTypeInfo (struct Upnp_Action_Request *ca_event)
{
	char resultStr[RESULT_LEN];
	IXML_Document *result;
	snprintf(resultStr, RESULT_LEN,
		"<u:GetConnectionTypeInfoResponse xmlns:u=\"urn:schemas-upnp-org:service:WANIPConnection:1\">\n"
		"<NewConnectionType>IP_Routed</NewConnectionType>\n"
		"<NewPossibleConnectionTypes>IP_Routed</NewPossibleConnectionTypes>"
		"</u:GetConnectionTypeInfoResponse>");

   // Create a IXML_Document from resultStr and return with ca_event
   if ((result = ixmlParseBuffer(resultStr)) != NULL)
   {
      ca_event->ActionResult = result;
      ca_event->ErrCode = UPNP_E_SUCCESS;
   }
   else
   {
      trace(1, "Error parsing Response to GetConnectionTypeinfo: %s", resultStr);
      ca_event->ActionResult = NULL;
      ca_event->ErrCode = 402;
   }
	return(ca_event->ErrCode);
}

// Linux-IGD does not support RSIP.  However NAT is of course
// so respond with NewNATEnabled = 1
int GetNATRSIPStatus(struct Upnp_Action_Request *ca_event)
{
   char resultStr[RESULT_LEN];
	IXML_Document *result;
   snprintf(resultStr, RESULT_LEN, "<u:GetNATRSIPStatusResponse xmlns:u=\"urn:schemas-upnp-org:service:WANIPConnection:1\">\n"
      							"<NewRSIPAvailable>0</NewRSIPAvailable>\n"
									"<NewNATEnabled>1</NewNATEnabled>\n"
								"</u:GetNATRSIPStatusResponse>");

	// Create a IXML_Document from resultStr and return with ca_event
	if ((result = ixmlParseBuffer(resultStr)) != NULL)
	{
		ca_event->ActionResult = result;
		ca_event->ErrCode = UPNP_E_SUCCESS;	
	}
   else
	{
	        trace(1, "Error parsing Response to GetNATRSIPStatus: %s", resultStr);
		ca_event->ActionResult = NULL;
		ca_event->ErrCode = 402;
	}

	return(ca_event->ErrCode);
}


// Connection Type is a Read Only Variable as linux-igd is only
// a device that supports a NATing IP router (not an Ethernet
// bridge).  Possible other uses may be explored.
int SetConnectionType(struct Upnp_Action_Request *ca_event)
{
	// Ignore requests
	ca_event->ActionResult = NULL;
	ca_event->ErrCode = UPNP_E_SUCCESS;
	return ca_event->ErrCode;
}

// This function should set the state variable ConnectionStatus to
// connecting, and then return synchronously, firing off a thread
// asynchronously to actually change the status to connected.  However, here we
// assume that the external WAN device is configured and connected
// outside of linux igd.
int RequestConnection(struct Upnp_Action_Request *ca_event)
{
	
	IXML_Document *propSet = NULL;
	//Immediatley Set connectionstatus to connected, and lastconnectionerror to none.
	strcpy(ConnectionStatus,"Connected");
	strcpy(LastConnectionError, "ERROR_NONE");
	trace(2, "RequestConnection recieved ... Setting Status to %s.", ConnectionStatus);

	// Build DOM Document with state variable connectionstatus and event it
	UpnpAddToPropertySet(&propSet, "ConnectionStatus", ConnectionStatus);
	
	// Send off notifications of state change
	UpnpNotifyExt(deviceHandle, ca_event->DevUDN, ca_event->ServiceID, propSet);

	ca_event->ErrCode = UPNP_E_SUCCESS;
	return ca_event->ErrCode;
}


int GetCommonLinkProperties(struct Upnp_Action_Request *ca_event)
{
   char resultStr[RESULT_LEN];
	IXML_Document *result;
	ca_event->ErrCode = UPNP_E_SUCCESS;
	snprintf(resultStr, RESULT_LEN,
		"<u:GetCommonLinkPropertiesResponse xmlns:u=\"urn:schemas-upnp-org:service:WANCommonInterfaceConfig:1\">\n"
		"<NewWANAccessType>Cable</NewWANAccessType>\n"
		"<NewLayer1UpstreamMaxBitRate>%s</NewLayer1UpstreamMaxBitRate>\n"
		"<NewLayer1DownstreamMaxBitRate>%s</NewLayer1DownstreamMaxBitRate>\n"
		"<NewPhysicalLinkStatus>Up</NewPhysicalLinkStatus>\n"
		"</u:GetCommonLinkPropertiesResponse>",g_vars.upstreamBitrate,g_vars.downstreamBitrate);

   // Create a IXML_Document from resultStr and return with ca_event
   if ((result = ixmlParseBuffer(resultStr)) != NULL)
   {
      ca_event->ActionResult = result;
      ca_event->ErrCode = UPNP_E_SUCCESS;
   }
   else
   {
      trace(1, "Error parsing Response to GetCommonLinkProperties: %s", resultStr);
      ca_event->ActionResult = NULL;
      ca_event->ErrCode = 402;
   }

	return(ca_event->ErrCode);
}

/* get specified statistic from /proc/net/dev */
int GetTotal(struct Upnp_Action_Request *ca_event, stats_t stat)
{
	char dev[IFNAMSIZ], resultStr[RESULT_LEN];
	const char *methods[STATS_LIMIT] =
		{ "BytesSent", "BytesReceived", "PacketsSent", "PacketsReceived" };
	unsigned long stats[STATS_LIMIT];
	FILE *proc;
	IXML_Document *result;
	int read;
	proc = fopen("/proc/net/dev", "r");
	if (!proc)
	{
		fprintf(stderr, "failed to open\n");
		return 0;
	}

	/* skip first two lines */
	fscanf(proc, "%*[^\n]\n%*[^\n]\n");

	/* parse stats */
	do
		read = fscanf(proc, "%[^:]:%lu %lu %*u %*u %*u %*u %*u %*u %lu %lu %*u %*u %*u %*u %*u %*u\n", dev, &stats[STATS_RX_BYTES], &stats[STATS_RX_PACKETS], &stats[STATS_TX_BYTES], &stats[STATS_TX_PACKETS]);
	while (read != EOF && (read == 5 && strncmp(dev, g_vars.extInterfaceName, IFNAMSIZ) != 0));

	fclose(proc);

	snprintf(resultStr, RESULT_LEN,
		"<u:GetTotal%sResponse xmlns:u=\"urn:schemas-upnp-org:service:WANCommonInterfaceConfig:1\">\n"
		"<NewTotal%s>%lu</NewTotal%s>\n"
		"</u:GetTotal%sResponse>", 
		methods[stat], methods[stat], stats[stat], methods[stat], methods[stat]);

	// Create a IXML_Document from resultStr and return with ca_event
	if ((result = ixmlParseBuffer(resultStr)) != NULL)
	{
		ca_event->ActionResult = result;
		ca_event->ErrCode = UPNP_E_SUCCESS;
	}
	else
	{
		trace(1, "Error parsing response to GetTotal: %s", resultStr);
		ca_event->ActionResult = NULL;
		ca_event->ErrCode = 402;
	}

	return (ca_event->ErrCode);
}

// Returns connection status related information to the control points
int GetStatusInfo(struct Upnp_Action_Request *ca_event)
{
   long int uptime;
   char resultStr[RESULT_LEN];
	IXML_Document *result = NULL;
   uptime = (time(NULL) - startup_time);
   
	snprintf(resultStr, RESULT_LEN,
		"<u:GetStatusInfoResponse xmlns:u=\"urn:schemas-upnp-org:service:GetStatusInfo:1\">\n"
		"<NewConnectionStatus>Connected</NewConnectionStatus>\n"
		"<NewLastConnectionError>ERROR_NONE</NewLastConnectionError>\n"
		"<NewUptime>%li</NewUptime>\n"
		"</u:GetStatusInfoResponse>", 
		uptime);
   
	// Create a IXML_Document from resultStr and return with ca_event
   if ((result = ixmlParseBuffer(resultStr)) != NULL)
   {
      ca_event->ActionResult = result;
      ca_event->ErrCode = UPNP_E_SUCCESS;
   }
   else
   {
     trace(1, "Error parsing Response to GetStatusInfo: %s", resultStr);
      ca_event->ActionResult = NULL;
      ca_event->ErrCode = 402;
   }

   return(ca_event->ErrCode);
}

// Add New Port Map to the IGD
int AddPortMapping(struct Upnp_Action_Request *ca_event)
{
	char *remote_host=NULL;
	char *ext_port=NULL;
	char *proto=NULL;
	char *int_port=NULL;
	char *int_ip=NULL;
	char *int_duration=NULL;
	char *bool_enabled=NULL;
	char *desc=NULL;
  	struct portMap *ret, *new;
/* jimmy added 20080128  */
	struct portMap *ret_tmp=NULL;
/* ---------------------- */
/* jimmy added 20080918 */
#ifdef UPNP_PORTMAPPING_CHECK_NVRAM
	char useless_tmp[128];
#endif
/* ---------------------- */

	int result;
	char num[5]; // Maximum number of port mapping entries 9999
	IXML_Document *propSet = NULL;
	int action_succeeded = 0;
	char resultStr[RESULT_LEN];
	//trace(3, "AddPortMapping start.");
	if ( (ext_port = GetFirstDocumentItem(ca_event->ActionRequest, "NewExternalPort") )
	     && (proto = GetFirstDocumentItem(ca_event->ActionRequest, "NewProtocol") )
	     && (int_port = GetFirstDocumentItem(ca_event->ActionRequest, "NewInternalPort") )
	     && (int_ip = GetFirstDocumentItem(ca_event->ActionRequest, "NewInternalClient") )
	     && (int_duration = GetFirstDocumentItem(ca_event->ActionRequest, "NewLeaseDuration") )
	     && (bool_enabled = GetFirstDocumentItem(ca_event->ActionRequest, "NewEnabled") )
/* jimmy added 20080918 
	because in doc WANIPConnection:1 Service Template Version 1.01, chapter 2.2.17, p.12
	InternalPort's value 0 is not allowed
*/
		&& (atoi(int_port) != 0)
/* ------------------------------------ */
/* jimmy modified 20080128
	because In doc UPnP-DeviceArchitecture-v1.0.pdf, it's vaild for only have 
	closing tag <actionname /> without opnening tag and content if there is 
	no any content for actionname
*/
//	     && (desc = GetFirstDocumentItem(ca_event->ActionRequest, "NewPortMappingDescription") ))
		)
	{
/* ------------------------------------------------------------------------- */
		//trace(3, "AddPortMapping GetocumentItem.");
		desc = GetFirstDocumentItem(ca_event->ActionRequest, "NewPortMappingDescription");
/* jimmy added 20080128 */
		remote_host = GetFirstDocumentItem(ca_event->ActionRequest, "NewRemoteHost");
/* --------------------- */

		// If port map with the same External Port, Protocol, and Internal Client exists
		// then, as per spec, we overwrite it (for simplicity, we delete and re-add at end of list)
		// Note: This may cause problems with GetGernericPortMappingEntry if a CP expects the overwritten
		// to be in the same place.

		if ((ret = pmlist_Find(ext_port, proto, int_ip)) != NULL)
		{
				trace(3, "Found port map to already exist.  Replacing");
				pmlist_Delete(ret);
		}

/* jimmy added 20080128 
	beacuse XBOX will try to request a port already assign to another CP,
	and XBOX thinks we should reject the duplicated request , not replace
*/
		/* jimmy modified 20080918 , chekcing virtual server rules in nvram */
#ifdef UPNP_PORTMAPPING_CHECK_NVRAM
		//trace(3, "AddPortMapping GetocumentItem check Specific and nvram.");
		if ((ret_tmp = pmlist_FindSpecific(ext_port, proto)) 
				|| (nvram_GetSpecificPortMappingEntry(ext_port,proto
							,useless_tmp,useless_tmp,useless_tmp,useless_tmp
							,useless_tmp) == 1)){
#else
		//trace(3, "AddPortMapping GetocumentItem check Specific.");
		if ((ret_tmp = pmlist_FindSpecific(ext_port, proto))){
#endif
		/* ------------------------------------------------------ */
			ca_event->ErrCode = 402;
			strcpy(ca_event->ErrStr, "Invalid Args, ports with proto already being used");
			ca_event->ActionResult = NULL;
			//trace(3, "AddPortMapping GetocumentItem check fail.");
		}else{
//-----------------------
/* jimmy modified 20080131 for RemoteHost supported */
//			new = pmlist_NewNode(atoi(bool_enabled), atol(int_duration), "", ext_port, int_port, proto, int_ip, desc); 
			//trace(3, "AddPortMapping GetocumentItem check ok.");
			if(remote_host){
				new = pmlist_NewNode(atoi(bool_enabled), atol(int_duration), remote_host, ext_port, int_port, proto, int_ip, desc); 
			}else{
				new = pmlist_NewNode(atoi(bool_enabled), atol(int_duration), "", ext_port, int_port, proto, int_ip, desc); 
			}
/* ------------------------------------------------ */
		// the function to add iptables rules
			result = pmlist_PushBack(new);
			if (result==1)
			{
		        //trace(3, "pmlist_PushBack: ok");
		        ScheduleMappingExpiration(new,ca_event->DevUDN,ca_event->ServiceID);
				sprintf(num, "%d", pmlist_Size());
				trace(3, "PortMappingNumberOfEntries: %d", pmlist_Size());
				UpnpAddToPropertySet(&propSet, "PortMappingNumberOfEntries", num);	
				UpnpNotifyExt(deviceHandle, ca_event->DevUDN, ca_event->ServiceID, propSet);
				ixmlDocument_free(propSet);
				trace(2, "AddPortMap: DevUDN: %s ServiceID: %s RemoteHost: %s Prot: %s ExtPort: %s Int: %s.%s",
						    ca_event->DevUDN,ca_event->ServiceID,remote_host, proto, ext_port, int_ip, int_port);
				action_succeeded = 1;
				/* jimmy added 20080918 */
#ifdef UPNP_PORTMAPPING_SAVE
				if(atoi(bool_enabled) == 1){
					/* action, protocol,remoteHost, externalPort,internalClient,internalPort,duration,desc) */
					if(1 != find_update_file(2,proto,remote_host,ext_port,int_ip,int_port,atol(int_duration),desc,ca_event->DevUDN)){
						/* protocol, remoteHost, externalPort,internalClient,internalPort, long int duration, char *desc) */
						save_file_rules(proto,remote_host,ext_port,int_ip,int_port,atol(int_duration),desc,ca_event->DevUDN);
					}
				}
#endif
				/* ----------------------- */
			}else{
				//trace(3, "pmlist_PushBack: fail");
				if (result==718)
				{
					trace(1,"Failure in GateDeviceAddPortMapping: RemoteHost: %s Prot:%s ExtPort: %s Int: %s.%s\n",
							    remote_host, proto, ext_port, int_ip, int_port);
					ca_event->ErrCode = 718;
					strcpy(ca_event->ErrStr, "ConflictInMappingEntry");
					ca_event->ActionResult = NULL;
				}
	 		}
		}
	}
	else
	{
	  trace(1, "Failiure in GateDeviceAddPortMapping: Invalid Arguments!");
	  trace(1, "ExtPort: %s Proto: %s IntPort: %s IntIP: %s Dur: %s Ena: %s Desc: %s",
		ext_port, proto, int_port, int_ip, int_duration, bool_enabled, desc);
	  ca_event->ErrCode = 402;
	  strcpy(ca_event->ErrStr, "Invalid Args");
	  ca_event->ActionResult = NULL;
	}
	
	if (action_succeeded)
	{
		ca_event->ErrCode = UPNP_E_SUCCESS;
		snprintf(resultStr, RESULT_LEN, "<u:%sResponse xmlns:u=\"%s\">\n%s\n</u:%sResponse>",
			ca_event->ActionName, "urn:schemas-upnp-org:service:WANIPConnection:1", "", ca_event->ActionName);
		ca_event->ActionResult = ixmlParseBuffer(resultStr);
	}
	if (ext_port){
		free(ext_port);
	}
	if (int_port){
		free(int_port);
	}
	if (proto) {
		free(proto);
	}
	if (int_ip) {
		free(int_ip);
	}
	if (bool_enabled){
		free(bool_enabled);
	}
	if (desc) {
		free(desc);
	}
	if (remote_host){
		free(remote_host);
	}

	return(ca_event->ErrCode);
}

int GetGenericPortMappingEntry(struct Upnp_Action_Request *ca_event)
{
	char *mapindex = NULL;
	struct portMap *temp;
	char result_param[RESULT_LEN];
	char resultStr[RESULT_LEN];
	int action_succeeded = 0;
	if ((mapindex = GetFirstDocumentItem(ca_event->ActionRequest, "NewPortMappingIndex")))
	{
		temp = pmlist_FindByIndex(atoi(mapindex));
		if (temp)
		{
			snprintf(result_param, RESULT_LEN, "<NewRemoteHost>%s</NewRemoteHost><NewExternalPort>%s</NewExternalPort><NewProtocol>%s</NewProtocol><NewInternalPort>%s</NewInternalPort><NewInternalClient>%s</NewInternalClient><NewEnabled>%d</NewEnabled><NewPortMappingDescription>%s</NewPortMappingDescription><NewLeaseDuration>%li</NewLeaseDuration>", temp->m_RemoteHost, temp->m_ExternalPort, temp->m_PortMappingProtocol, temp->m_InternalPort, temp->m_InternalClient, temp->m_PortMappingEnabled, temp->m_PortMappingDescription, temp->m_PortMappingLeaseDuration);
			action_succeeded = 1;
		}
		/*  jimmy added 20080918    */
#ifdef UPNP_PORTMAPPING_CHECK_NVRAM
		else
		{
			int list_size = 0;
			char protocol_out[PRO_LEN] = {0}, desc_out[DESC_LEN] = {0};
			//char remoteHost_out[HOST_LEN] = {0};
			char externalPort_out[PORT_LEN] = {0};
			char internalPort_out[PORT_LEN] = {0}, internalClient_out[HOST_LEN] = {0};
			char duration_out[DURATION_LEN] = {0};
			char enable_out[2] = {0};

			list_size = pmlist_Size();
			if( (list_size == 0) || (atoi(mapindex)+1 > list_size) ){
				int i = 0;
				i = nvram_GetGenericPortMappingEntry(atoi(mapindex) - pmlist_Size()
						,externalPort_out,protocol_out
						,internalPort_out
						,internalClient_out
						,enable_out
						,desc_out
						,duration_out
						);
				if(i == 1){
					snprintf(result_param, RESULT_LEN
							, "<NewRemoteHost></NewRemoteHost><NewExternalPort>%s</NewExternalPort><NewProtocol>%s</NewProtocol><NewInternalPort>%s</NewInternalPort><NewInternalClient>%s</NewInternalClient><NewEnabled>%s</NewEnabled><NewPortMappingDescription>%s</NewPortMappingDescription><NewLeaseDuration>%s</NewLeaseDuration>"
							, externalPort_out, protocol_out, internalPort_out, internalClient_out, enable_out, desc_out, duration_out);
					action_succeeded = 1;
				}
			}
		}
#endif
		/* -----------------------  */
		if (action_succeeded)
		{
			ca_event->ErrCode = UPNP_E_SUCCESS;
					snprintf(resultStr, RESULT_LEN, "<u:%sResponse xmlns:u=\"%s\">\n%s\n</u:%sResponse>", ca_event->ActionName,
							"urn:schemas-upnp-org:service:WANIPConnection:1",result_param, ca_event->ActionName);
					ca_event->ActionResult = ixmlParseBuffer(resultStr);
		}
		else
		{
			ca_event->ErrCode = 713;
			strcpy(ca_event->ErrStr, "SpecifiedArrayIndexInvalid");
			ca_event->ActionResult = NULL;
      }

   }
   else
   {
            trace(1, "Failure in GateDeviceGetGenericPortMappingEntry: Invalid Args");
            ca_event->ErrCode = 402;
                 strcpy(ca_event->ErrStr, "Invalid Args");
                 ca_event->ActionResult = NULL;
   }
	if (mapindex) free (mapindex);
	return (ca_event->ErrCode);
 	
}

int GetSpecificPortMappingEntry(struct Upnp_Action_Request *ca_event)
{
   char *ext_port=NULL;
   char *proto=NULL;
   char result_param[RESULT_LEN];
   char resultStr[RESULT_LEN];
   int action_succeeded = 0;
	struct portMap *temp;
   if ((ext_port = GetFirstDocumentItem(ca_event->ActionRequest, "NewExternalPort"))
      && (proto = GetFirstDocumentItem(ca_event->ActionRequest,"NewProtocol")))
   {
      if ((strcmp(proto, "TCP") == 0) || (strcmp(proto, "UDP") == 0))
      {
			temp = pmlist_FindSpecific (ext_port, proto);
			if (temp)
			{
				snprintf(result_param, RESULT_LEN, "<NewInternalPort>%s</NewInternalPort><NewInternalClient>%s</NewInternalClient><NewEnabled>%d</NewEnabled><NewPortMappingDescription>%s</NewPortMappingDescription><NewLeaseDuration>%li</NewLeaseDuration>",
            temp->m_InternalPort,
            temp->m_InternalClient,
            temp->m_PortMappingEnabled,
				temp->m_PortMappingDescription,
            temp->m_PortMappingLeaseDuration);
            action_succeeded = 1;
			}
			/*  jimmy added 20080918    */
#ifdef UPNP_PORTMAPPING_CHECK_NVRAM
			else
			{
				char internalPort_out[PORT_LEN] = {0}, internalClient_out[HOST_LEN] = {0};
				char duration_out[DURATION_LEN] = {0};
				char enable_out[2] = {0};
				char desc_out[DESC_LEN] = {0};
				int i = 0;

				i = nvram_GetSpecificPortMappingEntry(ext_port,proto
					,internalPort_out
					,internalClient_out
					,enable_out
					,desc_out
					,duration_out);
				if(i == 1){
					snprintf(result_param, RESULT_LEN, "<NewInternalPort>%s</NewInternalPort><NewInternalClient>%s</NewInternalClient><NewEnabled>%s</NewEnabled><NewPortMappingDescription>%s</NewPortMappingDescription><NewLeaseDuration>%s</NewLeaseDuration>",
					internalPort_out,
					internalClient_out,
					enable_out,
					desc_out,
					duration_out);
					action_succeeded = 1;
				}
			}
#endif
			/* ------------------------------ */
			if (action_succeeded)
			{
				ca_event->ErrCode = UPNP_E_SUCCESS;
				snprintf(resultStr, RESULT_LEN, "<u:%sResponse xmlns:u=\"%s\">\n%s\n</u:%sResponse>", ca_event->ActionName,
					    "urn:schemas-upnp-org:service:WANIPConnection:1",result_param, ca_event->ActionName);
				ca_event->ActionResult = ixmlParseBuffer(resultStr);
			}
			else
			{
            	trace(2, "GateDeviceGetSpecificPortMappingEntry: PortMapping Doesn't Exist...");
				ca_event->ErrCode = 714;
				strcpy(ca_event->ErrStr, "NoSuchEntryInArray");
				ca_event->ActionResult = NULL;
			}
		}
		else
		{
				trace(1, "Failure in GateDeviceGetSpecificPortMappingEntry: Invalid NewProtocol=%s\n",proto);
			ca_event->ErrCode = 402;
			strcpy(ca_event->ErrStr, "Invalid Args");
			ca_event->ActionResult = NULL;
		}
	}
	else
	{
		trace(1, "Failure in GateDeviceGetSpecificPortMappingEntry: Invalid Args");
		ca_event->ErrCode = 402;
		strcpy(ca_event->ErrStr, "Invalid Args");
		ca_event->ActionResult = NULL;
	}
	
	return (ca_event->ErrCode);
}

int GetExternalIPAddress(struct Upnp_Action_Request *ca_event)
{
   char resultStr[RESULT_LEN];
	IXML_Document *result = NULL;
   ca_event->ErrCode = UPNP_E_SUCCESS;
   GetIpAddressStr(ExternalIPAddress, g_vars.extInterfaceName);
   snprintf(resultStr, RESULT_LEN, "<u:GetExternalIPAddressResponse xmlns:u=\"urn:schemas-upnp-org:service:WANIPConnection:1\">\n"
										"<NewExternalIPAddress>%s</NewExternalIPAddress>\n"
								"</u:GetExternalIPAddressResponse>", ExternalIPAddress);

   // Create a IXML_Document from resultStr and return with ca_event
   if ((result = ixmlParseBuffer(resultStr)) != NULL)
   {
      ca_event->ActionResult = result;
      ca_event->ErrCode = UPNP_E_SUCCESS;
   }
   else
   {
      trace(1, "Error parsing Response to ExternalIPAddress: %s", resultStr);
      ca_event->ActionResult = NULL;
      ca_event->ErrCode = 402;
   }

   return(ca_event->ErrCode);
}

int DeletePortMapping(struct Upnp_Action_Request *ca_event)
{
   char *ext_port=NULL;
   char *proto=NULL;
   int result=0;
   char num[5];
   char resultStr[RESULT_LEN];
   IXML_Document *propSet= NULL;
   int action_succeeded = 0;
	struct portMap *temp;
/* jimmy added 20080918 */
#ifdef UPNP_PORTMAPPING_SAVE
	char remoteHost_in[HOST_LEN] = {0};
	char *remoteHost_in_p = NULL;
	char *null_p = NULL;
#endif
/* ----------------------- */

   if (((ext_port = GetFirstDocumentItem(ca_event->ActionRequest, "NewExternalPort")) &&
      (proto = GetFirstDocumentItem(ca_event->ActionRequest, "NewProtocol"))))
   {     
     if ((strcmp(proto, "TCP") == 0) || (strcmp(proto, "UDP") == 0))
     {
		if ((temp = pmlist_FindSpecific(ext_port, proto)))
		/* jimmy modified 20080918 */
		{
#ifdef UPNP_PORTMAPPING_SAVE
			remoteHost_in_p = GetFirstDocumentItem(ca_event->ActionRequest, "NewRemoteHost");
			if(remoteHost_in_p){
				strcpy(remoteHost_in,remoteHost_in_p);
				free(remoteHost_in_p);
			}
#endif
			result = pmlist_Delete(temp);
		}
		//result = pmlist_Delete(temp);
		/* ----------------------- */

         if (result==1)
         {
            trace(2, "DeletePortMap: Proto:%s Port:%s\n",proto, ext_port);
            sprintf(num,"%d",pmlist_Size());
            UpnpAddToPropertySet(&propSet,"PortMappingNumberOfEntries", num);
            UpnpNotifyExt(deviceHandle, ca_event->DevUDN,ca_event->ServiceID,propSet);
            ixmlDocument_free(propSet);
            action_succeeded = 1;
			/* jimmy added 20080918 */
#ifdef UPNP_PORTMAPPING_SAVE
			//when delete port mapping, we need protocol, ext_port
			//remote_host is optional
			if(strlen(remoteHost_in) > 0)
				find_update_file(1,proto,remoteHost_in,ext_port,null_p,null_p,0,null_p,null_p);
			else
				find_update_file(1,proto,null_p,ext_port,null_p,null_p,0,null_p,null_p);
#endif
			/* --------------------------------- */
         }
         else
         {
            trace(1, "Failure in GateDeviceDeletePortMapping: DeletePortMap: Proto:%s Port:%s\n",proto, ext_port);
            ca_event->ErrCode = 714;
            strcpy(ca_event->ErrStr, "NoSuchEntryInArray");
            ca_event->ActionResult = NULL;
         }
      }
      else
      {
         trace(1, "Failure in GateDeviceDeletePortMapping: Invalid NewProtocol=%s\n",proto);
         ca_event->ErrCode = 402;
			strcpy(ca_event->ErrStr, "Invalid Args");
			ca_event->ActionResult = NULL;
      }
   }
   else
   {
		trace(1, "Failiure in GateDeviceDeletePortMapping: Invalid Arguments!");
		ca_event->ErrCode = 402;
		strcpy(ca_event->ErrStr, "Invalid Args");
		ca_event->ActionResult = NULL;
   }

   if (action_succeeded)
   {
      ca_event->ErrCode = UPNP_E_SUCCESS;
      snprintf(resultStr, RESULT_LEN, "<u:%sResponse xmlns:u=\"%s\">\n%s\n</u:%sResponse>",
         ca_event->ActionName, "urn:schemas-upnp-org:service:WANIPConnection:1", "", ca_event->ActionName);
      ca_event->ActionResult = ixmlParseBuffer(resultStr);
   }

   if (ext_port) free(ext_port);
   if (proto) free(proto);

   return(ca_event->ErrCode);
}

// From sampleutil.c included with libupnp 
char* GetFirstDocumentItem( IN IXML_Document * doc,
                                 IN const char *item )
{
    IXML_NodeList *nodeList = NULL;
    IXML_Node *textNode = NULL;
    IXML_Node *tmpNode = NULL;

    char *ret = NULL;

    nodeList = ixmlDocument_getElementsByTagName( doc, ( char * )item );
	if( nodeList ) {
        if( ( tmpNode = ixmlNodeList_item( nodeList, 0 ) ) ) {
            textNode = ixmlNode_getFirstChild( tmpNode );
       if (textNode != NULL)
       {
      ret = strdup( ixmlNode_getNodeValue( textNode ) );
       }
        }
    }

    if( nodeList )
        ixmlNodeList_free( nodeList );
    return ret;
}

// Retrieve the text node value if the parent element node name matches.
int GetNodeTextConditional(IXML_Node *node, const char *name, char** value)
{
    IXML_Node *textNode = NULL;
    const char* tag;

    tag = ixmlNode_getNodeName( node );
    if ( strcmp(tag, name) == 0 )
    {
        textNode = ixmlNode_getFirstChild( node );
        if (textNode != NULL)
        {
            *value = strdup( ixmlNode_getNodeValue( textNode ) );
            return 0;
        }
    }
    return -1;
}

int ExpirationTimerThreadInit(void)
{
  int retVal;

  ThreadPoolAttr attr;
  TPAttrInit( &attr );
  TPAttrSetMaxThreads( &attr, MAX_THREADS );
  TPAttrSetMinThreads( &attr, MIN_THREADS );
  TPAttrSetJobsPerThread( &attr, JOBS_PER_THREAD );
  TPAttrSetIdleTime( &attr, THREAD_IDLE_TIME );

  if( ThreadPoolInit( &gExpirationThreadPool, &attr ) != UPNP_E_SUCCESS ) {
    return UPNP_E_INIT_FAILED;
  }

  if( ( retVal = TimerThreadInit( &gExpirationTimerThread,
				  &gExpirationThreadPool ) ) !=
      UPNP_E_SUCCESS ) {
    return retVal;
  }
  
  return 0;
}

int ExpirationTimerThreadShutdown(void)
{
  return TimerThreadShutdown(&gExpirationTimerThread);
}


void free_expiration_event(expiration_event *event)
{
  if (event->mapping!=NULL)
    event->mapping->expirationEventId = -1;
  free(event);
}

void ExpireMapping(void *input)
{
  char num[5]; // Maximum number of port mapping entries 9999
  IXML_Document *propSet = NULL;
  expiration_event *event = ( expiration_event * ) input;

/* jimmy added 20080918 */
#ifdef UPNP_PORTMAPPING_SAVE
	char *null_p = NULL;
#endif
/* ----------------------- */
    
  ithread_mutex_lock(&DevMutex);

  trace(2, "ExpireMapping: Proto:%s Port:%s\n",
		      event->mapping->m_PortMappingProtocol, event->mapping->m_ExternalPort);

  //reset the event id before deleting the mapping so that pmlist_Delete
  //will not call CancelMappingExpiration
  event->mapping->expirationEventId = -1;
/* jimmy added 20080918 */
#ifdef UPNP_PORTMAPPING_SAVE
	/* when delete port mapping, we need protocol, ext_port
	remote_host is optional */
	if(event->mapping->m_RemoteHost && strlen(event->mapping->m_RemoteHost) > 0){
		/* action, protocol,remoteHost, externalPort,internalClient,internalPort,duration,desc) */
		find_update_file(1,event->mapping->m_PortMappingProtocol
				,event->mapping->m_RemoteHost,event->mapping->m_ExternalPort
				,null_p,null_p,0,null_p,null_p);
	}else{
		find_update_file(1,event->mapping->m_PortMappingProtocol
				,null_p,event->mapping->m_ExternalPort,null_p,null_p,0,null_p,null_p);
	}
#endif
/* --------------------------------- */

  pmlist_Delete(event->mapping);
  
  sprintf(num, "%d", pmlist_Size());
  UpnpAddToPropertySet(&propSet, "PortMappingNumberOfEntries", num);
  UpnpNotifyExt(deviceHandle, event->DevUDN, event->ServiceID, propSet);
  ixmlDocument_free(propSet);
  trace(3, "ExpireMapping: UpnpNotifyExt(deviceHandle,%s,%s,propSet)\n  PortMappingNumberOfEntries: %s",
		      event->DevUDN, event->ServiceID, num);
  
  free_expiration_event(event);
  
  ithread_mutex_unlock(&DevMutex);
}

int ScheduleMappingExpiration(struct portMap *mapping, char *DevUDN, char *ServiceID)
{
  int retVal = 0;
  ThreadPoolJob job;
  expiration_event *event;
  time_t curtime = time(NULL);
	
  if (mapping->m_PortMappingLeaseDuration > 0) {
    mapping->expirationTime = curtime + mapping->m_PortMappingLeaseDuration;
  }
  else {
    //client did not provide a duration, so use the default duration
    if (g_vars.duration==0) {
      return 1; //no default duration set
    }
    else if (g_vars.duration>0) {
      //relative duration
      mapping->expirationTime = curtime+g_vars.duration;
    }
    else { //g_vars.duration < 0
      //absolute daily expiration time
      long int expclock = -1*g_vars.duration;
      struct tm *loctime = localtime(&curtime);
      long int curclock = loctime->tm_hour*3600 + loctime->tm_min*60 + loctime->tm_sec;
      long int diff = expclock-curclock;
      if (diff<60) //if exptime is in less than a minute (or in the past), schedule it in 24 hours instead
	diff += 24*60*60;
      mapping->expirationTime = curtime+diff;
    }
  }

  event = ( expiration_event * ) malloc( sizeof( expiration_event ) );
  if( event == NULL ) {
    return 0;
  }
  event->mapping = mapping;
  if (strlen(DevUDN) < sizeof(event->DevUDN)) strcpy(event->DevUDN, DevUDN);
  else strcpy(event->DevUDN, "");
  if (strlen(ServiceID) < sizeof(event->ServiceID)) strcpy(event->ServiceID, ServiceID);
  else strcpy(event->ServiceID, "");
  
  TPJobInit( &job, ( start_routine ) ExpireMapping, event );
  TPJobSetFreeFunction( &job, ( free_routine ) free_expiration_event );
  if( ( retVal = TimerThreadSchedule( &gExpirationTimerThread,
				      mapping->expirationTime,
				      ABS_SEC, &job, SHORT_TERM,
				      &( event->eventId ) ) )
      != UPNP_E_SUCCESS ) {
    free( event );
    mapping->expirationEventId = -1;
    return 0;
  }
  mapping->expirationEventId = event->eventId;

  trace(3,"ScheduleMappingExpiration: DevUDN: %s ServiceID: %s Proto: %s ExtPort: %s Int: %s.%s at: %s eventId: %d",event->DevUDN,event->ServiceID,mapping->m_PortMappingProtocol, mapping->m_ExternalPort, mapping->m_InternalClient, mapping->m_InternalPort, ctime(&(mapping->expirationTime)), event->eventId);

  return event->eventId;
}

int CancelMappingExpiration(int expirationEventId)
{
  ThreadPoolJob job;
  if (expirationEventId<0)
    return 1;
  trace(3,"CancelMappingExpiration: eventId: %d",expirationEventId);
  if (TimerThreadRemove(&gExpirationTimerThread,expirationEventId,&job)==0) {
    free_expiration_event((expiration_event *)job.arg);
  }
  else {
    trace(1,"  TimerThreadRemove failed!");
  }
  return 1;
}

void DeleteAllPortMappings(void)
{
  IXML_Document *propSet = NULL;

  ithread_mutex_lock(&DevMutex);
  pmlist_FreeList();

  UpnpAddToPropertySet(&propSet, "PortMappingNumberOfEntries", "0");
  UpnpNotifyExt(deviceHandle, gateUDN, "urn:upnp-org:serviceId:WANIPConn1", propSet);
  ixmlDocument_free(propSet);
  trace(2, "DeleteAllPortMappings: UpnpNotifyExt(deviceHandle,%s,%s,propSet)\n  PortMappingNumberOfEntries: %s",
	gateUDN, "urn:upnp-org:serviceId:WANIPConn1", "0");

  ithread_mutex_unlock(&DevMutex);
}


/* jimmy added 20080201 for AutoNotify */

int NotificationTimerThreadInit(){
	int retVal;
	ThreadPoolAttr attr;
	TPAttrInit( &attr );
	TPAttrSetMaxThreads( &attr, MAX_THREADS );
	TPAttrSetMinThreads( &attr, MIN_THREADS );
	TPAttrSetJobsPerThread( &attr, JOBS_PER_THREAD );
	TPAttrSetIdleTime( &attr, THREAD_IDLE_TIME );

	if( ThreadPoolInit( &gNotificationThreadPool, &attr ) != UPNP_E_SUCCESS ) {
		return UPNP_E_INIT_FAILED;
	}

	if( ( retVal = TimerThreadInit( &gNotificationTimerThread,
			&gNotificationThreadPool ) ) !=UPNP_E_SUCCESS ) {
		return retVal;
	}
	return 0;
}

int NotificationTimerThreadShutdown(){
	return TimerThreadShutdown(&gNotificationTimerThread);
}

void free_notification_event(notification_event *event){
	if(event)free(event);
}

void AutoNotify( void *input ){
	IXML_Document *propSet = NULL;
	notification_event *event = ( notification_event * ) input;
	char connStatus[20];
	char extIP[20];
	ThreadPoolJob job;
	int retVal = 0;

	ithread_mutex_lock(&DevMutex);
	memset(extIP,'\0',sizeof(extIP));
//  trace(3, "AutoNotify: UDN:%s ServiceID:%s\n", event->DevUDN, event->ServiceID);
	if(!is_wanup(g_vars.extInterfaceName)){
		strcpy(connStatus, "Connected");
		GetIpAddressStr(extIP, g_vars.extInterfaceName);
	}else{
		strcpy(connStatus, "Disconnected");
		//jimmy added 20080204 for abnormal string ip reply to CPs
		strcpy(extIP,"0.0.0.0");
	}

	if(strcmp(connStatus, ConnectionStatus) || strcmp(extIP, ExternalIPAddress)){
		trace(2, "New Connection Status and extIP [%s, %s]\n", connStatus, extIP);
		strcpy(ConnectionStatus, connStatus);
		strcpy(ExternalIPAddress, extIP);
		UpnpAddToPropertySet(&propSet, "ConnectionStatus", connStatus);
		UpnpAddToPropertySet(&propSet, "ExternalIPAddress", extIP);
		UpnpNotifyExt(deviceHandle, event->DevUDN, event->ServiceID, propSet);
		ixmlDocument_free(propSet);
	}

	ithread_mutex_unlock(&DevMutex);

	//Again schedule for next notification
	TPJobInit( &job, ( start_routine ) AutoNotify, event );
	TPJobSetFreeFunction( &job, ( free_routine ) free_notification_event );
	if( ( retVal = TimerThreadSchedule( &gNotificationTimerThread,
			AUTO_NOTIFY_TIME, ABS_SEC, &job, SHORT_TERM,
				      &( event->eventId ) ) ) != UPNP_E_SUCCESS ) {
		free( event );
	}
}

int ScheduleAutoNotification(IN UpnpDevice_Handle Hnd, char *DevUDN, char *ServiceID, char *sid){
	int retVal = 0;
	ThreadPoolJob job;
	notification_event *event;

	event = ( notification_event * ) malloc( sizeof( notification_event ) );
	if( event == NULL ) {
		return 0;
	}
	if (strlen(DevUDN) < sizeof(event->DevUDN)) strcpy(event->DevUDN, DevUDN);
	else strcpy(event->DevUDN, "");

	if (strlen(ServiceID) < sizeof(event->ServiceID)) strcpy(event->ServiceID, ServiceID);
	else strcpy(event->ServiceID, "");

	strcpy(event->sid, sid);
	event->device_handle = Hnd;

	TPJobInit( &job, ( start_routine ) AutoNotify, event );
	TPJobSetFreeFunction( &job, ( free_routine ) free_notification_event );
	if( ( retVal = TimerThreadSchedule( &gNotificationTimerThread,
		AUTO_NOTIFY_TIME, ABS_SEC, &job, SHORT_TERM, &( event->eventId ) ) )
			!= UPNP_E_SUCCESS ) {
		free( event );
		return 0;
	}

	// trace(3,"ScheduleAutoNotification: DevUDN: %s ServiceID: %s \n",event->DevUDN,event->ServiceID);

	return event->eventId;
}

/* ---------------------------------------- */

/* jimmy added 20080918 */
#if defined(UPNP_PORTMAPPING_SAVE) || defined(UPNP_PORTMAPPING_CHECK_NVRAM)
int get_element(char *input, char *token, char *fmt, ...){
    //desc, protocol, remoteHost, externalPort, internalClient, internalPort,duration, desc,devudn
	va_list  ap;
	int arg, count = 0;
	char *c, *tmp;
	char *p_head = NULL, *p_tail = NULL;
	char *input_end = NULL;
	p_head = input;
	
	input_end = input + strlen(input);
	
	if (!input)
		return 0;
	tmp = input;
	for(count=0; (tmp = strpbrk(tmp, token)); tmp+=1, count++);
	count +=1;
	va_start(ap, fmt);
	for (arg = 0, c = fmt; c && *c && arg < count;) {
		if (*c++ != '%'){
			continue;
		}
		switch (*c) {
			case 'd':
				if(!arg)
					*(va_arg(ap, int *)) = atoi(strtok(input, token));
				else
					*(va_arg(ap, int *)) = atoi(strtok(NULL, token));
				break;
			case 's':
				p_tail = strchr(p_head,'/');

				if((p_tail == NULL) || (p_tail > input_end) ){
					return 0;
				}
	
				if(p_head == p_tail){
					p_head = p_tail;
					//*(va_arg(ap, char **)) = NULL;
					*(va_arg(ap, char **)) = "";
				}else{
					*p_tail='\0';
					*(va_arg(ap, char **)) = p_head;
				}
				p_head = p_tail + 1;
				break;
		}
		arg++;
	}
	
	va_end(ap);
	
	return arg;
}
#endif

#ifdef UPNP_PORTMAPPING_SAVE
int find_update_file(int action, char *protocol, char *remoteHost, char *externalPort,
			char *internalClient, char *internalPort, long int duration, char *desc,char *devudn){
	/* action:
		0: only query without any action
		1: delete
			return 1, if record has been found and deleted
			return 0, if NO record has been found
		2: update
			return 1, if record has been found and updated
			return 0, if NO record has been found
	*/
	FILE *fp;
	FILE *fp_tmp;
	char buf[FILE_LINE_LEN] = {0},buf_ori[FILE_LINE_LEN] = {0};
	char *protocol_in = NULL, *desc_in = NULL;
	char *remoteHost_in = NULL, *externalPort_in = NULL;
	char *internalPort_in = NULL, *internalClient_in = NULL;
	char *duration_in = NULL, *expireTime_in = NULL;
	char *devudn_in = NULL;
	int result = 0;
	/*	result:
		-1	: operation failed
		 0	: record NOT exists
		 1 	: record exists or delete success
	*/

	trace(3, "%s, line %d , begin, action = %s\n",__FUNCTION__,__LINE__,
			action == 1 ? "delete" : (action == 2 ? "update" : "query"));

	if((fp=fopen(UPNP_FORWARD_RULES_FILE,"r"))==NULL){
		syslog(LOG_ERR, "Upnpd: find_update_file, failed to open %s", UPNP_FORWARD_RULES_FILE);
		return -1;
	}

	if((fp_tmp=fopen(UPNP_FORWARD_RULES_FILE_TMP,"w"))==NULL){
		syslog(LOG_ERR, "Upnpd: find_update_file, failed to open %s", UPNP_FORWARD_RULES_FILE_TMP);
		fclose(fp);
		return -1;
	}

	switch (action){
		case 0://Query
			while(!feof(fp)){
				fgets(buf,FILE_LINE_LEN,fp);
				if(!feof(fp) && (buf[0]!='\n') ){
					strcpy(buf_ori,buf);
	//desc, protocol, remoteHost, externalPort, internalClient, internalPort,duration, desc,devudn
					get_element(buf,"/","%s %s %s %s %s %s %s %s %s"
							,&desc_in,&protocol_in
							,&remoteHost_in,&externalPort_in
							,&internalClient_in,&internalPort_in
							,&duration_in,&expireTime_in,&devudn_in);
					
					trace(3, "upnpd: %s, %s/%s/%s/%s/%s/%s/%s/%s/%s\n",__FUNCTION__
							,desc_in ? desc_in : ""
							,protocol_in
							,remoteHost_in ? remoteHost_in : "" ,externalPort_in
							,internalClient_in,internalPort_in ? internalPort_in : ""
							,duration_in ? duration_in : "" ,expireTime_in ? expireTime_in : ""
							,devudn_in ? devudn_in : ""
							);
		
					if((strcasecmp(protocol,protocol_in) == 0) && (strcasecmp(externalPort,externalPort_in) == 0)  
						&& (strcasecmp(internalClient,internalClient_in) == 0)){
						result = 1;
						// copy from gatedevice.c (upnpd src)
						// If port map with the same External Port, Protocol, and Internal Client exists
						// then, as per spec, we overwrite it (for simplicity, we delete and re-add at end of list)
						// Note: This may cause problems with GetGernericPortMappingEntry if a CP expects the overwritten
						// to be in the same place.
							break;
					}
				}
			}
			break;
		case 1://delete
			while(!feof(fp)){
				fgets(buf,FILE_LINE_LEN,fp);
				if(!feof(fp) && (buf[0]!='\n') ){
					strcpy(buf_ori,buf);
					get_element(buf,"/","%s %s %s %s %s %s %s %s %s"
							,&desc_in,&protocol_in
							,&remoteHost_in,&externalPort_in
							,&internalClient_in,&internalPort_in
							,&duration_in,&expireTime_in,&devudn_in);
		
					trace(3, "upnpd: %s, %s/%s/%s/%s/%s/%s/%s/%s/%s\n",__FUNCTION__
							,desc_in ? desc_in : ""
							,protocol_in
							,remoteHost_in ? remoteHost_in : "" ,externalPort_in
							,internalClient_in,internalPort_in ? internalPort_in : ""
							,duration_in ? duration_in : "" ,expireTime_in ? expireTime_in : ""
							,devudn_in ? devudn_in : ""
							);

					if((strcasecmp(protocol,protocol_in) == 0) && (strcasecmp(externalPort,externalPort_in) == 0)  
						){
						if(remoteHost && (strlen(remoteHost) > 0)){
							if(strcasecmp(remoteHost,remoteHost_in) == 0){
								result = 1;
							}else{
								fprintf(fp_tmp,"%s",buf_ori);
							}
						}else{
							result = 1;
						}
					}else{
						fprintf(fp_tmp,"%s",buf_ori);
					}
				}
			}
			break;
		case 2://update
			while(!feof(fp)){
				fgets(buf,FILE_LINE_LEN,fp);
				if(!feof(fp) && (buf[0]!='\n') ){
					strcpy(buf_ori,buf);
					get_element(buf,"/","%s %s %s %s %s %s %s %s %s"
							,&desc_in,&protocol_in
							,&remoteHost_in,&externalPort_in
							,&internalClient_in,&internalPort_in
							,&duration_in,&expireTime_in,&devudn_in);
		
					trace(3, "upnpd: %s, %s/%s/%s/%s/%s/%s/%s/%s/%s\n",__FUNCTION__
							,desc_in ? desc_in : ""
							,protocol_in
							,remoteHost_in ? remoteHost_in : "" ,externalPort_in
							,internalClient_in,internalPort_in ? internalPort_in : ""
							,duration_in ? duration_in : "" ,expireTime_in ? expireTime_in : ""
							,devudn_in ? devudn_in : ""
							);
		
					if((strcasecmp(protocol,protocol_in) == 0) && (strcasecmp(externalPort,externalPort_in) == 0)  
						&& (strcasecmp(internalClient,internalClient_in) == 0)){
						result = 1;
						// copy from gatedevice.c (upnpd src)
						// If port map with the same External Port, Protocol, and Internal Client exists
						// then, as per spec, we overwrite it (for simplicity, we delete and re-add at end of list)
						// Note: This may cause problems with GetGernericPortMappingEntry if a CP expects the overwritten
						// to be in the same place.
							
						//desc, protocol, remoteHost, externalPort, internalClient, internalPort,duration, desc,devudn
						fprintf(fp_tmp,"%s/%s/%s/%s/%s/%s/%ld/%ld/%s\n",desc ? desc : ""
								,protocol
								,remoteHost ? remoteHost : "" ,externalPort
								,internalClient,internalPort
								,duration,duration + time(NULL)
								,devudn
								);
					}else{
						fprintf(fp_tmp,"%s",buf_ori);
					}
				}
			}
			break;
		default:
			break;
	}

	fclose(fp);
	fclose(fp_tmp);
	if(action != 0){
		rename(UPNP_FORWARD_RULES_FILE_TMP,UPNP_FORWARD_RULES_FILE);
	}else{
		unlink(UPNP_FORWARD_RULES_FILE_TMP);
	}
	return result;
}

int save_file_rules(char *protocol, char *remoteHost, char *externalPort,
			char *internalClient, char *internalPort, long int duration, char *desc,char *devudn
			){
	FILE *fp;

	if((protocol == NULL) || (strcasecmp(protocol,"udp") && strcasecmp(protocol,"tcp"))){
		syslog(LOG_ERR, "upnpd: %s, Invalid protocol %s.\n",__FUNCTION__,protocol);
		return 0;
	}
	if((externalPort == NULL) || (internalPort == NULL) || (internalClient == NULL)
		/*|| (duration == 0)*/
	){
		syslog(LOG_ERR, "upnpd: %s, Invalid argument.\n",__FUNCTION__);
		return 0;
	}

	//desc, protocol, remoteHost, externalPort, internalClient, internalPort,duration, desc,devudn
	if((fp=fopen(UPNP_FORWARD_RULES_FILE,"a"))!=NULL){
		fprintf(fp,"%s/%s/%s/%s/%s/%s/%ld/%ld/%s\n",desc ? desc : ""
								,protocol
								,remoteHost ? remoteHost : "",externalPort
								,internalClient,internalPort
								,duration,duration + time(NULL)
								,devudn
								);
		fclose(fp);
	}else{
		syslog(LOG_ERR, "upnpd: %s, failed to open %s.\n",__FUNCTION__,UPNP_FORWARD_RULES_FILE);
		return 0;
	}

	return 1;
}


int reactivate_rules_from_file(void){
	FILE *fp,*fp_tmp;
	char buf[FILE_LINE_LEN] = {0},buf_ori[FILE_LINE_LEN] = {0};
	char *protocol_in= NULL, *desc_in = NULL;
	char *remoteHost_in = NULL, *externalPort_in = NULL;
	char *internalPort_in = NULL, *internalClient_in = NULL;
	char *duration_in = NULL, *expireTime_in = NULL;
	char *devudn_in = NULL;
	long int new_duration = 0;

	struct portMap *new = NULL;
	char num[5]; // Maximum number of port mapping entries 9999
//	IXML_Document *propSet = NULL;

#define TMP_SHELL "/tmp/upnpd_reload.sh"

	if((fp=fopen(UPNP_FORWARD_RULES_FILE,"r"))==NULL){
		syslog(LOG_ERR, "upnpd: %s, %s doesn't exists.\n",__FUNCTION__,UPNP_FORWARD_RULES_FILE);
		return -1;
	}
	if((fp_tmp=fopen(TMP_SHELL,"w"))==NULL){
		fclose(fp);
		syslog(LOG_ERR, "upnpd: %s, failed to open %s.\n",__FUNCTION__,TMP_SHELL);
		return -1;
	}

	fprintf(fp_tmp,"#!/bin/sh\n");
	while(!feof(fp)){
		fgets(buf,FILE_LINE_LEN,fp);
		strcpy(buf_ori,buf);
		if(!feof(fp) && (buf[0]!='\n')){
			get_element(buf,"/","%s %s %s %s %s %s %s %s %s"
							,&desc_in,&protocol_in
							,&remoteHost_in,&externalPort_in
							,&internalClient_in,&internalPort_in
							,&duration_in,&expireTime_in,&devudn_in);

			trace(3, "upnpd: %s, %s/%s/%s/%s/%s/%s/%s/%s/%s\n",__FUNCTION__,desc_in,protocol_in
				,remoteHost_in ? remoteHost_in : "",externalPort_in
				,internalClient_in,internalPort_in
				,duration_in,expireTime_in,devudn_in);

			new_duration = atol(expireTime_in) - time(NULL);
			/* here , we re-add only if new_duration is more than 10 secs */
			if(new_duration < 10 && atol(expireTime_in) != 0 ){
				/* 
					1. 0 means tatic rules
					2. < current time, we don't need to reactivate firewall rules
				get_element(buf,desc_in,protocol_in
					,remoteHost_in,externalPort_in
					,internalClient_in,internalPort_in
					,duration_in,expireTime_in,devudn_in);*/
				trace(3,"upnpd: %s, This rule is being timeout (%ld), ignore it !\n",__FUNCTION__,new_duration);
				continue;
			}
			/* activate firewall rules */
			//iptables -t nat -I PREROUTING -i eth1 -p protocol --dport external_port -j DNAT --to interanl_ip:internal_port
			if(strlen(remoteHost_in) > 0){

				fprintf(fp_tmp,"iptables -t nat -I PREROUTING -i %s -p %s -s %s --dport %s -j DNAT --to %s:%s\n",
						g_vars.extInterfaceName, protocol_in, remoteHost_in, externalPort_in,
						internalClient_in, internalPort_in);
				trace(3, "upnpd: %s, iptables -t nat -I PREROUTING -i %s -p %s -s %s --dport %s -j DNAT --to %s:%s\n",
						__FUNCTION__,
						g_vars.extInterfaceName, protocol_in, remoteHost_in, externalPort_in,
						internalClient_in, internalPort_in);
			}else{
				fprintf(fp_tmp,"iptables -t nat -I PREROUTING -i %s -p %s --dport %s -j DNAT --to %s:%s\n",
						g_vars.extInterfaceName, protocol_in, externalPort_in,
						internalClient_in, internalPort_in);
				trace(3, "upnpd: %s, iptables -t nat -I PREROUTING -i %s -p %s --dport %s -j DNAT --to %s:%s\n",
						__FUNCTION__,
						g_vars.extInterfaceName, protocol_in, externalPort_in,
						internalClient_in, internalPort_in);
			}
			//iptables -A FORWARD -p tcp -d 192.168.0.100 --dport 30 -j ACCEPT
			fprintf(fp_tmp,"iptables -A FORWARD -p %s -d %s --dport %s -j ACCEPT\n",
							protocol_in,internalClient_in,internalPort_in);
			trace(3, "upnpd: %s, iptables -A FORWARD -p %s -d %s --dport %s -j ACCEPT\n",
							__FUNCTION__,
							protocol_in,internalClient_in,internalPort_in);

			/* Schedule Mapping Expiration */
			new = NULL;
			if(strlen(remoteHost_in)){
				new = pmlist_NewNode(1, new_duration, remoteHost_in
						, externalPort_in, internalPort_in, protocol_in, internalClient_in, desc_in); 
			}else{
				new = pmlist_NewNode(1, new_duration, ""
						, externalPort_in, internalPort_in, protocol_in, internalClient_in, desc_in); 
			}
			
			/* manually add new node to link list */
			if (pmlist_Tail) // We have a list, place on the end
			{
				pmlist_Tail->next = new;
				new->prev = pmlist_Tail;
				new->next = NULL;
				pmlist_Tail = new;
			}else{ // We obviously have no list, because we have no tail :D
				pmlist_Head = pmlist_Tail = pmlist_Current = new;
				new->prev = NULL;
				new->next = NULL;
				trace(3, "upnpd: %s, appended %d %s %s %s %s %ld", __FUNCTION__
							, new->m_PortMappingEnabled, 
							new->m_PortMappingProtocol, new->m_ExternalPort, new->m_InternalClient, new->m_InternalPort,
							new->m_PortMappingLeaseDuration);
			}
	
			trace(3,"upnpd: %s, Re-adding to ScheduleMappingExpiration in %ld secs !\n",__FUNCTION__,new_duration);
			ScheduleMappingExpiration(new,devudn_in,"WANIPConn1");
			sprintf(num, "%d", pmlist_Size());
			trace(3, "upnpd: %s, PortMappingNumberOfEntries: %d",__FUNCTION__, pmlist_Size());
			/* 
				should we need these codes here ??  upnpapi.c 
				This function sends a notification to all the subscribed
				control points
				Because we have been restarted, so we don;t have the record
				who subscribe which events, so we don't use these codes here
			*/
			
			//UpnpAddToPropertySet(&propSet, "PortMappingNumberOfEntries", num);
			//UpnpNotifyExt(deviceHandle, devudn_in, "WANIPConn1", propSet);
			//ixmlDocument_free(propSet);
		}
	}

	fclose(fp);
	fclose(fp_tmp);
	chmod(TMP_SHELL,S_IXUSR | S_IRUSR | S_IWUSR);
	system(TMP_SHELL);
	unlink(TMP_SHELL);

	return 1;
}
#endif

#ifdef UPNP_PORTMAPPING_CHECK_NVRAM
/* this fucntion gets virtual server rules from nvram for specific number */
int nvram_GetGenericPortMappingEntry(int index
			, char *externalPort_out
			, char *protocol_out
			, char *internalPort_out, char *internalClient_out
			, char *enable_out
			, char *desc_out
			, char *duration_out){
	int index_in = 0;
	char cmd[256] = {0};
	char buf[FILE_LINE_LEN] = {0};
	char *useless = NULL;
	char *p = NULL;
	FILE *fp;
	int result = 0;

	char *enable_tmp = NULL;
	char *protocol_tmp = NULL, *desc_tmp = NULL;
	char *externalPort_tmp = NULL;
	char *internalPort_tmp = NULL, *internalClient_tmp = NULL;

	if(index < 0){
		return 0;
	}

	sprintf(cmd,"cat %s |grep vs_rule |grep -v \"=0//\" > %s",NVRAM_PATH,NVRAM_PATH_TMP);
	system(cmd);

	if((fp = fopen(NVRAM_PATH_TMP,"r"))!=NULL){
		while(!feof(fp)){
			fgets(buf,FILE_LINE_LEN,fp);
			if(!feof(fp) && (buf[0]!='\n') ){
				if(strlen(buf) == strlen("vs_rule_0x=\n")){
					continue;
				}

				p = strchr(buf,'=');
				p = p + 1;

				/* enable/name/protocol/ext_port/int_port/ip_addr/schedule_name */
				get_element(p,"/","%s %s %s %s %s %s %s"
							,&enable_tmp
							,&desc_tmp
							,&protocol_tmp
							,&externalPort_tmp, &internalPort_tmp , &internalClient_tmp
							,&useless
							);

				/* only when it has name, it's valid */
				if((desc_tmp == NULL) || (strlen(desc_tmp) == 0)){
					continue;
				}

				if(index_in != index){
					index_in++;
					continue;
				}

				//strcpy(remoteHost_out,"");
				strcpy(externalPort_out,externalPort_tmp);
				if(strcmp(protocol_tmp,"6") == 0){
					strcpy(protocol_out,"TCP");
				}else if(strcmp(protocol_tmp,"17") == 0){
					strcpy(protocol_out,"UDP");
				}else if(strcmp(protocol_tmp,"256") == 0){
					//actually in nvram, 256 ,means both TCP and UDP need to be forwarded
					strcpy(protocol_out,"BOTH");
				}else{
					//OTHER
					strcpy(protocol_out,"OTHER");
				}
				strcpy(internalPort_out,internalPort_tmp);
				strcpy(internalClient_out,internalClient_tmp);
				strcpy(enable_out,enable_tmp);
				strcpy(desc_out,desc_tmp);
				strcpy(duration_out,"0");
				result = 1;
				break;
			}
		}

		fclose(fp);
	}else{
		//no rules in nvram
		result = 0;
	}
	unlink(NVRAM_PATH_TMP);
	return result;
}

int nvram_GetSpecificPortMappingEntry(char *externalPort_in
			, char *protocol_in
			, char *internalPort_out, char *internalClient_out
			, char *enable_out
			, char *desc_out
			, char *duration_out){
	char cmd[256] = {0};
	char buf[FILE_LINE_LEN] = {0};
	char *useless = NULL;
	char *p = NULL;
	FILE *fp;
	int result = 0;

	char *enable_tmp = NULL;
	char *protocol_tmp = NULL, *desc_tmp = NULL;
	char *externalPort_tmp = NULL;
	char *internalPort_tmp = NULL, *internalClient_tmp = NULL;
	char protocol_char[4];

	if((externalPort_in == NULL) || (protocol_in == NULL)
		|| (strlen(externalPort_in) == 0) || (strlen(protocol_in) == 0)
	) {
		return 0;
	}

	sprintf(cmd,"cat %s |grep vs_rule |grep -v \"=0//\" > %s",NVRAM_PATH,NVRAM_PATH_TMP);
	system(cmd);

	if((fp = fopen(NVRAM_PATH_TMP,"r"))!=NULL){
		while(!feof(fp)){
			fgets(buf,FILE_LINE_LEN,fp);
			if(!feof(fp) && (buf[0]!='\n') ){
				if(strlen(buf) == strlen("vs_rule_0x=\n")){
					continue;
				}

				p = strchr(buf,'=');
				p = p + 1;

				/* enable/name/protocol/ext_port/int_port/ip_addr/schedule_name */
				get_element(p,"/","%s %s %s %s %s %s %s"
							,&enable_tmp
							,&desc_tmp
							,&protocol_tmp
							,&externalPort_tmp, &internalPort_tmp , &internalClient_tmp
							,&useless
							);
				/* only when it has name, it's valid */
				if((desc_tmp == NULL) || (strlen(desc_tmp) == 0)){
					continue;
				}

				if(strcmp(externalPort_in,externalPort_tmp) == 0){
					if(strcmp(protocol_tmp,"6") == 0){
						strcpy(protocol_char,"TCP");
					}else if(strcmp(protocol_tmp,"17") == 0){
						strcpy(protocol_char,"UDP");
					}else if(strcmp(protocol_tmp,"256") == 0){
						strcpy(protocol_char,"BOTH");
					}else{
						strcpy(protocol_char,"OTHER");
					}
					if(strcasecmp(protocol_in,protocol_char) == 0){
						strcpy(internalPort_out,internalPort_tmp);
						strcpy(internalClient_out,internalClient_tmp);
						strcpy(enable_out,enable_tmp);
						strcpy(desc_out,desc_tmp);
						strcpy(duration_out,"0");
						result = 1;
						break;
					}
				}
			}
		}

		fclose(fp);
	}else{
		//no rules in nvram
		result = 0;
	}
	unlink(NVRAM_PATH_TMP);
	return result;

}
#endif
/* ------------------------------------------- */




