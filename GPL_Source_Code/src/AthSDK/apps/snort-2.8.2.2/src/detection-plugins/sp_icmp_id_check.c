/*
** Copyright (C) 2002-2008 Sourcefire, Inc.
** Copyright (C) 1998-2002 Martin Roesch <roesch@sourcefire.com>
**
** This program is free software; you can redistribute it and/or modify
** it under the terms of the GNU General Public License Version 2 as
** published by the Free Software Foundation.  You may not use, modify or
** distribute this program under any other version of the GNU General
** Public License.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with this program; if not, write to the Free Software
** Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*/

/* $Id: sp_icmp_id_check.c,v 1.1 2008/10/01 06:17:13 ken_chiang Exp $ */
/* sp_icmp_id 
 * 
 * Purpose:
 *
 * Test the ID field of ICMP ECHO and ECHO_REPLY packets for specified 
 * values.  This is useful for detecting TFN attacks, amongst others.
 *
 * Arguments:
 *   
 * The ICMP ID plugin takes a number as an option argument.
 *
 * Effect:
 *
 * Tests ICMP ECHO and ECHO_REPLY packet ID field values and returns a 
 * "positive" detection result (i.e. passthrough) upon a value match.
 *
 * Comments:
 *
 * This plugin was developed to detect TFN distributed attacks.
 *
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <sys/types.h>
#include <stdlib.h>
#include <ctype.h>

#include "rules.h"
#include "decode.h"
#include "plugbase.h"
#include "parser.h"
#include "debug.h"
#include "util.h"
#include "plugin_enum.h"

#include "snort.h"
#include "profiler.h"
#ifdef PERF_PROFILING
PreprocStats icmpIdPerfStats;
extern PreprocStats ruleOTNEvalPerfStats;
#endif

#ifdef DETECTION_OPTION_TREE
#include "detection_options.h"
#endif /* DETECTION_OPTION_TREE */

typedef struct _IcmpIdCheckData
{
        u_short icmpid;

} IcmpIdCheckData;

void ParseIcmpId(char *, OptTreeNode *);
#ifdef DETECTION_OPTION_TREE
int IcmpIdCheck(void *option_data, Packet *);
#else
int IcmpIdCheck(Packet *, struct _OptTreeNode *, OptFpList *);
#endif
void IcmpIdCheckInit(char *, OptTreeNode *, int);

#ifdef DETECTION_OPTION_TREE
u_int32_t IcmpIdCheckHash(void *d)
{
    u_int32_t a,b,c;
    IcmpIdCheckData *data = (IcmpIdCheckData *)d;

    a = data->icmpid;
    b = RULE_OPTION_TYPE_ICMP_ID;
    c = 0;

    final(a,b,c);

    return c;
}

int IcmpIdCheckCompare(void *l, void *r)
{
    IcmpIdCheckData *left = (IcmpIdCheckData *)l;
    IcmpIdCheckData *right = (IcmpIdCheckData *)r;

    if (!left || !right)
        return DETECTION_OPTION_NOT_EQUAL;

    if (left->icmpid == right->icmpid)
    {
        return DETECTION_OPTION_EQUAL;
    }

    return DETECTION_OPTION_NOT_EQUAL;
}
#endif /* DETECTION_OPTION_TREE */

/****************************************************************************
 * 
 * Function: SetupIcmpIdCheck()
 *
 * Purpose: Registers the configuration function and links it to a rule
 *          keyword.  This is the function that gets called from InitPlugins
 *          in plugbase.c.
 *
 * Arguments: None.
 *
 * Returns: void function
 *
 ****************************************************************************/
void SetupIcmpIdCheck(void)
{
    /* map the keyword to an initialization/processing function */
    RegisterPlugin("icmp_id", IcmpIdCheckInit, OPT_TYPE_DETECTION);

#ifdef PERF_PROFILING
    RegisterPreprocessorProfile("icmp_id", &icmpIdPerfStats, 3, &ruleOTNEvalPerfStats);
#endif
    DEBUG_WRAP(DebugMessage(DEBUG_PLUGIN,"Plugin: IcmpIdCheck Setup\n"););
}


/****************************************************************************
 * 
 * Function: IcmpIdCheckInit(char *, OptTreeNode *)
 *
 * Purpose: Handles parsing the rule information and attaching the associated
 *          detection function to the OTN.
 *
 * Arguments: data => rule arguments/data
 *            otn => pointer to the current rule option list node
 *
 * Returns: void function
 *
 ****************************************************************************/
void IcmpIdCheckInit(char *data, OptTreeNode *otn, int protocol)
{
    OptFpList *fpl;
    if(protocol != IPPROTO_ICMP)
    {
        FatalError("%s(%d): ICMP Options on non-ICMP rule\n", file_name, file_line);
    }

    /* multiple declaration check */ 
    if(otn->ds_list[PLUGIN_ICMP_ID_CHECK])
    {
        FatalError("%s(%d): Multiple icmp id options in rule\n", file_name,
                file_line);
    }

    /* allocate the data structure and attach it to the
       rule's data struct list */
    otn->ds_list[PLUGIN_ICMP_ID_CHECK] = (IcmpIdCheckData *)
        SnortAlloc(sizeof(IcmpIdCheckData));

    /* this is where the keyword arguments are processed and placed into the 
       rule option's data structure */

    ParseIcmpId(data, otn);

    /* finally, attach the option's detection function to the rule's 
       detect function pointer list */
    fpl = AddOptFuncToList(IcmpIdCheck, otn);
#ifdef DETECTION_OPTION_TREE
    fpl->type = RULE_OPTION_TYPE_ICMP_ID;
    fpl->context = otn->ds_list[PLUGIN_ICMP_ID_CHECK];
#endif
}



