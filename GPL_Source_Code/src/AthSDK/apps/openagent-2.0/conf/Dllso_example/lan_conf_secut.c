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


/******************************************************************************
 * $Author: norp_huang $
 * $Date: 2009/05/25 09:16:48 $
 *****************************************************************************/
#include <stdio.h>
#include <string.h>

#include "lansec_conf.h" // ../../src/public/conf/lansec_conf.h

/*
#ifdef asus_ax112w
#else
  #include "dbapi.h"
#endif
*/
//LANConfigSecurity
int dev_LAN_ConfigPassword(int opt_flag, void *mthdval_struct, int locate[])
{
	lansec_conf _conf;
	int ret = -1;

    if (get_lansec_conf(&_conf) == LANSEC_FAIL) {
        return ret;
    }

    if (!opt_flag) // get function
    {
    	printf("ConfigPassword is unreadable.\n");
    	strcpy(mthdval_struct, ""); // give null value
		ret = 0;
    }
    else           // set function
    {
		strcpy(_conf.conf_pwd, (char *)mthdval_struct);
		if (set_lansec_conf(&_conf) == LANSEC_SUCCESS) {
            ret = 0;
    		printf("Set ConfigPassword to success.\n");
        }
    }
	return ret;
}

