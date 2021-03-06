/****************************************************************************
 *
 * Copyright (C) 2003-2008 Sourcefire, Inc.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License Version 2 as
 * published by the Free Software Foundation.  You may not use, modify or
 * distribute this program under any other version of the GNU General
 * Public License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 ****************************************************************************/
 
#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include "flow_print.h"
#include "flow_error.h"
#include "util.h"

#include <unistd.h>
#include <syslog.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

static int s_daemon = 0;  /* what mode is this library running in */

#define BUFSIZE 1024

/** 
 * Make this library print to syslog
 * 
 * 
 * @return FLOW_SUCCESS
 */
int flow_set_daemon(void)
{
    s_daemon = 1;
    
    return FLOW_SUCCESS;
}

/** 
 * flow's printf
 * 
 * @param format format to print in
 * @param  ... args
 * 
 * @return FLOW_SUCCESS on sucess
 */
int flow_printf(const char *format, ...)
{
    char buf[BUFSIZE + 1];
    va_list ap;
    
    va_start(ap,format);
    vsnprintf(buf, BUFSIZE, format, ap);
    va_end(ap);

    buf[BUFSIZE] = '\0';

    if(s_daemon)
    {
        syslog(LOG_CONS | LOG_DAEMON | LOG_ERR, "%s", buf);
    }
    else
    {
        fprintf(stderr, "%s", buf);        
    }
    
    return FLOW_SUCCESS;
}

NORETURN void flow_fatalerror(const char *format, ...)
{
    char buf[BUFSIZE + 1];
    char fmt[BUFSIZE + 1];    
    va_list ap;


    snprintf(fmt, BUFSIZE, "FatalError: %s", format);
    fmt[BUFSIZE] = '\0';
    
    va_start(ap,format);
    vsnprintf(buf, BUFSIZE, format, ap);
    va_end(ap);

    buf[BUFSIZE] = '\0';

    if(s_daemon)
    {
        syslog(LOG_CONS | LOG_DAEMON | LOG_ERR, "%s", buf);
    }
    else
    {
        fprintf(stderr, "%s", buf);        
    }

    exit(1);
}

NORETURN void flow_errormsg(const char *format, ...)
{
    char buf[BUFSIZE + 1];
    char fmt[BUFSIZE + 1];    
    va_list ap;

    snprintf(fmt, BUFSIZE, "ERROR: %s", format);
    fmt[BUFSIZE] = '\0';
    
    va_start(ap,format);
    vsnprintf(buf, BUFSIZE, format, ap);
    va_end(ap);

    buf[BUFSIZE] = '\0';

    if(s_daemon)
    {
        syslog(LOG_CONS | LOG_DAEMON | LOG_ERR, "%s", buf);
    }
    else
    {
        fprintf(stderr, "%s", buf);        
    }

    exit(1);
}