/****************************************************************************
 * 
 * Function: ParseIcmpId(char *, OptTreeNode *)
 *
 * Purpose: Convert the rule option argument to program data.
 *
 * Arguments: data => argument data
 *            otn => pointer to the current rule's OTN
 *
 * Returns: void function
 *
 ****************************************************************************/
void ParseIcmpId(char *data, OptTreeNode *otn)
{
    IcmpIdCheckData *ds_ptr;  /* data struct pointer */
#ifdef DETECTION_OPTION_TREE
    void *ds_ptr_dup;
#endif

    /* set the ds pointer to make it easier to reference the option's
       particular data struct */
    ds_ptr = otn->ds_list[PLUGIN_ICMP_ID_CHECK];

    /* advance past whitespace */
    while(isspace((int)*data)) data++;

    ds_ptr->icmpid = atoi(data);
    ds_ptr->icmpid = htons(ds_ptr->icmpid);

#ifdef DETECTION_OPTION_TREE
    if (add_detection_option(RULE_OPTION_TYPE_ICMP_ID, (void *)ds_ptr, &ds_ptr_dup) == DETECTION_OPTION_EQUAL)
    {
        free(ds_ptr);
        ds_ptr = otn->ds_list[PLUGIN_ICMP_ID_CHECK] = ds_ptr_dup;
    }
#endif /* DETECTION_OPTION_TREE */
    DEBUG_WRAP(DebugMessage(DEBUG_PLUGIN,"Set ICMP ID test value to %d\n", ds_ptr->icmpid););
}


/****************************************************************************
 * 
 * Function: IcmpIdCheck(char *, OptTreeNode *)
 *
 * Purpose: Compare the ICMP ID field to the rule value.
 *
 * Arguments: data => argument data
 *            otn => pointer to the current rule's OTN
 *
 * Returns: If the detection test fails, this function *must* return a zero!
 *          On success, it calls the next function in the detection list 
 *
 ****************************************************************************/
#ifdef DETECTION_OPTION_TREE
int IcmpIdCheck(void *option_data, Packet *p)
{
    IcmpIdCheckData *icmpId = (IcmpIdCheckData *)option_data;
    PROFILE_VARS;

    if(!p->icmph)
        return DETECTION_OPTION_NO_MATCH; /* if error occured while icmp header
                   * was processed, return 0 automagically.  */

    PREPROC_PROFILE_START(icmpIdPerfStats);

    if( (p->icmph->type == ICMP_ECHO || p->icmph->type == ICMP_ECHOREPLY) 
#ifdef SUP_IP6
        || (p->icmph->type == ICMP6_ECHO || p->icmph->type == ICMP6_REPLY) 
#endif
      ) 
    {
        /* test the rule ID value against the ICMP extension ID field */
        if(icmpId->icmpid == p->icmph->s_icmp_id)
        {
            DEBUG_WRAP(DebugMessage(DEBUG_PLUGIN, "ICMP ID check success\n"););
            PREPROC_PROFILE_END(icmpIdPerfStats);
            return DETECTION_OPTION_MATCH;
        }
        else
        {
            /* you can put debug comments here or not */
            DEBUG_WRAP(DebugMessage(DEBUG_PLUGIN, "ICMP ID check failed\n"););
        }
    }
    PREPROC_PROFILE_END(icmpIdPerfStats);
    return DETECTION_OPTION_NO_MATCH;
}
#else
int IcmpIdCheck(Packet *p, struct _OptTreeNode *otn, OptFpList *fp_list)
{
    PROFILE_VARS;

    if(!p->icmph)
        return 0; /* if error occured while icmp header
                   * was processed, return 0 automagically.  */

    PREPROC_PROFILE_START(icmpIdPerfStats);

    if( (p->icmph->type == ICMP_ECHO || p->icmph->type == ICMP_ECHOREPLY) 
#ifdef SUP_IP6
        || (p->icmph->type == ICMP6_ECHO || p->icmph->type == ICMP6_REPLY) 
#endif
      ) 
    {
        /* test the rule ID value against the ICMP extension ID field */
        if(((IcmpIdCheckData *) otn->ds_list[PLUGIN_ICMP_ID_CHECK])->icmpid == 
           p->icmph->s_icmp_id)
        {
            /* call the next function in the function list recursively */
            PREPROC_PROFILE_END(icmpIdPerfStats);
            return fp_list->next->OptTestFunc(p, otn, fp_list->next);
        }
        else
        {
            /* you can put debug comments here or not */
            DEBUG_WRAP(DebugMessage(DEBUG_PLUGIN, "ICMP ID check failed\n"););
        }
    }

    /* if the test isn't successful, this function *must* return 0 */
    PREPROC_PROFILE_END(icmpIdPerfStats);
    return 0;
}
#endif
