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
 * Include files
 */
#include <stdio.h>
#include <time.h>
#include "timestr.h"

/***********************************************************************
*
*	function prototype
*
***********************************************************************/

static inline unsigned long ewt_mktime(struct tm *tm);
 
extern char *strptime (__const char *__restrict __s,
                       __const char *__restrict __fmt, struct tm *__tp)
     __THROW;

/************************************************************************
*
*	global var define
*
************************************************************************/
/*
 ********************************************************************
 * Function name: ewt_mktime();
 * Description: time transition
 * Parameter: tm
 * Return value: time
 *********************************************************************
 */
static inline unsigned long ewt_mktime(struct tm *tm)
{
    tm->tm_year += 1900;
    tm->tm_mon += 1;

    if (0 >= (int) (tm->tm_mon -= 2)) {  //1..12 -> 11,12,1..10
        tm->tm_mon += 12;                // Puts Feb last since it has leap day
        tm->tm_year -= 1;
    }

    return ((( (unsigned long) (tm->tm_year/4 - tm->tm_year/100 + tm->tm_year/400 + 367*tm->tm_mon/12 + tm->tm_mday) + tm->tm_year*365 - 719499 )*24 + tm->tm_hour)*60 + tm->tm_min)*60 + tm->tm_sec;

}
/*
 ********************************************************************
 * Function name: strtimetosec();
 * Description: time transition
 * Parameter: strtm
 * Return value: time
 *********************************************************************
 */
time_t strtimetosec(char *strtm)
{
    char *format = "%Y-%m-%dT%T";
    struct tm tm;
    time_t temp;

    if (strptime(strtm, format, &tm) == NULL){
        printf("strptime error\n");
        return -1;
    }

    temp = ewt_mktime(&tm);

    return temp;
}
