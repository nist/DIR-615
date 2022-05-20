#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>
#include <upnp/upnp.h>
#include "globals.h"
#include "config.h"
#include "pmlist.h"
#include "gatedevice.h"
#include "util.h"

#if HAVE_LIBIPTC
#include "iptc.h"
#endif

struct portMap* pmlist_NewNode(int enabled, long int duration, char *remoteHost,
			       char *externalPort, char *internalPort,
			       char *protocol, char *internalClient, char *desc)
{
	struct portMap* temp = (struct portMap*) malloc(sizeof(struct portMap));

	temp->m_PortMappingEnabled = enabled;
	
	if (remoteHost && strlen(remoteHost) < sizeof(temp->m_RemoteHost)) strcpy(temp->m_RemoteHost, remoteHost);
		else strcpy(temp->m_RemoteHost, "");
	if (strlen(externalPort) < sizeof(temp->m_ExternalPort)) strcpy(temp->m_ExternalPort, externalPort);
		else strcpy(temp->m_ExternalPort, "");
	if (strlen(internalPort) < sizeof(temp->m_InternalPort)) strcpy(temp->m_InternalPort, internalPort);
		else strcpy(temp->m_InternalPort, "");
	if (strlen(protocol) < sizeof(temp->m_PortMappingProtocol)) strcpy(temp->m_PortMappingProtocol, protocol);
		else strcpy(temp->m_PortMappingProtocol, "");
	if (strlen(internalClient) < sizeof(temp->m_InternalClient)) strcpy(temp->m_InternalClient, internalClient);
		else strcpy(temp->m_InternalClient, "");
/* jimmy modified 20080128
	in case of only have closing tag <actionname /> without opnening tag and content
	see gatedevice.c , function AddPortMapping() for more detail
*/
//	if (strlen(desc) < sizeof(temp->m_PortMappingDescription)) strcpy(temp->m_PortMappingDescription, desc);
//		else strcpy(temp->m_PortMappingDescription, "");
	if ((desc) && (strlen(desc) < sizeof(temp->m_PortMappingDescription))) strcpy(temp->m_PortMappingDescription, desc);
		else strcpy(temp->m_PortMappingDescription, "");
/* ------------------------------------------------------------ */
	temp->m_PortMappingLeaseDuration = duration;

	temp->next = NULL;
	temp->prev = NULL;
	
	return temp;
}
	
struct portMap* pmlist_Find(char *externalPort, char *proto, char *internalClient)
{
	struct portMap* temp;
	
	temp = pmlist_Head;
	if (temp == NULL)
		return NULL;
	
	do 
	{
		if ( (strcmp(temp->m_ExternalPort, externalPort) == 0) &&
				(strcmp(temp->m_PortMappingProtocol, proto) == 0) &&
				(strcmp(temp->m_InternalClient, internalClient) == 0) )
			return temp; // We found a match, return pointer to it
		else
			temp = temp->next;
	} while (temp != NULL);
	
	// If we made it here, we didn't find it, so return NULL
	return NULL;
}

struct portMap* pmlist_FindByIndex(int index)
{
	int i=0;
	struct portMap* temp;
	temp = pmlist_Head;
	if (temp == NULL){
		return NULL;
	}

	do
	{
		if (i == index)
			return temp;
		else
		{
			temp = temp->next;	
			i++;
		}
	} while (temp != NULL);
	return NULL;
}	

struct portMap* pmlist_FindSpecific(char *externalPort, char *protocol)
{
	struct portMap* temp;
	
	temp = pmlist_Head;
	if (temp == NULL)
		return NULL;
	
	do
	{
		if ( (strcmp(temp->m_ExternalPort, externalPort) == 0) &&
				(strcmp(temp->m_PortMappingProtocol, protocol) == 0))
			return temp;
		else
			temp = temp->next;
	} while (temp != NULL);

	return NULL;
}

int pmlist_IsEmtpy(void)
{
	if (pmlist_Head)
		return 0;
	else
		return 1;
}

