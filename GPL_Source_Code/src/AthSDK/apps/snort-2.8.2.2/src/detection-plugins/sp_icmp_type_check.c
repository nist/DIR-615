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

/* $Id: sp_icmp_type_check.c,v 1.1 2008/10/01 06:17:13 ken_chiang Exp $ */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "rules.h"
#include "decode.h"
#include "plugbase.h"
#include "parser.h"
#include "debug.h"
#include "util.h"
#include "plugin_enum.h"
#include "sp_icmp_type_check.h"

#include "snort.h"
#include "profiler.h"
#ifdef PERF_PROFILING
PreprocStats icmpTypePerfStats;
extern PreprocStats ruleOTNEvalPerfStats;
#endif
 
#ifdef DETECTION_OPTION_TREE
#include "detection_options.h"
#endif /* DETECTION_OPTION_TREE */

void IcmpTypeCheckInit(char *, OptTreeNode *, int);
void ParseIcmpType(char *, OptTreeNode *);
#ifdef DETECTION_OPTION_TREE
int IcmpTypeCheck(void *option_data, Packet *p);
#else
int IcmpTypeCheck(Packet *, struct _OptTreeNode *, OptFpList *);
#endif

#ifdef DETECTION_OPTION_TREE
u_int32_t IcmpTypeCheckHash(void *d)
{
    u_int32_t a,b,c;
    IcmpTypeCheckData *data = (IcmpTypeCheckData *)d;

    a = data->icmp_type;
    b = data->icmp_type2;
    c = data->operator;

    mix(a,b,c);

    a += RULE_OPTION_TYPE_ICMP_TYPE;

    final(a,b,c);

    return c;
}

int IcmpTypeCheckCompare(void *l, void *r)
{
    IcmpTypeCheckData *left = (IcmpTypeCheckData *)l;
    IcmpTypeCheckData *right = (IcmpTypeCheckData *)r;

    if (!left || !right)
        return DETECTION_OPTION_NOT_EQUAL;

    if ((left->icmp_type == right->icmp_type) &&
        (left->icmp_type2 == right->icmp_type2) &&
        (left->operator == right->operator))
    {
        return DETECTION_OPTION_EQUAL;
    }

    return DETECTION_OPTION_NOT_EQUAL;
}
#endif /* DETECTION_OPTION_TREE */

/****************************************************************************
 * 
 * Function: SetupIcmpTypeCheck()
 *
 * Purpose: Register the itype keyword and configuration function
 *
 * Arguments: None.
 *
 * Returns: void function
 *
 ****************************************************************************/
void SetupIcmpTypeCheck(void)
{
    /* map the keyword to an initialization/processing function */
    RegisterPlugin("itype", IcmpTypeCheckInit, OPT_TYPE_DETECTION);
#ifdef PERF_PROFILING
    RegisterPreprocessorProfile("itype", &icmpTypePerfStats, 3, &ruleOTNEvalPerfStats);
#endif
    DEBUG_WRAP(DebugMessage(DEBUG_PLUGIN,"Plugin: IcmpTypeCheck Initialized\n"););
}


/****************************************************************************
 * 
 * Function: IcmpTypeCheckInit(char *, OptTreeNode *)
 *
 * Purpose: Initialize the rule data structs and parse the rule argument
 *          data, then link in the detection function
 *
 * Arguments: data => rule arguments/data
 *            otn => pointer to the current rule option list node
 *
 * Returns: void function
 *
 ****************************************************************************/
void IcmpTypeCheckInit(char *data, OptTreeNode *otn, int protocol)
{
    OptFpList *fpl;
    if(protocol != IPPROTO_ICMP)
    {
        FatalError("%s(%d): ICMP Options on non-ICMP rule\n", file_name, file_line);
    }
    
    /* multiple declaration check */ 
    if(otn->ds_list[PLUGIN_ICMP_TYPE])
    {
        FatalError("%s(%d): Multiple ICMP type options in rule\n", file_name,
                file_line);
    }
        
    /* allocate the data structure and attach it to the
       rule's data struct list */
    otn->ds_list[PLUGIN_ICMP_TYPE] = (IcmpTypeCheckData *)
            SnortAlloc(sizeof(IcmpTypeCheckData));

    /* this is where the keyword arguments are processed and placed into the 
       rule option's data structure */
    ParseIcmpType(data, otn);

    /* finally, attach the option's detection function to the rule's 
       detect function pointer list */
    fpl = AddOptFuncToList(IcmpTypeCheck, otn);
#ifdef DETECTION_OPTION_TREE
    fpl->type = RULE_OPTION_TYPE_ICMP_TYPE;
    fpl->context = otn->ds_list[PLUGIN_ICMP_TYPE];
#endif
}



