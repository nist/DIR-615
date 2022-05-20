/*
 * Copyright(c) 2006-2007, Works Systems, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, 
 * are permitted provided that the following conditions are met:
 * 
 * 1. Redistributions of source code must retain the above copyright notice, 
 *    this list of conditions and the following disclaimer. 
 * 2. Redistributions in binary form must reproduce the above copyright notice, 
 *    this list of conditions and the following disclaimer in the documentation 
 *    and/or other materials provided with the distribution. 
 * 3. Neither the name of the vendors nor the names of its contributors 
 *    may be used to endorse or promote products derived from this software 
 *    without specific prior written permission. 
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/***********************************************************************
*
*	include file
*
***********************************************************************/
#include <stdio.h> //printf
#include <ctype.h> //isdigit, isalnum
#include <string.h>
#include <stdlib.h>
#include <netinet/in.h> //INADDR_ANY
#include <sys/socket.h>

#include "tr069_cli.h"

#include "agent_conf.h" 	// ../public/conf/agent_conf.h
#include "lansec_conf.h" 	// ../public/conf/lansec_conf.h
#include "layer3fwd_conf.h" 	// ../public/conf/layer3fwd_conf.h
#include "msgq.h"			// ../public/msg/msgq.h
#include "timestr.h"		// ../publuc/str/timestr.h
#include "../../res/global_res.h"
/*
 ********************************************************************
 * Function name: isvalidvalue();
 * Description: check value is valid.
 * Parameter: value
 * Return value: 0:SUCCESS  -1:FAIL
 *********************************************************************
 */
int isvalidvalue(const char *value)
{
    int i = 0, size =0;
    int status = -1;
    
    size = strlen(value);
    for(i = 0; i < size; i++){
        if(!isalnum(value[i]))
            break;
    }
    if(size > 0 && i == size)
        status = 0;
    return status;
}
/*
 ********************************************************************
 * Function name: verifyLength();
 * Description: check length of value is valid.
 * Parameter: value, max: max lenth
 * Return value: 0:SUCCESS  -1:FAIL
 *********************************************************************
 */
int verifyLength(const char *value, unsigned int max)
{
    int status = -1;
    if(strlen(value) <= max)
        status = 0;
    return status;
}
/*
 ********************************************************************
 * Function name: verifyNumber();
 * Description: check value is number.
 * Parameter: value
 * Return value: 0:SUCCESS  -1:FAIL
 *********************************************************************
 */
int verifyNumber(const char *value)
{
    int i = 0, size =0;
    int status = -1;
    
    size = strlen(value);
    for(i = 0; i < size; i++){
        if(!isdigit(value[i]))
            break;
    }
    if(size > 0 && i == size)
        status = 0;
    return status;
}
/*
 ********************************************************************
 * Function name: check_agent_status();
 * Description: check status of agent(running or not running).
 * Parameter:  none
 * Return value: 0:SUCCESS  -1:FAIL
 *********************************************************************
 */