int pmlist_Size(void)
{
	struct portMap* temp;
	int size = 0;
	
	temp = pmlist_Head;
	if (temp == NULL)
		return 0;
	
	while (temp->next)
	{
		size++;
		temp = temp->next;
	}
	size++;
	return size;
}	

int pmlist_FreeList(void)
{
  struct portMap *temp, *next;

  temp = pmlist_Head;
  while(temp) {
    CancelMappingExpiration(temp->expirationEventId);
    pmlist_DeletePortMapping(temp->m_PortMappingEnabled, temp->m_PortMappingProtocol,temp->m_RemoteHost,
				temp->m_ExternalPort,temp->m_InternalClient, temp->m_InternalPort);
    next = temp->next;
    free(temp);
    temp = next;
  }
  pmlist_Head = pmlist_Tail = NULL;
  return 1;
}
		
int pmlist_PushBack(struct portMap* item)
{
	int action_succeeded = 0;

	if (pmlist_Tail) // We have a list, place on the end
	{
		//trace(3, "pmlist_PushBack: no appended");
		pmlist_Tail->next = item;
		item->prev = pmlist_Tail;
		item->next = NULL;
		pmlist_Tail = item;
		action_succeeded = 1;
	}
	else // We obviously have no list, because we have no tail :D
	{
		pmlist_Head = pmlist_Tail = pmlist_Current = item;
		item->prev = NULL;
		item->next = NULL;
 		action_succeeded = 1;
		trace(3, "pmlist_PushBack appended %d %s %s %s %s %ld", item->m_PortMappingEnabled, 
				    item->m_PortMappingProtocol, item->m_ExternalPort, item->m_InternalClient, item->m_InternalPort,
				    item->m_PortMappingLeaseDuration);
	}
	if (action_succeeded == 1)
	{
/* jimmy modified 20080131 for RemoteHost supported */
#if 0
		pmlist_AddPortMapping(item->m_PortMappingEnabled, item->m_PortMappingProtocol,
				      item->m_ExternalPort, item->m_InternalClient, item->m_InternalPort);
#endif
		pmlist_AddPortMapping(item->m_PortMappingEnabled, item->m_PortMappingProtocol,item->m_RemoteHost,
				      item->m_ExternalPort, item->m_InternalClient, item->m_InternalPort);
/* ------------------------------------------------ */
		return 1;
	}
	else
		return 0;
}

		
int pmlist_Delete(struct portMap* item)
{
	struct portMap *temp;
	int action_succeeded = 0;

	temp = pmlist_Find(item->m_ExternalPort, item->m_PortMappingProtocol, item->m_InternalClient);
	if (temp) // We found the item to delete
	{
	  CancelMappingExpiration(temp->expirationEventId);
	/* jimmy modified 20080131 for RemoteHost supported */
#if 0
		pmlist_DeletePortMapping(item->m_PortMappingEnabled, item->m_PortMappingProtocol, item->m_ExternalPort, 
				item->m_InternalClient, item->m_InternalPort);
#endif
		pmlist_DeletePortMapping(item->m_PortMappingEnabled, item->m_PortMappingProtocol,item->m_RemoteHost,
				item->m_ExternalPort, item->m_InternalClient, item->m_InternalPort);
	/* ------------------------------------------------ */
		if (temp == pmlist_Head) // We are the head of the list
		{
			if (temp->next == NULL) // We're the only node in the list
			{
				pmlist_Head = pmlist_Tail = pmlist_Current = NULL;
				free (temp);
				action_succeeded = 1;
			}
			else // we have a next, so change head to point to it
			{
				pmlist_Head = temp->next;
				pmlist_Head->prev = NULL;
				free (temp);
				action_succeeded = 1;	
			}
		}
		else if (temp == pmlist_Tail) // We are the Tail, but not the Head so we have prev
		{
			pmlist_Tail = pmlist_Tail->prev;
			free (pmlist_Tail->next);
			pmlist_Tail->next = NULL;
			action_succeeded = 1;
		}
		else // We exist and we are between two nodes
		{
			temp->prev->next = temp->next;
			temp->next->prev = temp->prev;
			pmlist_Current = temp->next; // We put current to the right after a extraction
			free (temp);	
			action_succeeded = 1;
		}
	}
	else  // We're deleting something that's not there, so return 0
		action_succeeded = 0;

	return action_succeeded;
}

