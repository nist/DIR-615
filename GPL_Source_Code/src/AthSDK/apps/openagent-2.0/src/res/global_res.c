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

/**********************************************************************
*
*	global_res.c - module routines for Agent
*
*	history: 2005-12-27, initial version by leon.liu
*
***********************************************************************/


/***********************************************************************
*
*	include file
*
***********************************************************************/
#include "global_res.h"
#include "agent_conf.h" // ../public/conf/agent_conf.h
#include "lansec_conf.h" // ../public/conf/lansec_conf.h
#include "layer3fwd_conf.h" // ../public/conf/layer3fwd_conf.h
#include "landev_conf.h" // ../public/conf/landev_conf.h
#include "wandev_conf.h" // ../public/conf/wandev_conf.h

/************************************************************************
*
*	global var define
*
************************************************************************/

/*
***********************************************************************
* Function name: post_signal
* Description: send signal sig to thread pth
* Parameters: int sig
* Return : SUCCESS FAIL
***********************************************************************
*/
int post_signal(pthread_t pth, int sig)
{
    int res;
    
    if( pth <= 0 ) {
        return FAIL;
    }

    res = pthread_kill(pth, sig);
    if(res != 0) {
        LOG(m_res, ERROR, "send signal to thread failed\n");
        return FAIL;
    }
	
    LOG(m_res, DEBUG, "send signal to thread success\n");

    return SUCCESS;
}

/*
***********************************************************************
* Function name: init_connnected
* Description: Initialize try_time and try_time_lock.
* Parameters: none
* Return: SUCCESS FAIL
**********************************************************************
*/
int init_try_time()
{
    int res;
    inform_retry = 0;

    res = pthread_mutex_init(&try_time_lock, NULL);
    if(res != 0) {
        LOG(m_res, ERROR, "Mutex try_time initialization failed.\n");
        return FAIL;
    } else {
        LOG(m_res, DEBUG, "Mutex try_time initialization success\n");
    }

    return SUCCESS;
}
/*
***********************************************************************
* Function name: get_max_try_time
* Description: get max try time.
* Parameters: none
* Return: SUCCESS FAIL
**********************************************************************
*/
int get_max_try_time()
{
    int result;
 
    pthread_mutex_lock(&try_time_lock);
    result = max_try_time;
    pthread_mutex_unlock(&try_time_lock);
 
    return result;
}
/*
***********************************************************************
* Function name: set_max_try_time
* Description: set max try time.
* Parameters: max try time
* Return: void
**********************************************************************
*/
void set_max_try_time(int time)
{
    pthread_mutex_lock(&try_time_lock);
    max_try_time = time;
    pthread_mutex_unlock(&try_time_lock);
}

/*
***********************************************************************
* Function name: reset_sys_sem
* Description: reset Agent system semaphore (SEM_SEND, SEM_RECV)
* Parameters: none
* Return :SUCCESS FAIL
***********************************************************************
*/
int reset_sys_sem()
{
    sem_destroy(&SEM_SEND);
    sem_destroy(&SEM_RECV);
    sem_destroy(&SEM_HANDLER_ABORT);

    sem_init(&SEM_SEND, 0, 0);
    sem_init(&SEM_RECV, 0, 0);
    sem_init(&SEM_HANDLER_ABORT, 0, 0);

    return SUCCESS;
}

/*
***********************************************************************
* Function name: init_conf_path
* Description: Initialize the path of all configure file
* Parameters: none
* Return: SUCCESS FAIL
***********************************************************************
*/
int init_conf_path()
{
    DIR *dp;
    char *xml_conf_dir = "/etc/openagent/";

    /*check the validity of conf_dir*/
    if((conf_dir[0] != '/') || (conf_dir[strlen(conf_dir)-1] != '/')) {
	 /* modify by keelsonz(LOG->printf) */
         //printf("the path of configure file directory should be /dir/.\n");
         printf("use -F to give the path of configure file directory, e.g. \"agent -F /var/etc/\"\n");
	 return FAIL;
    }
    if((dp = opendir(conf_dir)) == NULL) {
         printf("can not open directory: %s\n", conf_dir);
	 return FAIL;
    }

	sprintf(conf_dir, "%s%s", conf_dir, "openagent_");

    sprintf(dl_conf_path, "%sdl.conf", conf_dir);
    sprintf(rbc_conf_path, "%srbc.conf", conf_dir);
    sprintf(attri_conf_path, "%sattri.conf", conf_dir);
    sprintf(conn_req_conf_path, "%sconn_req.conf", conf_dir);

    sprintf(log_file_bak, "%scpe.log.bak", conf_dir);
    //sprintf(param_conf_path, "%sparam.xml", conf_dir);
    sprintf(param_conf_path, "%sparam.xml", xml_conf_dir);
    sprintf(agent_conf_path, "%sagent.conf", conf_dir);
	/*
 	 * Name: Norp Huang
 	 * Date: 2009-04-23
 	 * Description: add new configuration paths for commucation between ACS/CPE.
 	 */
    sprintf(lansec_conf_path, "%slansec.conf", conf_dir); //InternetGatewayDevice.LANConfigSecurity
    sprintf(landev_conf_path, "%slandev.conf", conf_dir); //InternetGatewayDevice.LANDevice
    sprintf(layer3fwd_conf_path, "%slayer3fwd.conf", conf_dir); //InternetGatewayDevice.Layer3Forwarding
    sprintf(wandev_conf_path, "%swandev.conf", conf_dir); //InternetGatewayDevice.WANDevice
    closedir(dp);
    return SUCCESS;
}

/*
**********************************************************************
* Function name: dev_get_cur_time
* Description: get current time, it's the seconds since boot
* Parameters:none
* Return: The seconds since boot.
**********************************************************************
*/
time_t dev_get_cur_time()
{
    time_t cur_time;

    cur_time = time((time_t *)0);
    LOG(m_device, DEBUG, "current time is %ld\n", cur_time);

    return cur_time;
}