int check_agent_status()
{
    int res;
    int sockfd;

    struct sockaddr_in cli_addr;

    if((sockfd = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
        perror("socket");
        return -1;
    }
    printf("socket ok.\n");
    cli_addr.sin_family = AF_INET;
    cli_addr.sin_port = htons(CLI_PORT);
    cli_addr.sin_addr.s_addr = INADDR_ANY;
   
    bzero(&(cli_addr.sin_zero), 8);
  
    res = connect(sockfd, (struct sockaddr *)&cli_addr, sizeof(struct sockaddr));
    if (res == -1) {
        perror("connected");
        printf("Agent is not running.\n");
        return -1;
    } else{
        printf("connect ok.\n");
    }
    return 0;
}
/*
 ********************************************************************
 * Function name: cli_set_tr069();
 * Description: send to message queue
 * Parameter:  param, str_mq
 * Return value: 0:SUCCESS  -1:FAIL
 *********************************************************************
 */
int cli_set_tr069(char *param, char *str_mq)
{
    int res = 0;
    long type = SNDMSG;
    int mqid;

    res = creat_msgq(str_mq);
    if(res == -1) {
        printf("error.\n");
        return -1;
    }
    mqid = res;
    res = send_msg(mqid, type, param);
    if (res == -1) {
        printf("error.\n");
        return -1;
    }
    printf("Set to %s successful.\n", str_mq);
    return 0;
}
void init_main_help_msg(char *help_msg)
{
    strcat(help_msg, "Configure TR-069 client parameters depend on specify object, which including ManagmentServer, LANConfigSecurity, Layer3Forwarding, LANDevice, WANDevice\n\n");
    strcat(help_msg, "Usage: tr069 [object] help, to get detail information for each object\n");
    strcat(help_msg, "tr069 object summary\n");
    strcat(help_msg, "\ttr069 mngsrv [command]\t\t\tConfigure the parameters of ManagmentServer\n");
    strcat(help_msg, "\ttr069 lanconfsec [command]\t\tConfigure the parameters of LANConfigSecurity\n");
    strcat(help_msg, "\ttr069 layer3fwd [commnad]\t\tConfigure the parameters of Layer3Forwarding\n");
    strcat(help_msg, "\ttr069 landev [command]\t\t\tConfigure the parameters of LANDevice\n");
    strcat(help_msg, "\ttr069 wandev [command]\t\t\tConfigure the parameters of WANDevice\n");
 
	return;
}

void init_mngsrv_help_msg(char *help_msg)
{
    /*
     * Date: 2009-03-17
     * Name: Norp Huang
     * Description: add CPE URI for CLI tool(tr069)
     */
    //strcat(help_msg, "Configure TR-069 client parameters, including ACS URL, ACS User Name, ACS Password,Inform Interval, Connection Requeset Port, Connection Request User name, Connection Request Password, Periodic Enable, Periodic Interval, Periodic Time, Retry times\n\n");
    strcat(help_msg, "Configure TR-069 client parameters of \"ManagementServer\" object, including ACS URL, ACS User Name, ACS Password,Inform Interval, Connection Requeset Port, Connection Request URI, Connection Request User name, Connection Request Password, Periodic Enable, Periodic Interval, Periodic Time, Retry times\n\n");
    strcat(help_msg, "tr069 mngsrv command summary\n");
    strcat(help_msg, "\ttr069 mngsrv acsurl\t\tConfigure the url for the CPE to connect to the ACS\n");
    strcat(help_msg, "\ttr069 mngsrv acsuser\t\tConfigure username used for HTTP-based authentication\n\t\t\t\tof the CPE\n");
    strcat(help_msg, "\ttr069 mngsrv acspwd\t\tConfigure password used for HTTP-based authentication\n\t\t\t\tof the CPE\n");
    strcat(help_msg, "\ttr069 mngsrv interval\t\tConfigure the duration in seconds of the interval for\n\t\t\t\tthe CPE MUST attempt to connect with the ACS\n");
    strcat(help_msg, "\ttr069 mngsrv enable\t\tConfigure the status(enable or disable) of the interval\n\t\t\t\tfor the CPE MUST attempt to connect with the ACS\n");
    strcat(help_msg, "\ttr069 mngsrv time\t\tConfigure the time of the interval for\n\t\t\t\tthe CPE MUST attempt to connect with the ACS\n");
    strcat(help_msg, "\ttr069 mngsrv reqport\t\tConfigure the port for an ACS to make a Connection\n\t\t\t\tRequest Notification to the CPE\n");
    /*
     * Date: 2009-03-17
     * Name: Norp Huang
     * Description: add CPE URI for CLI tool(tr069)
     */
    strcat(help_msg, "\ttr069 mngsrv requri\t\tConfigure the uri for an ACS to make a Connection\n\t\t\t\tRequest Notification to the CPE\n");
    strcat(help_msg, "\ttr069 mngsrv requser\t\tConfigure the username used to authenticate an ACS\n\t\t\t\tmaking a connection request to the CPE\n");
    strcat(help_msg, "\ttr069 mngsrv reqpwd\t\tConfigure the password used to authenticate an ACS\n\t\t\t\tmaking a connectino request to the CPE\n");
    strcat(help_msg, "\ttr069 mngsrv retrytimes\tConfigure the retry times used by communication\n\t\t\t\tmodule of agent for retry machenism\n");
    strcat(help_msg, "\ttr069 mngsrv info\t\tDisplay TR-069 ManagmentServer parameters information\n");
    strcat(help_msg, "\ttr069 mngsrv help\t\tDisplay the help information\n\n");

	return;
}

void init_lanconfsec_help_msg(char *help_msg)
{
    strcat(help_msg, "Configure TR-069 client parameters of \"LANConfigSecurity\", including ConfigPassword\n\n");
    strcat(help_msg, "tr069 lanconfsec command summary:\n");
    strcat(help_msg, "\ttr069 lanconfsec confpwd\t\tConfigure the password to allow LAN access to protected auto-configuration services\n");
    strcat(help_msg, "\ttr069 lanconfsec info\t\tDisplay TR-069 LANConfigSecurity parameters information\n");
    strcat(help_msg, "\ttr069 lanconfsec help\t\tDisplay the help information\n\n");

	return;
}

void init_layer3fwd_help_msg(char *help_msg)
{
    strcat(help_msg, "Configure TR-069 client parameters of \"Layer3Forwarding\", including DefaultConnectionService, ForeardNumberOfEntries, Forwarding tables(Enable, Status, Type, DestIPAddress, DestSubnetMask, SourceIPAddress, SourceSubnetMask, GatewayIPAddress, Interface, ForwardingMetric, MTU)\n\n");
    strcat(help_msg, "tr069 lanconfsec command summary:\n");
    strcat(help_msg, "\ttr069 layer3fwd defconnsrv\t\tSpecify the default WAN interface in full hierarchical parameter, ex: \"InterfaceGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1\"\n");
    strcat(help_msg, "\ttr069 layer3fwd fwdnums\t\tNumber of forwarding instances\n");
    strcat(help_msg, "\ttr069 layer3fwd fwding_x_enable\t\tEnable/disable the forwarding entry x,(x should be from 1 to fwdnums)\n");
    strcat(help_msg, "\ttr069 layer3fwd fwding_x_status\t\tIndicate the status of the forwarding entry x,(x should be from 1 to fwdnums)\n");
    strcat(help_msg, "\ttr069 layer3fwd fwding_x_type\t\tIndicate the type of route of the forwarding entry x,(x should be from 1 to fwdnums)\n");
    strcat(help_msg, "\ttr069 layer3fwd fwding_x_destipaddr\t\tDestination address of the forwarding entry x,(x should be from 1 to fwdnums)\n");
    strcat(help_msg, "\ttr069 layer3fwd fwding_x_destsubmask\t\tDestination subnet mask of the forwarding entry x,(x should be from 1 to fwdnums)\n");
    strcat(help_msg, "\ttr069 layer3fwd fwding_x_srcipaddr\t\tSource address of the forwarding entry x,(x should be from 1 to fwdnums)\n");
    strcat(help_msg, "\ttr069 layer3fwd fwding_x_srcsubmask\t\tSource subnet mask of the forwarding entry x,(x should be from 1 to fwdnums)\n");
    strcat(help_msg, "\ttr069 layer3fwd fwding_x_gwipaddr\t\tIP address of the gateway of the forwarding entry x,(x should be from 1 to fwdnums)\n");
    strcat(help_msg, "\ttr069 layer3fwd fwding_x_iface\t\tSpecify the WAN interface associated with the forwarding entry x,(x should be from 1 to fwdnums) the context is the full hierarchical parameter name of the layer-3 connection object. ex: \"InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1\"\n");
    strcat(help_msg, "\ttr069 layer3fwd fwding_x_fwdmetric\t\tForwarding metric of the forwarding entry x,(x should be from 1 to fwdnums)\n");
    strcat(help_msg, "\ttr069 layer3fwd fwding_x_mtu\t\tThe maximum allowed size of an Ethernet frame of this route of the forwarding entry x,(x should be from 1 to fwdnums)\n");
    strcat(help_msg, "\ttr069 layer3fwd info\t\tDisplay TR-069 Layer3Forwarding parameters information\n");
    strcat(help_msg, "\ttr069 layer3fwd help\t\tDisplay the help information\n\n");

	return;
}
void init_landev_help_msg(char *help_msg)
{
	return;
}
void init_wandev_help_msg(char *help_msg)
{
	return;
}

/*
 ********************************************************************
 * Function name: main();
 * Description: recv command from command line and send to mq
 * Parameter:  argc, argv[]
 * Return value: 0:SUCCESS  -1:FAIL
 *********************************************************************
 */
int main(int argc, char *argv[])
{
    int res = 0;
    time_t timesec;
    char buf[128];
    int f;       //flag of whether agent is running.0:runnning, 1: not running

    f = check_agent_status();

    char main_help_msg[2048] = "Usage: tr069 [tr069_object] [tr069_command] [Parameter Value]\n\n";
    char mngsrv_help_msg[2048] = "Usage: tr069 [tr069_object] [tr069_command] [Parameter Value]\n\n";
    char lanconfsec_help_msg[2048] = "Usage: tr069 [tr069_object] [tr069_command] [Parameter Value]\n\n";
    char layer3fwd_help_msg[2048] = "Usage: tr069 [tr069_object] [tr069_command] [Parameter Value]\n\n";
    char landev_help_msg[2048] = "Usage: tr069 [tr069_object] [tr069_command] [Parameter Value]\n\n";
    char wandev_help_msg[2048] = "Usage: tr069 [tr069_object] [tr069_command] [Parameter Value]\n\n";

	init_main_help_msg(main_help_msg);	
	init_mngsrv_help_msg(mngsrv_help_msg);	
	init_lanconfsec_help_msg(lanconfsec_help_msg);	
	init_layer3fwd_help_msg(layer3fwd_help_msg);	
	init_landev_help_msg(landev_help_msg);	
	init_wandev_help_msg(wandev_help_msg);
	
    char acsurl_buf[64] =      "ACS URL:                      ";
    char acsuser_buf[64] =     "ACS User Name:                ";
    char acspwd_buf[64] =      "ACS Password:                 ";
    char informiv_buf[64] =    "Inform Interval:              ";
    char informenable_buf[64] ="Inform Enable:                ";
    char informtime_buf[64] =  "Inform Time:                  ";
    char connreqport_buf[64] = "Connection Request Port:      ";
    /*
     * Date: 2009-03-17
     * Name: Norp Huang
     * Description: add CPE URI for CLI tool(tr069)
     */
	char connrequri_buf[64] =  "Connection Request URI:       ";
    char connrequser_buf[64] = "Connection Request User Name: ";
    char connreqpwd_buf[64] =  "Connection Request Password:  ";
    char retrytimes_buf[64] =  "Retry Times :                 ";
    agent_conf a_conf;
    memset(&a_conf, 0, sizeof(a_conf));
    strcpy(agent_conf_path, AGENT_CONF_PATH);
    if (init_agent_conf() == FAIL) {
        printf("init agent conf failed\n");
        return -1;
    }
    if (get_agent_conf(&a_conf) == FAIL) {
        return -1;
    }

	char confpwd_buf[64] =		"LAN Config Password:         ";
	lansec_conf lans_conf;
	memset(&lans_conf, 0, sizeof(lans_conf));	
    strcpy(lansec_conf_path, LANSEC_CONF_PATH);

    if (init_lansec_conf() == FAIL) {
        printf("init lansec conf failed\n");
        return -1;
    }
    if (get_lansec_conf(&lans_conf) == FAIL) {
        return -1;
    }

	char defconnsrv_buf[64] =			"Default Connection Service:         ";
	char fwdnum_buf[64] =				"Forward Number of Entries:         ";
	char fwding_table_buf[64] = 		"Forwarding table ";
	char fwding_enable_buf[64] = 		"Enable:					";
	char fwding_status_buf[64] = 		"Status:					";
	char fwding_type_buf[64] =			"Type:						";
	char fwding_destipaddr_buf[64] =	"Destination address:		";
	char fwding_destsubmask_buf[64] =	"Destination subnet mask:	";
	char fwding_srcipaddr_buf[64] =		"Source address:			";
	char fwding_srcsubmask_buf[64] =	"Source subnet mask:		";
	char fwding_gwipaddr_buf[64] =		"IP address of the gateway:	";
	char fwding_interface_buf[64] =		"Interface:					";
	char fwding_fwdmetric_buf[64] =		"Forwarding Metric:			";
	char fwding_mtu_buf[64] =			"MTU:						";

	layer3fwd_conf l3fwd_conf;
	memset(&l3fwd_conf, 0, sizeof(l3fwd_conf));	
    strcpy(layer3fwd_conf_path, LAYER3FWD_CONF_PATH);

    if (init_layer3fwd_conf() == FAIL) {
        printf("init layer3fwd conf failed\n");
        return -1;
    }
    if (get_layer3fwd_conf(&l3fwd_conf) == FAIL) {
        return -1;
    }

    if(argc == 1 || argc > 4) {
        printf("%s", main_help_msg);
        
        return 0;
    } 
	else if(argc == 2) {
		if(strcasecmp(argv[1], "mngsrv") == 0) {
        	printf("%s", mngsrv_help_msg);
			return 0;
		} else if(strcasecmp(argv[1], "lanconfsec") == 0) {
        	printf("%s", lanconfsec_help_msg);
			return 0;
		} else if(strcasecmp(argv[1], "layer3fwd") == 0) {
        	printf("%s", layer3fwd_help_msg);
			return 0;
		} else if(strcasecmp(argv[1], "landev") == 0) {
        	printf("%s", landev_help_msg);
			return 0;
		} else if(strcasecmp(argv[1], "wandev") == 0) {
        	printf("%s", wandev_help_msg);
			return 0;
		} else {
        	printf("%s", main_help_msg);
			return 0;
		}
	}
    else if(argc == 3) {
		if(strcasecmp(argv[1], "mngsrv") == 0) {
        	if(strcasecmp(argv[2], "info") == 0) {
        /*
         * Date: 2009-03-17
         * Name: Norp Huang
         * Description: add CPE URI for CLI tool(tr069), use tr069 info for printing
         */
/*
             printf("\t%s%s\n\t%s%s\n\t%s%s\n\t%s%d\n\t%s%d\n\t%s%s\n\t%s%d\n\t%s%s\n\t%s%s\n\t%s%d\n\n", 
                        acsurl_buf,a_conf.acs_url,
                        acsuser_buf, a_conf.acs_username, 
                        acspwd_buf, a_conf.acs_password, 
                        informenable_buf, a_conf.periodic_inform_enable,
                        informiv_buf, a_conf.periodic_inform_interval,
                        informtime_buf, a_conf.periodic_inform_time,
                        connreqport_buf, a_conf.conn_req_ser_port,
                        connrequser_buf, a_conf.conn_req_ser_username,
                        connreqpwd_buf, a_conf.conn_req_ser_password,
                        retrytimes_buf, a_conf.retry_times);
*/
        	     printf("\t%s%s\n\t%s%s\n\t%s%s\n\t%s%d\n\t%s%d\n\t%s%s\n\t%s%d\n\t%s%s\n\t%s%s\n\t%s%s\n\t%s%d\n\n", 
                        acsurl_buf,a_conf.acs_url,
                        acsuser_buf, a_conf.acs_username, 
                        acspwd_buf, a_conf.acs_password, 
                        informenable_buf, a_conf.periodic_inform_enable,
                        informiv_buf, a_conf.periodic_inform_interval,
                        informtime_buf, a_conf.periodic_inform_time,
                        connreqport_buf, a_conf.conn_req_ser_port,
                        connrequri_buf, a_conf.conn_req_ser_uri,
                        connrequser_buf, a_conf.conn_req_ser_username,
                        connreqpwd_buf, a_conf.conn_req_ser_password,
                        retrytimes_buf, a_conf.retry_times);

   		        return 0;

			} else {
	        	printf("%s", mngsrv_help_msg);
				return 0;
			}
		} else if(strcasecmp(argv[1], "lanconfsec") == 0) {
        	if(strcasecmp(argv[2], "info") == 0) {
            	printf("\t%s%s\n\n", confpwd_buf, lans_conf.conf_pwd);
				return 0;
			} else {
				printf("%s", lanconfsec_help_msg);
				return 0;
			} 
		} else if(strcasecmp(argv[1], "layer3fwd") == 0) {
        	if(strcasecmp(argv[2], "info") == 0) {
				int i;
				printf("\t%s%s\n\t%s%d\n", defconnsrv_buf, l3fwd_conf.def_conn_srv,	fwdnum_buf, l3fwd_conf.fwd_nums);

				for (i=0;i<MAX_FWD_NUMS;i++) {
					printf("\t%s%d:\n", fwding_table_buf, i+1);
					printf("\t\t%s%d\n\t\t%s%s\n\t\t%s%s\n\t\t%s%s\n\t\t%s%s\n\t\t%s%s\n\t\t%s%s\n\t\t%s%s\n\t\t%s%s\n\t\t%s%d\n\t\t%s%d\n", 
											fwding_enable_buf, l3fwd_conf.forwarding[i].enable,
											fwding_status_buf, l3fwd_conf.forwarding[i].status,
											fwding_type_buf, l3fwd_conf.forwarding[i].type,
											fwding_destipaddr_buf, l3fwd_conf.forwarding[i].dest_ipaddr,
											fwding_destsubmask_buf, l3fwd_conf.forwarding[i].dest_sub_mask,
											fwding_srcipaddr_buf, l3fwd_conf.forwarding[i].src_ipaddr,
											fwding_srcsubmask_buf, l3fwd_conf.forwarding[i].src_sub_mask,
											fwding_gwipaddr_buf, l3fwd_conf.forwarding[i].gw_ipaddr,
											fwding_interface_buf, l3fwd_conf.forwarding[i].iface,
											fwding_fwdmetric_buf, l3fwd_conf.forwarding[i].fwd_metric,
											fwding_mtu_buf, l3fwd_conf.forwarding[i].mtu);
				}
				printf("\n");
				return 0;
			} else {
				printf("%s", layer3fwd_help_msg);
				return 0;
			}
		} else if(strcasecmp(argv[1], "landev") == 0) {
        	if(strcasecmp(argv[2], "info") == 0) {
				return 0;
			} 
		} else if(strcasecmp(argv[1], "wandev") == 0) {
        	if(strcasecmp(argv[2], "info") == 0) {
				return 0;
			} 
		} else {
				printf("%s", main_help_msg);
				return 0;
		}
    } else {
		if(strcasecmp(argv[1], "mngsrv") == 0) {
        	if(strcasecmp(argv[2], "acsurl") == 0) {
	            if(verifyLength(argv[3], 256) != 0){
    	            printf("The length of acsurl is too long.\n");
                
        	        return -1;
            	}
           		if (strcmp(a_conf.acs_url, argv[3]) == 0){
                	printf("New acsurl is equal with old one.\n");
		
	                return 0;
    	        }
        	    sprintf(buf, "1 %s", argv[3]);
            	strcpy(a_conf.acs_url, argv[3]);
        	}
        	else if(strcasecmp(argv[2], "acsuser") == 0)
        	{
            	if(verifyLength(argv[3], 256) != 0){
                	printf("The length of acsuser is too long.\n");
		
	                return -1;
    	        }
        	    if(isvalidvalue(argv[3]) != 0){
            	    printf("The ACS User Name must be composed of number or character\n");
		
               		return -1;
            	}
           		if (strcmp(a_conf.acs_username, argv[3]) == 0) {
              		printf("New acsUser is same with old one.\n");
		
					return 0;
            	}
                sprintf(buf, "2 %s", ACSUSER);                      
                strcpy(a_conf.acs_username, argv[3]);
        	}
	        else if(strcasecmp(argv[2], "acspwd") == 0)
    	    {
        	    if(verifyLength(argv[3], 256) != 0){
            	    printf("The length of acspwd is too long.\n");
		
                	return -1;
	            }
    	        if(isvalidvalue(argv[3]) != 0){
        	        printf("The ACS password must be composed of number or character\n");
		
            	    return -1;
            	}
            	if (strcmp(a_conf.acs_password, argv[3]) == 0) {
                	printf("New acsPwd is same with old one.\n");
		
                	return 0;
           		}
            	sprintf(buf, "2 %s", ACSPWD);                      
            	strcpy(a_conf.acs_password, argv[3]); 
        	}
        	else if(strcasecmp(argv[2], "interval") == 0)
        	{
            	if(verifyNumber(argv[3]) != 0){
                	printf("The informinterval must be a number.\n");
		
                	return -1;
            	}
            	if(atoi(argv[3]) < 30  ){
                	printf("The interval mustnot less than 30 seconds.\n");
		
	                return -1;
    	        }
        	    if (a_conf.periodic_inform_interval == atoi(argv[3])) {
            	    printf("New informInterval is equal with old one.\n");
		
					return 0;
            	} 
            	sprintf(buf, "5 %s", argv[3]);                      
            	a_conf.periodic_inform_interval = atoi(argv[3]);
        	}
	        else if(strcasecmp(argv[2], "enable") == 0)
    	    {
        	    if(verifyNumber(argv[3]) != 0){
            	    printf("The informenable must be a number.\n");
		
                	return -1;
            	}
	            if(atoi(argv[3]) != 0 && atoi(argv[3]) != 1){
    	            printf("The inform enable is must be 0 or 1.\n");
		
        	        return -1;
            	}
           		if (a_conf.periodic_inform_enable == atoi(argv[3])) {
                	printf("New informenable is equal with old one.\n");
		
				return 0;
        	    } 
            	sprintf(buf, "8 %s", argv[3]);                      
	            a_conf.periodic_inform_enable = atoi(argv[3]);
            
    	    }
        	else if(strcasecmp(argv[2], "time") == 0)
        	{
            	if (strcmp(a_conf.periodic_inform_time, argv[3]) == 0) {
                	printf("New time is equal with old one.\n");
		
					return 0;
            	}
	            timesec = strtimetosec(argv[3]);
    	        if(timesec == -1) {
        	        printf("The time format must be like that:1970-01-01T00:00:00\n");
                
            	    return -1;
            	}
	            sprintf(buf, "9 %ld", timesec);                      
    	        strcpy(a_conf.periodic_inform_time, argv[3]);
        	}
	        else if(strcasecmp(argv[2], "requser") == 0)
    	    {
        	    if(verifyLength(argv[3], 256) != 0){
            	    printf("The length of connrequser is too long.\n");
                
                	return -1;
            	}
	            if(isvalidvalue(argv[3]) != 0){
    	            printf("The Connection Request User Name must be composed of number or character\n");
                
        	        return -1;
            	}
	            if (strcmp(a_conf.conn_req_ser_username, argv[3]) == 0) {
    	            printf("New requser is same with old one.\n");
                
					return 0;
            	}
            	sprintf(buf, "2 %s", REQUSER);                      
            	strcpy(a_conf.conn_req_ser_username, argv[3]);
        	}
	        else if(strcasecmp(argv[2], "reqport") == 0)
    	    {
        	    if(verifyNumber(argv[3]) != 0){
            	    printf("The connreqport must be a number.\n");
                
                	return -1;
	            }
    	        if(atoi(argv[3]) < 1024 || atoi(argv[3]) > 65535){
        	        printf("The value of connreqport must be 1024 - 65535\n");
                
            	    return -1;
	            }
    	        if (a_conf.conn_req_ser_port == atoi(argv[3])) {
        	        printf("New reqport is same with old one.\n");
                
					return 0;
            	}
	            sprintf(buf, "2 %s", REQURL);                      
    	        a_conf.conn_req_ser_port = atoi(argv[3]);
        	    printf("Need reboot agent now.\n");
        	}
	        else if(strcasecmp(argv[2], "reqpwd") == 0)
    	    {
        	    if(verifyLength(argv[3], 256) != 0){
            	    printf("The length of connreqpwd is too long.\n");
                
                	return -1;
	            }
    	        if(isvalidvalue(argv[3]) != 0){
        	        printf("The Connection Request Password must be composed of number or character\n");
                
            	    return -1;
	            }
    	        if (strcmp(a_conf.conn_req_ser_password, argv[3]) == 0){
        	        printf("New reqpwd is equal with old one.\n");
                
					return 0;
            	}
	            sprintf(buf, "2 %s", REQPWD);                      
    	        strcpy(a_conf.conn_req_ser_password, argv[3]);
        	}
	        else if(strcasecmp(argv[2], "retrytimes") == 0)
    	    {
        	    if(verifyNumber(argv[3]) != 0){
            	    printf("The retrytimes must be a number.\n");
                
                	return -1;
	            }
    	        if(atoi(argv[3]) < 0 ||atoi(argv[3]) > 99 ){
        	        printf("The value of retry times must be 1 - 99.\n");
                
            	    return -1;
	            }
    	        if (a_conf.retry_times == atoi(argv[3])) {
        	        printf("New retrytimes is equal with old one.\n");
                
					return 0;
            	}
		        sprintf(buf, "4 %s", argv[3]);                      
        	    a_conf.retry_times = atoi(argv[3]);
            
        	}
	        /*
    	     * Date: 2009-03-17
        	 * Name: Norp Huang
	         * Description: add CPE URI in agent.conf
    	     */
        	else if(strcasecmp(argv[2], "requri") == 0)
	        {   
    	        if(verifyLength(argv[3], 256) != 0){
        	        printf("The length of CPE URI is too long.\n");
                
            	    return -1;
            	}
	            if (strcmp(a_conf.conn_req_ser_uri, argv[3]) == 0){
    	            printf("New CPE URI is equal with old one.\n");
		
        	        return 0;
            	}
	            sprintf(buf, "2 %s", argv[3]);
    	        strcpy(a_conf.conn_req_ser_uri, argv[3]);
    	    }
        	else
        	{
            	printf("%s", mngsrv_help_msg);
	            return 0;
        	}
		
		    if (set_agent_conf(&a_conf) == FAIL) {
        	    return -1;
    	   	}
		    printf("Set openagent_agent.conf success\n");
    	    if(!f){
        		res = cli_set_tr069(buf, "agent");
            	if(res != 0) {
                	printf("Set parameter failed.\n");
	                return -1;
    	        }
        	}
		} else if(strcasecmp(argv[1], "lanconfsec") == 0) {
			if (strcasecmp(argv[2], "confpwd") == 0) {
        	    if(verifyLength(argv[3], 64) != 0){
            	    printf("The length of confpwd is too long.\n");
                	return -1;
	            }
    	        if(isvalidvalue(argv[3]) != 0){
        	        printf("The LAN Config Password must be composed of number or character\n");
            	    return -1;
	            }
    	        if (strcmp(lans_conf.conf_pwd, argv[3]) == 0){
        	        printf("New confpwd is equal with old one.\n");
					return 0;
            	}
	            sprintf(buf, "2 %s", argv[3]); //TODO??
    	        strcpy(lans_conf.conf_pwd, argv[3]);

			} else {
            	printf("%s", lanconfsec_help_msg);
	            return 0;
			}
	
		    if (set_lansec_conf(&lans_conf) == FAIL) {
            	return -1;
    	   	}
	    	printf("Set openagent_agent_lansec.conf success\n");
	        if(!f){
    	    	res = cli_set_tr069(buf, "lansec");
        	    if(res != 0) {
            	    printf("Set parameter failed.\n");
                	return -1;
	            }
    	    }
		} else if(strcasecmp(argv[1], "layer3fwd") == 0) {
			if (strcasecmp(argv[2], "defconnsrv") == 0) {
        	    if(verifyLength(argv[3], 256) != 0){
            	    printf("The length of defconnsrv is too long.\n");
                	return -1;
	            }
    	        if (strcmp(l3fwd_conf.def_conn_srv, argv[3]) == 0){
        	        printf("New defconnsrv is equal with old one.\n");
					return 0;
            	}
	            sprintf(buf, "2 %s", argv[3]); //TODO??
    	        strcpy(l3fwd_conf.def_conn_srv, argv[3]);

			} else if (strcasecmp(argv[2], "fwdnums") == 0) { // set fwdnums is needed?
            	if(verifyNumber(argv[3]) != 0){
            	    printf("The fwdnums must be a number.\n");
                	return -1;
	            }
    	        if(atoi(argv[3]) < 0){
        	        printf("The value of retry times must be >= 0.\n");
            	    return -1;
	            }
 
    	        if (l3fwd_conf.fwd_nums == atoi(argv[3])){
        	        printf("New fwdnums is equal with old one.\n");
					return 0;
            	}
	            sprintf(buf, "2 %d", atoi(argv[3])); //TODO??
    	        l3fwd_conf.fwd_nums = atoi(argv[3]);

			} else if (strncasecmp(argv[2], "fwding_", 7) == 0) { 
				char index[4], command[16];
				strncpy(index, argv[2] + 7, 1);

            	if(verifyNumber(index) != 0){
            		printf("%s", layer3fwd_help_msg);
		            return 0;
            	}

				if (atoi(index) > 3 || atoi(index) < 1) {
            		printf("%s", layer3fwd_help_msg);
		            return 0;
				}

				strncpy(command, argv[2] + 9, strlen(argv[2]) - 9);
				if(strcasecmp(command, "enable") == 0) {
	            	if(verifyNumber(argv[3]) != 0){
            	    	printf("The fwding_%s_enable must be a number.\n" ,index);
			            return -1;
            		}
					if(atoi(argv[3]) > 1 || atoi(argv[3]) < 0){
            	    	printf("The number must be 0 or 1.\n");
			            return -1;
					}
	    	        if (l3fwd_conf.forwarding[atoi(index)].enable == atoi(argv[3])){
    	    	        printf("New fwding_%s_enable is equal with old one.\n", index);
						return 0;
            		}
		            sprintf(buf, "2 %d", atoi(argv[3])); //TODO??
    		        l3fwd_conf.forwarding[atoi(index)].enable = atoi(argv[3]);
	
				} else if(strcasecmp(command, "status") == 0) {

        	    	if(!(strcasecmp(argv[3], "Disable") == 0 || strcasecmp(argv[3], "Enabled") == 0 || strcasecmp(argv[3], "Error") == 0)) {
					 	printf("The fwding_%s_status must be \"Disbale\", \"Enable\" or \"Error\".\n", index);
			            return -1;
}
	    	        if (strcmp(l3fwd_conf.forwarding[atoi(index)].status, argv[3]) == 0){
    	    	        printf("New fwding_%s_status is equal with old one.\n", index);
						return 0;
            		}
		            sprintf(buf, "2 %d", atoi(argv[3])); //TODO??
					strcpy(l3fwd_conf.forwarding[atoi(index)].status, argv[3]);

				} else if(strcasecmp(command, "type") == 0) {
        	    	if(!(strcasecmp(argv[3], "Default") == 0 || strcasecmp(argv[3], "Network") == 0 || strcasecmp(argv[3], "Host") == 0)) {
					 	printf("The fwding_%s_type must be \"Default\", \"Network\" or \"Host\".\n", index);
			            return -1;
}
	    	        if (strcmp(l3fwd_conf.forwarding[atoi(index)].type, argv[3]) == 0){
    	    	        printf("New fwding_%s_type is equal with old one.\n", index);
						return 0;
            		}
		            sprintf(buf, "2 %d", atoi(argv[3])); //TODO??
    		        strcpy(l3fwd_conf.forwarding[atoi(index)].type,argv[3]);

				} else if(strcasecmp(command, "destipaddr") == 0) {
	        	    if(verifyLength(argv[3], 12) != 0){
    	        	    printf("The length of fwding_%s_destipaddr is too long.\n", index);
        	        	return -1;
	        	    }
	    	        if (strcmp(l3fwd_conf.forwarding[atoi(index)].dest_ipaddr, argv[3]) == 0){
    	    	        printf("New fwding_%s_destipaddr is equal with old one.\n", index);
						return 0;
            		}
		            sprintf(buf, "2 %d", atoi(argv[3])); //TODO??
    		        strcpy(l3fwd_conf.forwarding[atoi(index)].dest_ipaddr, argv[3]);
				} else if(strcasecmp(command, "destsubmsk") == 0) {
	        	    if(verifyLength(argv[3], 12) != 0){
    	        	    printf("The length of fwding_%s_destsubmask is too long.\n", index);
        	        	return -1;
	        	    }
	    	        if (strcmp(l3fwd_conf.forwarding[atoi(index)].dest_sub_mask, argv[3]) == 0){
    	    	        printf("New fwding_%s_dest_sub_mask is equal with old one.\n", index);
						return 0;
            		}
		            sprintf(buf, "2 %d", atoi(argv[3])); //TODO??
    		        strcpy(l3fwd_conf.forwarding[atoi(index)].dest_sub_mask, argv[3]);
				} else if(strcasecmp(command, "srcipaddr") == 0) {
	        	    if(verifyLength(argv[3], 12) != 0){
    	        	    printf("The length of fwding_%s_srcipaddr is too long.\n", index);
        	        	return -1;
	        	    }
	    	        if (strcmp(l3fwd_conf.forwarding[atoi(index)].src_ipaddr, argv[3]) == 0){
    	    	        printf("New fwding_%s_srcipaddr is equal with old one.\n", index);
						return 0;
            		}
		            sprintf(buf, "2 %d", atoi(argv[3])); //TODO??
    		        strcpy(l3fwd_conf.forwarding[atoi(index)].src_ipaddr, argv[3]);
				} else if(strcasecmp(command, "srcsubmask") == 0) {
	        	    if(verifyLength(argv[3], 12) != 0){
    	        	    printf("The length of fwding_%s_srcsubmask is too long.\n", index);
        	        	return -1;
	        	    }

	    	        if (strcmp(l3fwd_conf.forwarding[atoi(index)].src_sub_mask, argv[3]) == 0){
    	    	        printf("New fwding_%s_srcsubmask is equal with old one.\n", index);
						return 0;
            		}
		            sprintf(buf, "2 %d", atoi(argv[3])); //TODO??
    		        strcpy(l3fwd_conf.forwarding[atoi(index)].src_sub_mask, argv[3]);
				} else if(strcasecmp(command, "gwipaddr") == 0) {
	        	    if(verifyLength(argv[3], 12) != 0){
    	        	    printf("The length of fwding_%s_gwipaddr is too long.\n", index);
        	        	return -1;
	        	    }

	    	        if (strcmp(l3fwd_conf.forwarding[atoi(index)].gw_ipaddr, argv[3]) == 0){
    	    	        printf("New fwding_%s_gwipaddr is equal with old one.\n", index);
						return 0;
            		}
		            sprintf(buf, "2 %d", atoi(argv[3])); //TODO??
    		        strcpy(l3fwd_conf.forwarding[atoi(index)].gw_ipaddr, argv[3]);
				} else if(strcasecmp(command, "iface") == 0) {	
	        	    if(verifyLength(argv[3], 256) != 0){
    	        	    printf("The length of fwding_%s_iface is too long.\n", index);
        	        	return -1;
	        	    }
	    	        if (strcmp(l3fwd_conf.forwarding[atoi(index)].iface, argv[3]) == 0){
    	    	        printf("New fwding_%s_iface is equal with old one.\n", index);
						return 0;
            		}
		            sprintf(buf, "2 %d", atoi(argv[3])); //TODO??
    		        strcpy(l3fwd_conf.forwarding[atoi(index)].iface, argv[3]);
				} else if(strcasecmp(command, "fwdmetric") == 0) {
	            	if(verifyNumber(argv[3]) != 0){
            	    	printf("The fwding_%s_fwmetric must be a number.\n", index);
			            return -1;
            		}
	    	        if (l3fwd_conf.forwarding[atoi(index)].mtu == atoi(argv[3])){
    	    	        printf("New fwding_%s_mtu is equal with old one.\n", index);
						return 0;
            		}
		            sprintf(buf, "2 %d", atoi(argv[3])); //TODO??
    		        l3fwd_conf.forwarding[atoi(index)].mtu = atoi(argv[3]);

				} else if(strcasecmp(command, "mtu") == 0) {
	            	if(verifyNumber(argv[3]) != 0){
            	    	printf("The fwding_%s_mtu must be a number.\n", index);
			            return -1;
            		}
					if(atoi(argv[3]) < 1 || atoi(argv[3]) > 1540){
            	    	printf("The number must be between 1 to 1540.\n");
			            return -1;
					}
	    	        if (l3fwd_conf.forwarding[atoi(index)].mtu == atoi(argv[3])){
    	    	        printf("New fwding_%s_mtu is equal with old one.\n", index);
						return 0;
            		}
		            sprintf(buf, "2 %d", atoi(argv[3])); //TODO??
    		        l3fwd_conf.forwarding[atoi(index)].mtu = atoi(argv[3]);

				}
				
/*        	    if(verifyNumber(argv[3]) != 0){
            	    printf("The fwdnums must be a number.\n");
                	return -1;
	            }
    	        if(atoi(argv[3]) < 0){
        	        printf("The value of retry times must be >= 0.\n");
            	    return -1;
	            }
 
    	        if (strcmp(l3fwd_conf.fwd_nums, argv[3]) == 0){
        	        printf("New fwdnums is equal with old one.\n");
					return 0;
            	}
	            //sprintf(buf, "2 %s", argv[3]); //TODO??
    	        strcpy(l3fwd_conf.fwd_nums, argv[3]);
*/
			}else {
            	printf("%s", layer3fwd_help_msg);
	            return 0;
			}
	
		    if (set_layer3fwd_conf(&l3fwd_conf) == FAIL) {
            	return -1;
    	   	}
	    	printf("Set openagent_agent_layer3fwd.conf success\n");
	        if(!f){
    	    	res = cli_set_tr069(buf, "layer3fwd");
        	    if(res != 0) {
            	    printf("Set parameter failed.\n");
                	return -1;
	            }
    	    }
		}
//	    if (set_agent_conf(&a_conf) == FAIL) {
//            return -1;
//       	}
//	    printf("Set openagent_agent.conf success\n");
//        if(!f){
//        	res = cli_set_tr069(buf, "agent");
//            if(res != 0) {
//                printf("Set parameter failed.\n");
//                return -1;
//            }
//        }
    }
    
    return 0; 
}