/****************************************************************************
 * 
 * Function: ParseIcmpType(char *, OptTreeNode *)
 *
 * Purpose: Process the itype argument and stick it in the data struct
 *
 * Arguments: data => argument data
 *            otn => pointer to the current rule's OTN
 *
 * Returns: void function
 *
 ****************************************************************************/
void ParseIcmpType(char *data, OptTreeNode *otn)
{
    char *type;
    IcmpTypeCheckData *ds_ptr;  /* data struct pointer */
#ifdef DETECTION_OPTION_TREE
    void *ds_ptr_dup;
#endif
    char *endptr = NULL;

    /* set the ds pointer to make it easier to reference the option's
       particular data struct */
    ds_ptr = otn->ds_list[PLUGIN_ICMP_TYPE];

    /* set a pointer to the data so to leave the original unchanged */
    type = data;

    if(!data)
    {
        FatalError("%s (%d): No ICMP Type Specified\n",
                   file_name, file_line);
    }
    
    /* get rid of spaces before the data */
    while(isspace((int)*data))
        data++;

    if (*data == '\0')
    {
        FatalError("%s (%d): No ICMP Type Specified : %s\n",
                   file_name, file_line, type);
    }

    /*
     * if a range is specified, put the min in icmp_type, and the max in 
     * icmp_type2
     */

    if (isdigit((int)*data) && strstr(data, "<>"))
    {
        ds_ptr->icmp_type = strtol(data, &endptr, 10);
        while (isspace((int)*endptr))
            endptr++;

        if (*endptr != '<')
        {
            FatalError("%s (%d): Invalid ICMP itype in rule: %s\n",
                       file_name, file_line, type);
        }

        data = endptr;

        data += 2;   /* move past <> */

        while (isspace((int)*data))
            data++;

        ds_ptr->icmp_type2 = strtol(data, &endptr, 10);
        if (*data == '\0' || *endptr != '\0')
        {
            FatalError("%s (%d): Invalid ICMP itype in rule: %s\n",
                       file_name, file_line, type);
        }

        ds_ptr->operator = ICMP_TYPE_TEST_RG;
    }
    /* otherwise if its greater than... */
    else if (*data == '>')
    {
        data++;
        while (isspace((int)*data))
            data++;

        ds_ptr->icmp_type = strtol(data, &endptr, 10);
        if (*data == '\0' || *endptr != '\0')
        {
            FatalError("%s (%d): Invalid ICMP itype in rule: %s\n",
                       file_name, file_line, type);
        }

        ds_ptr->operator = ICMP_TYPE_TEST_GT;
    }
    /* otherwise if its less than ... */
    else if (*data == '<')
    {
        data++;
        while (isspace((int)*data))
            data++;

        ds_ptr->icmp_type = strtol(data, &endptr, 10);
        if (*data == '\0' || *endptr != '\0')
        {
            FatalError("%s (%d): Invalid ICMP itype in rule: %s\n",
                       file_name, file_line, type);
        }

        ds_ptr->operator  = ICMP_TYPE_TEST_LT;
    }
    /* otherwise check if its a digit */
    else
    {
        ds_ptr->icmp_type = strtol(data, &endptr, 10);
        if (*endptr != '\0')
        {
            FatalError("%s (%d): Invalid ICMP itype in rule: %s\n",
                       file_name, file_line, type);
        }

        ds_ptr->operator = ICMP_TYPE_TEST_EQ;
    }

#ifdef DETECTION_OPTION_TREE
    if (add_detection_option(RULE_OPTION_TYPE_ICMP_TYPE, (void *)ds_ptr, &ds_ptr_dup) == DETECTION_OPTION_EQUAL)
    {
        free(ds_ptr);
        ds_ptr = otn->ds_list[PLUGIN_ICMP_TYPE] = ds_ptr_dup;
    }
#endif /* DETECTION_OPTION_TREE */

    return;
}