/* jimmy modified 20080131 for RemoteHost supported */
//int pmlist_AddPortMapping (int enabled, char *protocol, char *externalPort, char *internalClient, char *internalPort)
int pmlist_AddPortMapping (int enabled, char *protocol,char *remote_host, char *externalPort, char *internalClient, char *internalPort)
/* ------------------------------------------------ */
{
	if (enabled){
		char command[COMMAND_LEN];
		int status;

		{
			char dest[DEST_LEN];
/* jimmy modified 20080131 for RemoteHost supported */
/*
	  char *args[] = {"iptables", "-t", "nat", "-I", g_vars.preroutingChainName, "-i", g_vars.extInterfaceName, "-p", protocol, "--dport", externalPort, "-j", "DNAT", "--to", dest, NULL};
		snprintf(dest, DEST_LEN, "%s:%s", internalClient, internalPort);
*/
			char *args_with_remotehost[] = {"iptables", "-t", "nat", "-I", g_vars.preroutingChainName,
				"-i", g_vars.extInterfaceName, "-p", protocol,
				"-s", remote_host,"--dport", externalPort, "-j", "DNAT", "--to", dest, NULL};

			char *args_no_remotehost[] = {"iptables", "-t", "nat", "-I", g_vars.preroutingChainName, "-i", g_vars.extInterfaceName, "-p", protocol, "--dport", externalPort, "-j", "DNAT", "--to", dest, NULL};
			snprintf(dest, DEST_LEN, "%s:%s", internalClient, internalPort);
			if((remote_host) && (strlen(remote_host)>0) ){
				snprintf(command, COMMAND_LEN, "%s -t nat -I %s -i %s -p %s -s %s --dport %s -j DNAT --to %s:%s", g_vars.iptables, g_vars.preroutingChainName, g_vars.extInterfaceName, protocol, remote_host, externalPort, internalClient, internalPort);
			}else{
				snprintf(command, COMMAND_LEN, "%s -t nat -I %s -i %s -p %s --dport %s -j DNAT --to %s:%s", g_vars.iptables, g_vars.preroutingChainName, g_vars.extInterfaceName, protocol, externalPort, internalClient, internalPort);
			}
//iptables -t nat -I PREROUTING -i eth1 -p protocol --dport external_port -j DNAT --to interanl_ip:internal_port
/* ------------------------------------------------ */
/*
Iptables command:	
iptables -A PREROUTING -t nat -p tcp -d 172.21.34.17 --dport 21:30 -j DNAT --to 192.168.0.100:21-30
iptables -A FORWARD -i eth0 -o br0 -p tcp --sport 1024:65535 -d 192.168.0.100 --dport 21:30 -m state --state NEW -j ACCEPT
*/

	  		trace(3, "%s", command);
			if (!fork()) {
		/* jimmy modified 20080131 for RemoteHost supported */
	    //int rc = execv(g_vars.iptables, args);
				int rc;
				if((remote_host) && (strlen(remote_host)>0) ){
					rc = execv(g_vars.iptables, args_with_remotehost);
				}else{
					rc = execv(g_vars.iptables, args_no_remotehost);
				}
		// -------------------------------------
				exit(rc);
			} else {
				wait(&status);		
			}
		}

//iptables -A FORWARD -i eth0 -o br0 -p tcp --sport 1024:65535 -d 192.168.0.100 --dport 21:30 -m state --state NEW -j ACCEPT
		if (g_vars.forwardRules)
		{
			char *args[] = {"iptables", "-A", g_vars.forwardChainName, "-p", protocol, "-d", internalClient, "--dport", internalPort, "-j", "ACCEPT", NULL};
	  
			snprintf(command, COMMAND_LEN, "%s -A %s -p %s -d %s --dport %s -j ACCEPT", g_vars.iptables,g_vars.forwardChainName, protocol, internalClient, internalPort);
			trace(3, "%s", command);

			if (!fork()) {
				int rc = execv(g_vars.iptables, args);
				exit(rc);
			} else {
				wait(&status);		
			}
		}
    }
    return 1;
}

