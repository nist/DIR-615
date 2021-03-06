/* $Id: flow_callback.c,v 1.1 2008/10/01 06:17:20 ken_chiang Exp $ */
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

#include <stdio.h>
#include <time.h>


#include "packet_time.h"

#include "flow_callback.h"
#include "flow_cache.h"

/* needed for flow stats callback */
#include "flow_stat.h"

/* portscan detector */
#include "portscan/flowps_snort.h"

static int s_debug = 0;

int flow_callbacks(FLOW_POSITION position, FLOW *flowp, int direction, Packet *p)
{
    time_t now;
    
    if(flowp == NULL)
    {
        return FLOW_ENULL;
    }

    if(position < FLOW_NEW || position >= FLOW_MAX)
    {
        return FLOW_EINVALID;
    }

    if(s_debug > 5)
    {
#ifndef WIN32
        flow_printf("DEBUG: %s called at postition %s on flow: %p ",__func__,
               flowcache_pname(position), flowp);
#else
        flow_printf("DEBUG: %s(%d) called at postition %s on flow: %p ",__FILE__,__LINE__,
               flowcache_pname(position), flowp);
#endif
        flowkey_print(&flowp->key);
        flow_printf("\n");
    }

    /* we have to be prepared to get rid of a flow without a packet */   
    now = packet_timeofday();
    
    switch(position)
    {
    case FLOW_NEW:
        flowps_newflow_callback(position, flowp, direction, now ,p);        
        flowstat_callback(position, flowp, direction, now, p);
        break;
    case FLOW_ADDITIONAL:
        flowstat_callback(position, flowp, direction, now, p);
        break;
    case FLOW_FIRST_BIDIRECTIONAL:
        /* be careful putting callbacks here because this is really
         * used in addition to the FLOW_ADDITIONAL stage.
         */
        break;        
    case FLOW_SHUTDOWN:
        flowstat_callback(position, flowp, direction, now, p);
        break;
    default:
        flow_printf("Unknown position: %d\n", position);
        return 1;
    }
    
    return FLOW_SUCCESS;
}
/** 
 * Install a new flow plugin
 * 
 * This will install a new plugin for callbacks and install the plugin
 * at the correct location for that.
 *
 * 
 * @param position where to add this callback
 * @param flowp what tp match
 * @param direction which direction to match
 * @param fire_once only trigger on
 * @param timeout when this callback is no longer valid (0) means forever.
 */
/* int fcb_register(FLOW_POSITION position, FLOW *flowp, int direction, int order, int fire_once, int timeout) */
/* { */
    
/* } */
                 
