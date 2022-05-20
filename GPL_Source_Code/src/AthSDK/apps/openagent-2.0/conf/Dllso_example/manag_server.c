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


/*
 * $Author: norp_huang $
 * $Date: 2009/05/25 09:16:48 $
 */

#include <unistd.h>
#include <time.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#include "agent_conf.h" // ../../src/public/conf/agent_conf.h

#include "xml.h"

static int dev_get_wan_ip(char *ip_addr);

//manageserver
int dev_ManageServer_URL(int opt_flag, void *mthdval_struct, int locate[])
{
    agent_conf a_conf;
    int ret = -1;

    if (get_agent_conf(&a_conf) == AGENT_CONF_FAILED) {
        return ret;
    }
    if (!opt_flag) {
        strcpy((char *)mthdval_struct, a_conf.acs_url);
        ret = 0;
    } else {
        strcpy(a_conf.acs_url, (char *)mthdval_struct);
        if (set_agent_conf(&a_conf) == AGENT_CONF_SUCCESS) {
            ret = 0;
        }
    }
    
    return ret;
}
int dev_ManageServer_Username(int opt_flag, void *mthdval_struct, int locate[])
{
    agent_conf a_conf;
    int ret = -1;

    if (!opt_flag) {
        printf("ManageServer username is Unreadable\n");
        strcpy((char *)mthdval_struct, ""); // give null value.
        ret = 0;
    } else {
        if (get_agent_conf(&a_conf) == AGENT_CONF_SUCCESS) {
            strcpy(a_conf.acs_username, (char *)mthdval_struct);
            if (set_agent_conf(&a_conf) == AGENT_CONF_SUCCESS) {
                ret = 0;
            }
        }
    }

    return ret;
}
int dev_ManageServer_Password(int opt_flag, void *mthdval_struct, int locate[])
{
    agent_conf a_conf;
    int ret = -1;

    if (!opt_flag) {
        strcpy((char *)mthdval_struct, "");
        ret = 0;
    } else {
        if (get_agent_conf(&a_conf) == AGENT_CONF_SUCCESS) {
            strcpy(a_conf.acs_password, (char *)mthdval_struct);
            if (set_agent_conf(&a_conf) == AGENT_CONF_SUCCESS) {
                ret = 0;
            }
        }
    }

    return ret;
}
int dev_ManageServer_PeriodicInformEnable(int opt_flag, void *mthdval_struct, int locate[])
{
    agent_conf a_conf;
    int ret = -1;

    if (get_agent_conf(&a_conf) == AGENT_CONF_FAILED) {
        return ret;
    }
    if (!opt_flag) {
        *(int *)mthdval_struct = a_conf.periodic_inform_enable;
        ret = 0;
    } else {
        a_conf.periodic_inform_enable = *(unsigned short *)mthdval_struct;
        if (set_agent_conf(&a_conf) == AGENT_CONF_SUCCESS) {
            ret = 1;
        }
    }

    return ret;
}
int dev_ManageServer_PeriodicInformInterval(int opt_flag, void *mthdval_struct, int locate[])
{
    agent_conf a_conf;
    int ret = -1;

    if (get_agent_conf(&a_conf) == AGENT_CONF_FAILED) {
        return ret;
    }
    if (!opt_flag) {
        *(unsigned int *)mthdval_struct = a_conf.periodic_inform_interval;
        ret = 0;
    } else {
        a_conf.periodic_inform_interval = *(unsigned int *)mthdval_struct;
        if (set_agent_conf(&a_conf) == AGENT_CONF_SUCCESS) {
            ret = 1;
        }
    }

    return ret;
}
int dev_ManageServer_PeriodicInformTime(int opt_flag, void *mthdval_struct, int locate[])
{
    agent_conf a_conf;
    //time_t temp;
    int ret = -1;

    if (get_agent_conf(&a_conf) == AGENT_CONF_FAILED) {
        return ret;
    }
    if (!opt_flag) {
        strcpy((char *)mthdval_struct, a_conf.periodic_inform_time);
        ret = 0;
    } else {
        strcpy(a_conf.periodic_inform_time, (char *)mthdval_struct);
        if (set_agent_conf(&a_conf) == AGENT_CONF_SUCCESS) {
            /*temp = strtimetosec((char *)mthdval_struct);
            if (temp != -1) {
                set_period_time(temp);
                ret = 1;
            } else {
                printf("Transfer time to seconds error\n");
            }*/
            ret = 1;
        }
    }

    return ret;
}
int dev_ManageServer_ParameterKey(int opt_flag, void *mthdval_struct, int locate[])
{
    agent_conf a_conf;
    int ret = -1;

    if (get_agent_conf(&a_conf) == AGENT_CONF_FAILED) {
        return ret;
    }
    if (!opt_flag) {
        strcpy((char *)mthdval_struct, a_conf.parameterkey);
        ret = 0;
    } else {
        strcpy(a_conf.parameterkey, (char *)mthdval_struct);
        if (set_agent_conf(&a_conf) == AGENT_CONF_SUCCESS) {
            ret = 0;
        }
    }

    return ret;
}
int dev_ManageServer_ConnectionRequestURL(int opt_flag, void *mthdval_struct, int locate[])
{
    agent_conf a_conf;
    int ret = -1;
    char wan_ipaddr[32];
    
    memset(wan_ipaddr, 0, sizeof(wan_ipaddr));
    
    if (!opt_flag) {
        if (get_agent_conf(&a_conf) == AGENT_CONF_SUCCESS) {
            if (dev_get_wan_ip(wan_ipaddr) == 0) {
                /*
                 * Date: 2009-03-17 
                 * Name: Norp Huang 
                 * Description: get CPE URI path instead "0" 
                 */
                //sprintf((char *)mthdval_struct, "http://%s:%d/%d", wan_ipaddr, a_conf.conn_req_ser_port, 0);
                sprintf((char *)mthdval_struct, "http://%s:%d/%s", wan_ipaddr, a_conf.conn_req_ser_port, a_conf.conn_req_ser_uri);
            }
            ret = 0;
        }
    } else {
        printf("Connection Request URL is Unwriteable\n");
    }

    return ret;
}
int dev_ManageServer_ConnectionRequestUsername(int opt_flag, void *mthdval_struct, int locate[])
{
    agent_conf a_conf;
    int ret = -1;

    if (get_agent_conf(&a_conf) == AGENT_CONF_FAILED) {
        return ret;
    }
    if (!opt_flag) {
        strcpy((char *)mthdval_struct, a_conf.conn_req_ser_username);
        ret = 0;
    } else {
        strcpy(a_conf.conn_req_ser_username, (char *)mthdval_struct);
        if (set_agent_conf(&a_conf) == AGENT_CONF_SUCCESS) {
            ret = 0;
        }
    }

    return ret;
}
int dev_ManageServer_ConnectionRequestPassword(int opt_flag, void *mthdval_struct, int locate[])
{
    agent_conf a_conf;
    int ret = -1;

    if (!opt_flag) {
		printf("dev_ManageServer_ConnectionRequestPassword is Unreadable\n");		
        strcpy((char *)mthdval_struct, ""); // give null value
        ret = 0;
    } else {
        if (get_agent_conf(&a_conf) == AGENT_CONF_SUCCESS) {
            strcpy(a_conf.conn_req_ser_password, (char *)mthdval_struct);
            if (set_agent_conf(&a_conf) == AGENT_CONF_SUCCESS) {
                ret = 0;
            }
        }
    }

    return ret;
}
int dev_ManageServer_UpgradesManaged(int opt_flag, void *mthdval_struct, int locate[])
{
	agent_conf a_conf;
	int ret = -1;

    if (get_agent_conf(&a_conf) == AGENT_CONF_FAILED) {
        return ret;
    }
    if (!opt_flag) {
        *(int *)mthdval_struct = a_conf.upgrade_manage;
        ret = 0;
    } else {
        a_conf.upgrade_manage =  *(unsigned short *)mthdval_struct;
        if (set_agent_conf(&a_conf) == AGENT_CONF_SUCCESS) {
            ret = 0;
        }
    }

	return ret;
}
int dev_ManageServer_KickURL(int opt_flag, void *mthdval_struct, int locate[]) //Optional
{
    if (!opt_flag) // get function
        return 0;
    else           // set function
        return 0;
}
int dev_ManageServer_DownloadProgressURL(int opt_flag, void *mthdval_struct, int locate[]) //Optional
{
    if (!opt_flag) // get function
        return 0;
    else           // set function
        return 0;
}


static int dev_get_wan_ip(char *ip_addr)
{
    int s;
    struct ifconf conf;
    struct ifreq *ifr;
    char buff[2048];
    int num;
    int i;

    s = socket(PF_INET, SOCK_DGRAM, 0);
    conf.ifc_len = 2048;
    conf.ifc_buf = buff;

    ioctl(s, SIOCGIFCONF, &conf);
    num = conf.ifc_len / sizeof(struct ifreq);
    ifr = conf.ifc_req;

    for(i=0;i < num;i++)
    {
        struct sockaddr_in *sin = (struct sockaddr_in *)(&ifr->ifr_addr);

        ioctl(s, SIOCGIFFLAGS, ifr);
        if(((ifr->ifr_flags & IFF_LOOPBACK) == 0) && (ifr->ifr_flags & IFF_UP))
        {
            sprintf(ip_addr, "%s", inet_ntoa(sin->sin_addr));
            close(s);
            return 0;
        }
        ifr++;
    }
    close(s);
    return 0;
}