/* jimmy modified 20080131 for RemoteHost supported */
//int pmlist_DeletePortMapping(int enabled, char *protocol, char *externalPort, char *internalClient, char *internalPort)
int pmlist_DeletePortMapping(int enabled, char *protocol, char *remote_host, char *externalPort, char *internalClient, char *internalPort)
/* ------------------------------------------------ */
{
    if (enabled)
    {
		char command[COMMAND_LEN];
		int status;
	
		{
			char dest[DEST_LEN];
/* jimmy modified 20080131 for RemoteHost supported */
#if 0
		char *args[] = {"iptables", "-t", "nat", "-D", g_vars.preroutingChainName, "-i", g_vars.extInterfaceName, "-p", protocol, "--dport", externalPort, "-j", "DNAT", "--to", dest, NULL};
	  snprintf(dest, DEST_LEN, "%s:%s", internalClient, internalPort);
		snprintf(command, COMMAND_LEN, "%s -t nat -D %s -i %s -p %s --dport %s -j DNAT --to %s:%s",
		  g_vars.iptables, g_vars.preroutingChainName, g_vars.extInterfaceName, protocol, externalPort, internalClient, internalPort);
#endif
			char *args_with_remotehost[] = {"iptables", "-t", "nat", "-D", g_vars.preroutingChainName,
				"-i", g_vars.extInterfaceName, "-p", protocol, "-s", remote_host, "--dport",
					externalPort, "-j", "DNAT", "--to", dest, NULL};

			char *args_no_remotehost[] = {"iptables", "-t", "nat", "-D", g_vars.preroutingChainName, "-i", g_vars.extInterfaceName, "-p", protocol, "--dport", externalPort, "-j", "DNAT", "--to", dest, NULL};		

			snprintf(dest, DEST_LEN, "%s:%s", internalClient, internalPort);

			if((remote_host) && (strlen(remote_host)>0) ){
				snprintf(command, COMMAND_LEN, "%s -t nat -D %s -i %s -p %s -s %s --dport %s -j DNAT --to %s:%s", 
					g_vars.iptables, g_vars.preroutingChainName, g_vars.extInterfaceName, protocol, remote_host, externalPort, internalClient, internalPort);
			}else{
				snprintf(command, COMMAND_LEN, "%s -t nat -D %s -i %s -p %s --dport %s -j DNAT --to %s:%s",
				  g_vars.iptables, g_vars.preroutingChainName, g_vars.extInterfaceName, protocol, externalPort, internalClient, internalPort);
			}
/* ------------------------------------------------ */
			trace(3, "%s", command);

			if (!fork()) {
/* jimmy modified 20080131 for RemoteHost supported */
				int rc;
				if((remote_host) && (strlen(remote_host)>0) ){
					rc = execv(g_vars.iptables, args_with_remotehost);
				}else{
					rc = execv(g_vars.iptables, args_no_remotehost);
				}
//	    int rc = execv(g_vars.iptables, args);
//-----------------------------------
	    		exit(rc);
			} else {
				wait(&status);		
			}
		}

		if (g_vars.forwardRules)
		{
			char *args[] = {"iptables", "-D", g_vars.forwardChainName, "-p", protocol, "-d", internalClient, "--dport", internalPort, "-j", "ACCEPT", NULL};
	  
			snprintf(command, COMMAND_LEN, "%s -D %s -p %s -d %s --dport %s -j ACCEPT", g_vars.iptables, g_vars.forwardChainName, protocol, internalClient, internalPort);
			trace(3, "%s", command);

			if (!fork()) {
				int rc = execv(g_vars.iptables, args);
				exit(rc);
			} else {
				wait(&status);		
			}
		}

    }
    return 1;
}
