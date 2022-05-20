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
 * $Author $
 * $Date: 2009/05/25 09:16:48 $
 */
                                                                                                                             
//#include "stdlib.h"
#include <stdio.h>
#include <string.h>
#include "layer3fwd_conf.h" // ../../src/public/conf/layer3fwd_conf.h

//Layer3Forwarding
int dev_Layer3_DefaultConnectionService(int opt_flag, void *mthdval_struct, int locate[])
{
    layer3fwd_conf _conf;
    int ret = -1;

    if (get_layer3fwd_conf(&_conf) == LAYER3FWD_FAIL) {
        return ret;
    }
    if (!opt_flag) {
        strcpy((char *)mthdval_struct, _conf.def_conn_srv);
        ret = 0;
    } else {
        strcpy(_conf.def_conn_srv, (char *)mthdval_struct);
        if (set_layer3fwd_conf(&_conf) == LAYER3FWD_SUCCESS) {
            ret = 0;
        }
    }
    
    return ret;
}
int dev_Layer3_ForwardNumberOfEntries(int opt_flag, void *mthdval_struct, int locate[])
{
    layer3fwd_conf _conf;
    int ret = -1;

    if (!opt_flag) {
        if (get_layer3fwd_conf(&_conf) == LAYER3FWD_SUCCESS) {
                *(unsigned short *)mthdval_struct = _conf.fwd_nums; 
            ret = 0;
        }
    } else {
        printf("Layer3Forwarding ForwardNumberOfEntries is Unwriteable\n");
    }

    return ret;

}
//Forwarding_1
int dev_Forwarding_Enable(int opt_flag, void *mthdval_struct, int locate[])
{
    layer3fwd_conf _conf;
    int ret = -1;
	int i = 0;
	
	printf("opt_flag=%d, locate[]=%d\n", opt_flag, locate);

    if (get_layer3fwd_conf(&_conf) == LAYER3FWD_FAIL) {
        return ret;
    }
    if (!opt_flag) {
        *(int *)mthdval_struct = _conf.forwarding[i].enable; //TODO, i is??, max is _conf.fwd_nums
        ret = 0;
    } else {
        _conf.forwarding[i].enable =  *(unsigned short *)mthdval_struct; //TODO, i is??
        if (set_layer3fwd_conf(&_conf) == LAYER3FWD_SUCCESS) {
            ret = 0;
        }
    }
    
    return ret;
}
int dev_Forwarding_Status(int opt_flag, void *mthdval_struct, int locate[])
{
     layer3fwd_conf _conf;
    int ret = -1;
	int i =0;

    if (!opt_flag) {
        if (get_layer3fwd_conf(&_conf) == LAYER3FWD_SUCCESS) {
                strcpy((char *)mthdval_struct, _conf.forwarding[i].status); //TODO
            ret = 0;
        }
    } else {
        printf("Layer3Forwarding Forward.Status is Unwriteable\n");
    }

    return ret;
}
int dev_Forwarding_Type(int opt_flag, void *mthdval_struct, int locate[])
{    layer3fwd_conf _conf;
    int ret = -1;
	int i =0;

    if (get_layer3fwd_conf(&_conf) == LAYER3FWD_FAIL) {
        return ret;
    }
    if (!opt_flag) {
        strcpy((char *)mthdval_struct, _conf.forwarding[i].type); //TODO
        ret = 0;
    } else {
        strcpy(_conf.forwarding[i].type, (char *)mthdval_struct); //TODO
        if (set_layer3fwd_conf(&_conf) == LAYER3FWD_SUCCESS) {
            ret = 0;
        }
    }
    
    return ret;
}
int dev_Forwarding_DestIPAddress(int opt_flag, void *mthdval_struct, int locate[])
{    layer3fwd_conf _conf;
    int ret = -1;
	int i = 0;

    if (get_layer3fwd_conf(&_conf) == LAYER3FWD_FAIL) {
        return ret;
    }
    if (!opt_flag) {
        strcpy((char *)mthdval_struct, _conf.forwarding[i].dest_ipaddr); //TODO
        ret = 0;
    } else {
        strcpy(_conf.forwarding[i].dest_ipaddr, (char *)mthdval_struct); //TODO
        if (set_layer3fwd_conf(&_conf) == LAYER3FWD_SUCCESS) {
            ret = 0;
        }
    }
    
    return ret;
}
int dev_Forwarding_DestSubnetMask(int opt_flag, void *mthdval_struct, int locate[])
{    layer3fwd_conf _conf;
    int ret = -1;
	int i = 0;

    if (get_layer3fwd_conf(&_conf) == LAYER3FWD_FAIL) {
        return ret;
    }
    if (!opt_flag) {
        strcpy((char *)mthdval_struct, _conf.forwarding[i].dest_sub_mask); //TODO
        ret = 0;
    } else {
        strcpy(_conf.forwarding[i].dest_sub_mask, (char *)mthdval_struct); //TODO
        if (set_layer3fwd_conf(&_conf) == LAYER3FWD_SUCCESS) {
            ret = 0;
        }
    }
    
    return ret;
}
int dev_Forwarding_SourceIPAddress(int opt_flag, void *mthdval_struct, int locate[])
{    layer3fwd_conf _conf;
    int ret = -1;
	int i = 0;

    if (get_layer3fwd_conf(&_conf) == LAYER3FWD_FAIL) {
        return ret;
    }
    if (!opt_flag) {
        strcpy((char *)mthdval_struct, _conf.forwarding[i].src_ipaddr); //TODO
        ret = 0;
    } else {
        strcpy(_conf.forwarding[i].src_ipaddr, (char *)mthdval_struct); //TODO
        if (set_layer3fwd_conf(&_conf) == LAYER3FWD_SUCCESS) {
            ret = 0;
        }
    }
    
    return ret;
}
int dev_Forwarding_SourceSubnetMask(int opt_flag, void *mthdval_struct, int locate[])
{    layer3fwd_conf _conf;
    int ret = -1;
	int i = 0;

    if (get_layer3fwd_conf(&_conf) == LAYER3FWD_FAIL) {
        return ret;
    }
    if (!opt_flag) {
        strcpy((char *)mthdval_struct, _conf.forwarding[i].src_sub_mask); //TODO
        ret = 0;
    } else {
        strcpy(_conf.forwarding[i].src_sub_mask, (char *)mthdval_struct); //TODO
        if (set_layer3fwd_conf(&_conf) == LAYER3FWD_SUCCESS) {
            ret = 0;
        }
    }
    
    return ret;
}
int dev_Forwarding_GatewayIPAddress(int opt_flag, void *mthdval_struct, int locate[])
{    layer3fwd_conf _conf;
    int ret = -1;
	int i = 0;

    if (get_layer3fwd_conf(&_conf) == LAYER3FWD_FAIL) {
        return ret;
    }
    if (!opt_flag) {
        strcpy((char *)mthdval_struct, _conf.forwarding[i].gw_ipaddr); //TODO
        ret = 0;
    } else {
        strcpy(_conf.forwarding[i].gw_ipaddr, (char *)mthdval_struct); //TODO
        if (set_layer3fwd_conf(&_conf) == LAYER3FWD_SUCCESS) {
            ret = 0;
        }
    }
    
    return ret;
}
int dev_Forwarding_Interface(int opt_flag, void *mthdval_struct, int locate[])
{    layer3fwd_conf _conf;
    int ret = -1;
	int i = 0;

    if (get_layer3fwd_conf(&_conf) == LAYER3FWD_FAIL) {
        return ret;
    }
    if (!opt_flag) {
        strcpy((char *)mthdval_struct, _conf.forwarding[i].iface); //TODO
        ret = 0;
    } else {
        strcpy(_conf.forwarding[i].iface, (char *)mthdval_struct); //TODO
        if (set_layer3fwd_conf(&_conf) == LAYER3FWD_SUCCESS) {
            ret = 0;
        }
    }
}
int dev_Forwarding_ForwardingMetric(int opt_flag, void *mthdval_struct, int locate[])
{
    layer3fwd_conf _conf;
    int ret = -1;
	int i = 0;

    if (get_layer3fwd_conf(&_conf) == LAYER3FWD_FAIL) {
        return ret;
    }
    if (!opt_flag) {
        *(int *)mthdval_struct = _conf.forwarding[i].fwd_metric; //TODO
        ret = 0;
    } else {
        _conf.forwarding[i].fwd_metric = *(int *)mthdval_struct; //TODO
        if (set_layer3fwd_conf(&_conf) == LAYER3FWD_SUCCESS) {
            ret = 0;
        }
    }
    
    return ret;
}
int dev_Forwarding_MTU(int opt_flag, void *mthdval_struct, int locate[]) // Optional
{
    if (!opt_flag) // get function
        return 0;
    else           // set function
        return 0;
}