/****************************************************************************
 * 
 * Function: IcmpTypeCheck(char *, OptTreeNode *)
 *
 * Purpose: Test the packet's ICMP type field value against the option's
 *          ICMP type
 *
 * Arguments: data => argument data
 *            otn => pointer to the current rule's OTN
 *
 * Returns: void function
 *
 ****************************************************************************/
#ifdef DETECTION_OPTION_TREE
int IcmpTypeCheck(void *option_data, Packet *p)
{
    IcmpTypeCheckData *ds_ptr;
    int rval = DETECTION_OPTION_NO_MATCH;
    PROFILE_VARS;

    ds_ptr = (IcmpTypeCheckData *)option_data;

    /* return 0  if we don't have an icmp header */
    if(!p->icmph)
        return rval;

    PREPROC_PROFILE_START(icmpTypePerfStats);

    switch(ds_ptr->operator)
    {
        case ICMP_TYPE_TEST_EQ:
            if (p->icmph->type == ds_ptr->icmp_type)
                rval = DETECTION_OPTION_MATCH;
            break;
        case ICMP_TYPE_TEST_GT:
            if (p->icmph->type > ds_ptr->icmp_type)
                rval = DETECTION_OPTION_MATCH;
            break;
        case ICMP_TYPE_TEST_LT:
            if (p->icmph->type < ds_ptr->icmp_type)
                rval = DETECTION_OPTION_MATCH;
            break;
        case ICMP_TYPE_TEST_RG:
            if (p->icmph->type > ds_ptr->icmp_type && 
                    p->icmph->type < ds_ptr->icmp_type2)
                rval = DETECTION_OPTION_MATCH;
            break;
    }

    DEBUG_WRAP(
        if (rval == DETECTION_OPTION_MATCH)
        {
            DebugMessage(DEBUG_PLUGIN, "Got icmp type match!\n");
        }
        else
        {
            DebugMessage(DEBUG_PLUGIN, "Failed icmp type match!\n");
        }
        );

    PREPROC_PROFILE_END(icmpTypePerfStats);
    return rval;
}
#else
int IcmpTypeCheck(Packet *p, struct _OptTreeNode *otn, OptFpList *fp_list)
{
    IcmpTypeCheckData *ds_ptr;
    int success = 0;
    PROFILE_VARS;

    ds_ptr = otn->ds_list[PLUGIN_ICMP_TYPE];

    /* return 0  if we don't have an icmp header */
    if(!p->icmph)
        return 0;

    PREPROC_PROFILE_START(icmpTypePerfStats);

    switch(ds_ptr->operator)
    {
        case ICMP_TYPE_TEST_EQ:
            if (p->icmph->type == ds_ptr->icmp_type)
                success = 1;
            break;
        case ICMP_TYPE_TEST_GT:
            if (p->icmph->type > ds_ptr->icmp_type)
                success = 1;
            break;
        case ICMP_TYPE_TEST_LT:
            if (p->icmph->type < ds_ptr->icmp_type)
                success = 1;
            break;
        case ICMP_TYPE_TEST_RG:
            if (p->icmph->type > ds_ptr->icmp_type && 
                    p->icmph->type < ds_ptr->icmp_type2)
                success = 1;
            break;
        default:
            break;
    }

    if (success)
    {
        DEBUG_WRAP(DebugMessage(DEBUG_PLUGIN, "Got icmp type match!\n"););
        PREPROC_PROFILE_END(icmpTypePerfStats);
        return fp_list->next->OptTestFunc(p, otn, fp_list->next);
    }

    /* return 0 on failed test */
    DEBUG_WRAP(DebugMessage(DEBUG_PLUGIN, "Failed icmp code match!\n"););
    PREPROC_PROFILE_END(icmpTypePerfStats);
    return 0;
}
#endif
