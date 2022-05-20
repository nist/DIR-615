#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <syslog.h>
#include <signal.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/resource.h>
#include <time.h>
#include <net/if.h>
#include <upnp/upnp.h>
#include "globals.h"
#include "config.h"
#include "gatedevice.h"
#include "util.h"
#include "pmlist.h"

// Global variables
struct GLOBALS g_vars;

/* jimmy added 20080204 for test avoid multilpe call upnpd */
#define MOD_XML "/etc/mod_upnpd_xml.sh"

/* "only" verify and adjust the "lan IP" via mod_upnpd_xml.sh 
   the rest part of gatefesc.xml is done by app.c, start_upnp() */
void mod_xml_conf(void){
	char command[80];
	int ret=0;

	sprintf(command,"%s auto",MOD_XML);
	ret=system(command);

	if(ret == -1){
		printf("upnpd %s() failed -1 !!! \n",__FUNCTION__);
	}
	if(ret == 127){
		printf("upnpd %s() failed 127 !!! \n",__FUNCTION__);
	}
}
/* -------------------------------------------------------- */


int main (int argc, char** argv)
{
	char descDocUrl[7+15+1+5+1+sizeof(g_vars.descDocName)+1]; // http://ipaddr:port/docName<null>
	char intIpAddress[16];     // Server internal ip address
	sigset_t sigsToCatch;
	int ret, signum, arg = 1, foreground = 1;

	printf("upnpd: main start\n");
	if (argc < 3 || argc > 4) {
	  printf("Usage: upnpd [-f] <external ifname> <internal ifname>\n");
	  printf("-f\tdon't daemonize\n");
	  printf("Example: upnpd ppp0 eth0\n");
	  exit(0);
	}

	/* now the job mod_xml_conf() already move to rc/app.c, and more complete,
		but I still keep it here in case some unpredictable action
		from rc, but we need to care if we change the gatedesc.xml's location
	*/
	mod_xml_conf();
//-----------

	parseConfigFile(&g_vars);

/* jimmy marked to reduce code size	*/
#if 0
	// check for '-f' option
	if (strcmp(argv[arg], "-f") == 0) {
		foreground = 1;
		arg++;
	}
#endif
/* ----------------------------------- */

	// Save interface names for later use
	strncpy(g_vars.extInterfaceName, argv[arg++], IFNAMSIZ);
	strncpy(g_vars.intInterfaceName, argv[arg++], IFNAMSIZ);

	// Get the internal ip address to start the daemon on
	if (GetIpAddressStr(intIpAddress, g_vars.intInterfaceName) == 0) {
		printf("Invalid internal interface name '%s'\n",g_vars.intInterfaceName);
		//fprintf(stderr, "Invalid internal interface name '%s'\n", g_vars.intInterfaceName);
		exit(EXIT_FAILURE);
	}

	if (!foreground) {
		struct rlimit resourceLimit = { 0, 0 };
		pid_t pid, sid;
		unsigned int i;
		printf("upnpd: !foreground\n");
		// Put igd in the background as a daemon process.
		pid = fork();
		if (pid < 0)
		{
			syslog(LOG_ERR,"Error forking a new process");			
			exit(EXIT_FAILURE);
		}
		if (pid > 0){
			exit(EXIT_SUCCESS);
		}

		// become session leader
		if ((sid = setsid()) < 0)
		{
			syslog(LOG_ERR,"Error running setsid");			
			exit(EXIT_FAILURE);
		}	

		// close all file handles
		resourceLimit.rlim_cur = 0;
		resourceLimit.rlim_max = 0;		
		if (getrlimit(RLIMIT_NOFILE, &resourceLimit)<0) /* shouldn't happen */
		{
		    syslog(LOG_ERR,"error in getrlimit");		    
		    exit(EXIT_FAILURE);
		}
		if (resourceLimit.rlim_max == 0)
		{		    
		    syslog(LOG_ERR,"Max number of open file descriptors is 0!!\n");
		    fprintf(stderr, "Max number of open file descriptors is 0!!\n");
		    exit(EXIT_FAILURE);
		}	

        /* 
         * jimmy add notes if want to use printf to debug, mark the code below
		*/
#define CLOSE_PRINTF 
#ifdef CLOSE_PRINTF
		for (i = 0; i < resourceLimit.rlim_max; i++)
			close(i);
#endif	
		// fork again so child can never acquire a controlling terminal
		pid = fork();
		if (pid < 0)
		{
			syslog(LOG_ERR,"child Error forking a new process");			
			exit(EXIT_FAILURE);
		}
		if (pid > 0){
			exit(EXIT_SUCCESS);
		}

		if ((chdir("/")) < 0)
		{
			syslog(LOG_ERR,"child Error setting root directory");
			exit(EXIT_FAILURE);
		}
	}

	umask(0);
	
// End Daemon initialization	
	openlog("upnpd", LOG_CONS | LOG_NDELAY | LOG_PID | (foreground ? LOG_PERROR : 0), LOG_LOCAL6);

	// Initialize UPnP SDK on the internal Interface
	syslog(LOG_INFO, "Initializing UPnP SDK ... ");
	printf("upnpd: Initializing UPnP SDK ...\n");
	if ( (ret = UpnpInit(intIpAddress,0) ) != UPNP_E_SUCCESS)
	{
		syslog(LOG_ERR,"Error Initializing UPnP SDK on IP %s ",intIpAddress);
		syslog(LOG_ERR,"UpnpInit returned %d", ret);
		UpnpFinish();
		exit(1);
	}
	
	// Set the Device Web Server Base Directory
	//syslog(LOG_INFO, "Setting the Web Server Root Directory to %s",g_vars.xmlPath);
	//printf("upnpd: Setting the Web Server Root Directory to %s\n",g_vars.xmlPath);
	if ( (ret = UpnpSetWebServerRootDir(g_vars.xmlPath)) != UPNP_E_SUCCESS )
	{
		syslog(LOG_ERR,"Error Setting Web Server Root Directory to: %s", g_vars.xmlPath);
		syslog(LOG_ERR,"UpnpSetWebServerRootDir returned %d", ret); 
		UpnpFinish();
		exit(1);
	}	
	
	//initialize the timer thread for expiration of mappings
	//syslog(LOG_INFO, "Initializing the Expiration timer thread.");
	//printf("upnpd: Initializing the Expiration timer thread.\n");
	if (ExpirationTimerThreadInit()!=0) {
	  syslog(LOG_ERR,"ExpirationTimerInit failed");
	  UpnpFinish();
	  exit(1);
	}//here will fork another 2 process
	
	/* jimmy added 20080201 for AutoNotify */
	//syslog(LOG_INFO, "Initializing the Notification timer thread.");
	//printf("upnpd: Initializing the Notification timer thread.\n");
	if (NotificationTimerThreadInit()!=0) {
		syslog(LOG_ERR,"NotificationTimerInit failed");
		UpnpFinish();
		exit(1);
	}
	
	// Form the Description Doc URL to pass to RegisterRootDevice
	sprintf(descDocUrl, "http://%s:%d/%s", UpnpGetServerIpAddress(),
				UpnpGetServerPort(), g_vars.descDocName);

	// Register our IGD as a valid UPnP Root device
	//syslog(LOG_INFO, "Registering the root device with descDocUrl %s", descDocUrl);
	//printf("upnpd: Registering the root device with descDocUrl %s\n", descDocUrl);
	if ( (ret = UpnpRegisterRootDevice(descDocUrl, EventHandler, &deviceHandle,
					   &deviceHandle)) != UPNP_E_SUCCESS )
	{
		syslog(LOG_ERR,"Error registering the root device with descDocUrl: %s", descDocUrl);
		syslog(LOG_ERR,"UpnpRegisterRootDevice returned %d", ret);
		UpnpFinish();
		exit(1);
	}
	
	//syslog(LOG_INFO, "IGD root device successfully registered.");

	/*
		upnpd will acquire too many cpu time then cause booting time too long 
		sleep to avoid upnpd delay other app process , root cause still not found
	*/
	//sleep(10);
	
	// Initialize the state variable table.
	//printf("upnpd: Initialize the state variable table\n");
	StateTableInit(descDocUrl);	
	
	// Record the startup time, for uptime
	startup_time = time(NULL);
	
	// Send out initial advertisements of our device's services with timeouts of 30 minutes
	//if ( (ret = UpnpSendAdvertisement(deviceHandle, 1800) != UPNP_E_SUCCESS ))
	if ( (ret = UpnpSendAdvertisement(deviceHandle, 120) != UPNP_E_SUCCESS ))
	{
		syslog(LOG_ERR,"Error Sending Advertisements.  Exiting ...");
		UpnpFinish();		
		exit(1);
	}	
	printf("upnpd: Advertisements Sent.  Listening for requests ...\n");
	syslog(LOG_INFO, "Advertisements Sent.  Listening for requests ...");
	
	/* jimmy added 20080918 */
#ifdef UPNP_PORTMAPPING_SAVE
	/* in case iptables isn't ready */
	sleep(1);
	/* function in in gatedecive.c */
	reactivate_rules_from_file();
#endif
	
	//printf("upnpd: Initialize finsh\n");
	// Loop until program exit signals received
	do {

	  sigemptyset(&sigsToCatch);
	  sigaddset(&sigsToCatch, SIGINT);
	  sigaddset(&sigsToCatch, SIGTERM);
	  sigaddset(&sigsToCatch, SIGUSR1);
	  pthread_sigmask(SIG_SETMASK, &sigsToCatch, NULL);
	  sigwait(&sigsToCatch, &signum);
	  //trace(3, "Caught signal %d...\n", signum);
	  switch (signum) {
	  case SIGUSR1:
	    DeleteAllPortMappings();
	    break;
	  default:
	    break;
	  }
	} while (signum!=SIGTERM && signum!=SIGINT);

	trace(3, "Shutting down on signal %d...\n", signum);

	// Cleanup UPnP SDK and free memory
	DeleteAllPortMappings();
	ExpirationTimerThreadShutdown();

	/* jimmy added 20080201 for AutoNotify */
	NotificationTimerThreadShutdown();
	/* ------------------------------------ */

	UpnpUnRegisterRootDevice(deviceHandle);
	UpnpFinish();

	// Exit normally
	return (0);
}
