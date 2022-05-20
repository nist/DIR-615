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

#include "lansec_conf.h"

/*
 ***********************************************************************
 * Function name: get_lansec_conf
 * Description: get the LANConfigSecurity information of agent
 * Parameter: lansec_conf *pconf -- pointer to lansec configure struct
 * Return Value: LANSEC_SUCCESS: 0 LANSEC_FAIL: -1 
 * *********************************************************************
 */
int get_lansec_conf(lansec_conf *pconf)
{
    FILE *fp = NULL;
    char info_buf[4096];
    char *pstr = NULL, *pstr_bk = NULL;
    char tmp[32];
    int i = 0;

    /*init variable*/
    memset(info_buf, 0, sizeof(info_buf));
    memset(pconf, 0, sizeof(lansec_conf));

    if (access(lansec_conf_path, F_OK) == -1) {
        printf( "File %s not exist\n", lansec_conf_path);
        return LANSEC_FAIL;
    }

    fp = fopen(lansec_conf_path, "r");
    if (fp == NULL) {
        printf( "Can't open file %s\n", lansec_conf_path);
        return LANSEC_FAIL;
    }

    if (fread(info_buf, sizeof(char), sizeof(info_buf), fp) <= 0) {
        printf( "Read file %s error\n", lansec_conf_path);
        fclose(fp);
        return LANSEC_FAIL;
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
                    strncpy(pconf->conf_pwd, pstr, pstr_bk - pstr);
                    break;
                default:
                    printf("ERROR\n");
                    return LANSEC_FAIL;
            }
            pstr = pstr_bk + 1;
        } else {
            pstr = pstr_bk;
        }
    }

    return LANSEC_SUCCESS;
}

/*
 ************************************************************************
 * Function name:set_lansec_conf()
 * Description: set the LANConfigSecurity information to file
 * Parameter:lansec_conf *pconf -- pointer to the lansec configure struct
 * Return value: LANSEC_SUCCESS:0 LANSEC_FAIL:-1
 ************************************************************************
 */
int set_lansec_conf(lansec_conf *pconf)
{
    FILE *fp = NULL;

    fp = fopen(lansec_conf_path, "w");
    if (fp == NULL) {
        printf( "Can't open file %s\n", lansec_conf_path);
        return LANSEC_FAIL;
    }
    fprintf(fp, "%s\n", pconf->conf_pwd);

    fclose(fp);

    return LANSEC_SUCCESS;
}
/*
 *********************************************************************
 * Function name: init_lansec_conf()
 * Description: init the lansec configure file
 * Parameter: void
 * Retrun value:  LANSEC_SUCCESS:0  LANSEC_FAIL:-1
 *********************************************************************
 */
int init_lansec_conf()
{
    lansec_conf _conf;

    if (access(lansec_conf_path, F_OK) == -1) {
        printf( "File %s is not exist\n", lansec_conf_path);
        /*Use default value to write configure file*/
        memset(&_conf, 0, sizeof(_conf));

        strcpy(_conf.conf_pwd, LANSEC_CONF_PWD);

        /*write to configure file*/
        if (set_lansec_conf(&_conf) == LANSEC_FAIL) {
            printf("Set lansec info error\n");
            return LANSEC_FAIL;
        }
    }
    return LANSEC_SUCCESS;
}
