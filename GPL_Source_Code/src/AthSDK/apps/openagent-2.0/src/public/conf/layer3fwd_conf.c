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
 * Name: Norp Huang
 * Date: 2009-04-23
 * Description: CLI tool to control InternetGatewayDevice.LANConfigSecurity parameters, refer to tr069_cli.c
 */

/***********************************************************************
*
*	include file
*
***********************************************************************/
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>

#include "layer3fwd_conf.h"

/*
 ***********************************************************************
 * Function name: get_layer3fwd_conf
 * Description: get the Layer3Forwarding information of agent
 * Parameter: layer3fwd_conf *pconf -- pointer to layer3 forwarding configure struct
 * Return Value: LAYER3FWD_SUCCESS: 0 LAYER3FWD_FAIL: -1 
 * *********************************************************************
 */
int get_layer3fwd_conf(layer3fwd_conf *pconf)
{
    FILE *fp = NULL;
    char info_buf[4096];
    char *pstr = NULL, *pstr_bk = NULL;
    char tmp[32];
    int i = 0;

    /*init variable*/
    memset(info_buf, 0, sizeof(info_buf));
    memset(pconf, 0, sizeof(layer3fwd_conf));

    if (access(layer3fwd_conf_path, F_OK) == -1) {
        printf( "File %s not exist\n", layer3fwd_conf_path);
        return LAYER3FWD_FAIL;
    }

    fp = fopen(layer3fwd_conf_path, "r");
    if (fp == NULL) {
        printf( "Can't open file %s\n", layer3fwd_conf_path);
        return LAYER3FWD_FAIL;
    }

    if (fread(info_buf, sizeof(char), sizeof(info_buf), fp) <= 0) {
        printf( "Read file %s error\n", layer3fwd_conf_path);
        fclose(fp);
        return LAYER3FWD_FAIL;
    }
    
    fclose(fp);
    
    /*get parameter value*/
    pstr = info_buf;
    while (pstr != NULL) {
        pstr_bk = strstr(pstr, "\n");
        if (pstr_bk != NULL) {
            memset(tmp, 0, sizeof(tmp));
            i++;
            switch (i) {
                case 1:
                    //strncpy(pconf->conf_pwd, pstr, pstr_bk - pstr);
                    break;
                default:
                    //printf("ERROR\n");
                    //return LAYER3FWD_FAIL;
                    break;
            }
            pstr = pstr_bk + 1;
        } else {
            pstr = pstr_bk;
        }
    }

    return LAYER3FWD_SUCCESS;
}

/*
 ************************************************************************
 * Function name:set_layer3fwd_conf()
 * Description: set the Layer3Forwarding information to file
 * Parameter:layer3fwd_conf *pconf -- pointer to the layer3 forwarding configure struct
 * Return value: LAYER3FWD_SUCCESS:0 LAYER3FWD_FAIL:-1
 ************************************************************************
 */
int set_layer3fwd_conf(layer3fwd_conf *pconf)
{
    FILE *fp = NULL;
	char tmp[512] = {};
	int i = 0;

    fp = fopen(layer3fwd_conf_path, "w");
    if (fp == NULL) {
        printf( "Can't open file %s\n", layer3fwd_conf_path);
        return LAYER3FWD_FAIL;
    }

    fprintf(fp, "%s\n%d\n", pconf->def_conn_srv, pconf->fwd_nums);

	memset(tmp, 0, sizeof(tmp));

	for (i=0;i<MAX_FWD_NUMS;i++)
	{
		sprintf(tmp, "%d\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%d\n%d\n",
					pconf->forwarding[i].enable, pconf->forwarding[i].status, pconf->forwarding[i].type, 
					pconf->forwarding[i].dest_ipaddr, pconf->forwarding[i].dest_sub_mask, 
					pconf->forwarding[i].src_ipaddr, pconf->forwarding[i].src_sub_mask,
					pconf->forwarding[i].gw_ipaddr, pconf->forwarding[i].iface,
					pconf->forwarding[i].fwd_metric, pconf->forwarding[i].mtu);

    	fprintf(fp, "%s", tmp); 
		memset(tmp,0, sizeof(tmp));
	}

    fclose(fp);

    return LAYER3FWD_SUCCESS;
}
/*
 *********************************************************************
 * Function name: init_layer3fwd_conf()
 * Description: init the layer3 forwading configure file
 * Parameter: void
 * Retrun value:  LAYER3FWD_SUCCESS:0  LAYER3FWD_FAIL:-1
 *********************************************************************
 */
int init_layer3fwd_conf()
{
    layer3fwd_conf _conf;
	int i;

    if (access(layer3fwd_conf_path, F_OK) == -1) {
        printf( "File %s is not exist\n", layer3fwd_conf_path);
        /*Use default value to write configure file*/
        memset(&_conf, 0, sizeof(_conf));

        strcpy(_conf.def_conn_srv, LAYER3FWD_DEF_CONN_SRV);
        _conf.fwd_nums =  LAYER3FWD_FWD_NUMS;
		for (i=0;i<MAX_FWD_NUMS;i++) 
		{
			_conf.forwarding[i].enable = LAYER3FWD_FWDING_ENABLE;
	        strcpy(_conf.forwarding[i].status, LAYER3FWD_FWDING_STATUS);
	        strcpy(_conf.forwarding[i].type, LAYER3FWD_FWDING_TYPE);
	        strcpy(_conf.forwarding[i].dest_ipaddr, LAYER3FWD_FWDING_DEST_IPADDR);
	        strcpy(_conf.forwarding[i].dest_sub_mask, LAYER3FWD_FWDING_DEST_SUB_MASK);
	        strcpy(_conf.forwarding[i].src_ipaddr, LAYER3FWD_FWDING_SRC_IPADDR);
	        strcpy(_conf.forwarding[i].src_sub_mask, LAYER3FWD_FWDING_SRC_SUB_MASK);
	        strcpy(_conf.forwarding[i].gw_ipaddr, LAYER3FWD_FWDING_GW_IPADDR);
	        strcpy(_conf.forwarding[i].iface, LAYER3FWD_FWDING_IFACE);
			_conf.forwarding[i].fwd_metric = LAYER3FWD_FWDING_METRIC;
			_conf.forwarding[i].mtu = LAYER3FWD_FWDING_MTU;
		}

        /*write to configure file*/
        if (set_layer3fwd_conf(&_conf) == LAYER3FWD_FAIL) {
            printf("Set layer3fwd info error\n");
            return LAYER3FWD_FAIL;
        }
    }
    return LAYER3FWD_SUCCESS;
}
