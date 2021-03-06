#ifndef _PMLIST_H_
	#define _PMLIST_H_

#define COMMAND_LEN 500
#define DEST_LEN 100

typedef struct ExpirationEvent {
  int eventId;
  char DevUDN[NAME_SIZE];
  char ServiceID[NAME_SIZE];
  struct portMap *mapping;
} expiration_event;

struct portMap
{
  int m_PortMappingEnabled;
  long int m_PortMappingLeaseDuration;
  char m_RemoteHost[16];
  char m_ExternalPort[6];
  char m_InternalPort[6];
  char m_PortMappingProtocol[4];
  char m_InternalClient[16];
  char m_PortMappingDescription[50];

  int expirationEventId;
  long int expirationTime;

  struct portMap* next;
  struct portMap* prev;
} *pmlist_Head, *pmlist_Tail, *pmlist_Current;

//struct portMap* pmlist_NewNode(void);
struct portMap* pmlist_NewNode(int enabled, long int duration, char *remoteHost,
			       char *externalPort, char *internalPort, 
			       char *protocol, char *internalClient, char *desc);

struct portMap* pmlist_Find(char *externalPort, char *proto, char *internalClient);
struct portMap* pmlist_FindByIndex(int index);
struct portMap* pmlist_FindSpecific(char *externalPort, char *protocol);
int pmlist_IsEmtpy(void);
int pmlist_Size(void);
int pmlist_FreeList(void);
int pmlist_PushBack(struct portMap* item);
int pmlist_Delete(struct portMap* item);
/* jimmy modified 20080131 for RemoteHost supported */
//int pmlist_AddPortMapping (int enabled, char *protocol,
//			   char *externalPort, char *internalClient, char *internalPort);
//int pmlist_DeletePortMapping(int enabled, char *protocol, 
//			     char *externalPort, char *internalClient, char *internalPort);
int pmlist_AddPortMapping (int enabled, char *protocol,
				char *remote_host, char *externalPort, char *internalClient, char *internalPort);

int pmlist_DeletePortMapping(int enabled, char *protocol, 
				char *remote_host, char *externalPort, char *internalClient, char *internalPort);
/* -------------------------------------------------- */
#endif // _PMLIST_H_
