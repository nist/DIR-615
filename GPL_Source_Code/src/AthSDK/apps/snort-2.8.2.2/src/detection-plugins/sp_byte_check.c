/* $Id: sp_byte_check.c,v 1.1 2008/10/01 06:17:13 ken_chiang Exp $ */
/*
 ** Copyright (C) 2002-2008 Sourcefire, Inc.
 ** Author: Martin Roesch
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

/* sp_byte_check 
 * 
 * Purpose:
 *      Test a byte field against a specific value (with operator).  Capable
 *      of testing binary values or converting represenative byte strings
 *      to their binary equivalent and testing them.
 *
 *
 * Arguments:
 *      Required:
 *      <bytes_to_convert>: number of bytes to pick up from the packet
 *      <operator>: operation to perform to test the value (<,>,=,!)
 *      <value>: value to test the converted value against
 *      <offset>: number of bytes into the payload to start processing
 *      Optional:
 *      ["relative"]: offset relative to last pattern match
 *      ["big"]: process data as big endian (default)
 *      ["little"]: process data as little endian
 *      ["string"]: converted bytes represented as a string needing conversion
 *      ["hex"]: converted string data is represented in hexidecimal
 *      ["dec"]: converted string data is represented in decimal
 *      ["oct"]: converted string data is represented in octal
 *   
 *   sample rules:
 *   alert udp $EXTERNAL_NET any -> $HOME_NET any \
 *      (msg:"AMD procedure 7 plog overflow "; \
 *      content: "|00 04 93 F3|"; \
 *      content: "|00 00 00 07|"; distance: 4; within: 4; \
 *      byte_test: 4,>, 1000, 20, relative;)
 *
 *   alert tcp $EXTERNAL_NET any -> $HOME_NET any \
 *      (msg:"AMD procedure 7 plog overflow "; \
 *      content: "|00 04 93 F3|"; \
 *      content: "|00 00 00 07|"; distance: 4; within: 4; \
 *      byte_test: 4, >,1000, 20, relative;)
 *
 * alert udp any any -> any 1234 \
 *      (byte_test: 4, =, 1234, 0, string, dec; \
 *      msg: "got 1234!";)
 *
 * alert udp any any -> any 1235 \
 *      (byte_test: 3, =, 123, 0, string, dec; \
 *      msg: "got 123!";)
 *
 * alert udp any any -> any 1236 \
 *      (byte_test: 2, =, 12, 0, string, dec; \
 *      msg: "got 12!";)
 *
 * alert udp any any -> any 1237 \
 *      (byte_test: 10, =, 1234567890, 0, string, dec; \
 *      msg: "got 1234567890!";)
 *
 * alert udp any any -> any 1238 \
 *      (byte_test: 8, =, 0xdeadbeef, 0, string, hex; \
 *      msg: "got DEADBEEF!";)
 *
 * Effect:
 *
 *      Reads in the indicated bytes, converts them to an numeric 
 *      representation and then performs the indicated operation/test on
 *      the data using the value field.  Returns 1 if the operation is true,
 *      0 if it is not.
 *
 * Comments:
 *
 * Any comments?
 *
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <sys/types.h>
#include <stdlib.h>
#include <ctype.h>
#ifdef HAVE_STRINGS_H
#include <strings.h>
#endif
#include <errno.h>

#include "bounds.h"
#include "byte_extract.h"
#include "rules.h"
#include "decode.h"
#include "plugbase.h"
#include "parser.h"
#include "debug.h"
#include "util.h"
#include "plugin_enum.h"
#include "mstring.h"

#define BT_LESS_THAN 1
#define BT_EQUALS    2
#define BT_GREATER_THAN 3
#define BT_AND 4
#define BT_OR 5

#define BIG    0
#define LITTLE 1
#define PARSELEN 10
#define TEXTLEN  (PARSELEN + 2)

#include "snort.h"
#include "profiler.h"
#ifdef PERF_PROFILING
PreprocStats byteTestPerfStats;
extern PreprocStats ruleOTNEvalPerfStats;
#endif

extern const u_int8_t *doe_ptr;

typedef struct _ByteTestData
{
    u_int32_t bytes_to_compare; /* number of bytes to compare */
    u_int32_t cmp_value;
    u_int32_t operator;
    int32_t offset;
    u_int8_t not_flag;
    u_int8_t relative_flag;
    u_int8_t data_string_convert_flag;
    u_int8_t endianess;
    u_int32_t base;
} ByteTestData;

#ifdef DETECTION_OPTION_TREE
#include "detection_options.h"
#endif /* DETECTION_OPTION_TREE */

extern u_int8_t DecodeBuffer[DECODE_BLEN];

void ByteTestInit(char *, OptTreeNode *, int);
void ByteTestParse(char *, ByteTestData *, OptTreeNode *);
#ifdef DETECTION_OPTION_TREE
int ByteTest(void *option_data, Packet *p);
#else
int ByteTest(Packet *, struct _OptTreeNode *, OptFpList *);
#endif

#ifdef DETECTION_OPTION_TREE
u_int32_t ByteTestHash(void *d)
{
    u_int32_t a,b,c;
    ByteTestData *data = (ByteTestData *)d;

    a = data->bytes_to_compare;
    b = data->cmp_value;
    c = data->operator;

    mix(a,b,c);

    a += data->offset;
    b += (data->not_flag << 24 |
          data->relative_flag << 16 |
          data->data_string_convert_flag << 8 |
          data->endianess);
    c += data->base;

    mix(a,b,c);

    a += RULE_OPTION_TYPE_BYTE_TEST;

    final(a,b,c);

    return c;
}

int ByteTestCompare(void *l, void *r)
{
    ByteTestData *left = (ByteTestData *)l;
    ByteTestData *right = (ByteTestData *)r;

    if (!left || !right)
        return DETECTION_OPTION_NOT_EQUAL;
    
    if (( left->bytes_to_compare == right->bytes_to_compare) &&
        ( left->cmp_value == right->cmp_value) &&
        ( left->operator == right->operator) &&
        ( left->offset == right->offset) &&
        ( left->not_flag == right->not_flag) &&
        ( left->relative_flag == right->relative_flag) &&
        ( left->data_string_convert_flag == right->data_string_convert_flag) &&
        ( left->endianess == right->endianess) &&
        ( left->base == right->base) )
    {
        return DETECTION_OPTION_EQUAL;
    }

    return DETECTION_OPTION_NOT_EQUAL;
}
#endif /* DETECTION_OPTION_TREE */

/****************************************************************************
 * 
 * Function: SetupByteTest()
 *
 * Purpose: Load 'er up
 *
 * Arguments: None.
 *
 * Returns: void function
 *
 ****************************************************************************/
void SetupByteTest(void)
{
    /* map the keyword to an initialization/processing function */
    RegisterPlugin("byte_test", ByteTestInit, OPT_TYPE_DETECTION);

#ifdef PERF_PROFILING
    RegisterPreprocessorProfile("byte_test", &byteTestPerfStats, 3, &ruleOTNEvalPerfStats);
#endif
    DEBUG_WRAP(DebugMessage(DEBUG_PLUGIN,"Plugin: ByteTest Setup\n"););
}


/****************************************************************************
 * 
 * Function: ByteTestInit(char *, OptTreeNode *)
 *
 * Purpose: Generic rule configuration function.  Handles parsing the rule 
 *          information and attaching the associated detection function to
 *          the OTN.
 *
 * Arguments: data => rule arguments/data
 *            otn => pointer to the current rule option list node
 *            protocol => protocol the rule is on (we don't care in this case)
 *
 * Returns: void function
 *
 ****************************************************************************/
void ByteTestInit(char *data, OptTreeNode *otn, int protocol)
{
    ByteTestData *idx;
    OptFpList *fpl;
#ifdef DETECTION_OPTION_TREE
    void *idx_dup;
#endif

    /* allocate the data structure and attach it to the
       rule's data struct list */
    idx = (ByteTestData *) calloc(sizeof(ByteTestData), sizeof(char));

    if(idx == NULL)
    {
        FatalError("%s(%d): Unable to allocate byte_test data node\n", 
                file_name, file_line);
    }

    /* this is where the keyword arguments are processed and placed into the 
       rule option's data structure */
    ByteTestParse(data, idx, otn);

    fpl = AddOptFuncToList(ByteTest, otn);
#ifdef DETECTION_OPTION_TREE
    fpl->type = RULE_OPTION_TYPE_BYTE_TEST;
#endif
    
#ifdef DETECTION_OPTION_TREE
    if (add_detection_option(RULE_OPTION_TYPE_BYTE_TEST, (void *)idx, &idx_dup) == DETECTION_OPTION_EQUAL)
    {
#if 0
        LogMessage("Duplicate ByteCheck:\n%d %d %d %d %c %c %c %c %d\n"
            "%d %d %d %d %c %c %c %c %d\n\n",
            idx->bytes_to_compare,
            idx->cmp_value,
            idx->operator,
            idx->offset,
            idx->not_flag, idx->relative_flag,
            idx->data_string_convert_flag, 
            idx->endianess, idx->base,
            ((ByteTestData *)idx_dup)->bytes_to_compare,
            ((ByteTestData *)idx_dup)->cmp_value,
            ((ByteTestData *)idx_dup)->operator,
            ((ByteTestData *)idx_dup)->offset,
            ((ByteTestData *)idx_dup)->not_flag, ((ByteTestData *)idx_dup)->relative_flag,
            ((ByteTestData *)idx_dup)->data_string_convert_flag, 
            ((ByteTestData *)idx_dup)->endianess, ((ByteTestData *)idx_dup)->base);
#endif
        free(idx);
        idx = idx_dup;
    }
#endif /* DETECTION_OPTION_TREE */

    /* attach it to the context node so that we can call each instance
     * individually
     */
    fpl->context = (void *) idx;

    if (idx->relative_flag == 1)
        fpl->isRelative = 1;

}



/****************************************************************************
 * 
 * Function: ByteTestParse(char *, ByteTestData *, OptTreeNode *)
 *
 * Purpose: This is the function that is used to process the option keyword's
 *          arguments and attach them to the rule's data structures.
 *
 * Arguments: data => argument data
 *            idx => pointer to the processed argument storage
 *            otn => pointer to the current rule's OTN
 *
 * Returns: void function
 *
 ****************************************************************************/
void ByteTestParse(char *data, ByteTestData *idx, OptTreeNode *otn)
{
    char **toks;
    char *endp;
    int num_toks;
    char *cptr;
    int i =0;

    toks = mSplit(data, ",", 12, &num_toks, 0);

    if(num_toks < 4)
        FatalError("ERROR %s (%d): Bad arguments to byte_test: %s\n", file_name,
                file_line, data);

    /* set how many bytes to process from the packet */
    idx->bytes_to_compare = strtol(toks[0], &endp, 10);

    if(toks[0] == endp)
    {
        FatalError("%s(%d): Unable to parse as byte value %s\n",
                   file_name, file_line, toks[0]);
    }

    if(idx->bytes_to_compare > PARSELEN || idx->bytes_to_compare == 0)
    {
        FatalError("%s(%d): byte_test can't process more than "
                "10 bytes!\n", file_name, file_line);
    }

    cptr = toks[1];

    while(isspace((int)*cptr)) {cptr++;}

    if(*cptr == '!')
    {
        DEBUG_WRAP(DebugMessage(DEBUG_PATTERN_MATCH, 
                    "enabling not flag\n"););
       idx->not_flag = 1;
       cptr++;
    }
   
    if (idx->not_flag && strlen(cptr) == 0) 
    {
        idx->operator = BT_EQUALS;
    }
    else
    {
        /* set the operator */
        switch(*cptr)
        {
            case '<': idx->operator = BT_LESS_THAN;
                      break;

            case '=': idx->operator = BT_EQUALS;
                      break;

            case '>': idx->operator = BT_GREATER_THAN;
                      break;

            case '&': idx->operator = BT_AND;
                      break;

            case '^': idx->operator = BT_OR;
                      break;

            default: FatalError("ERROR %s(%d): byte_test unknown "
                             "operator ('%c, %s')\n", file_name, file_line, 
                             *cptr, toks[1]);
        }
    }

    errno = 0;

    /* set the value to test against */
    idx->cmp_value = strtoul(toks[2], &endp, 0);

    if(toks[2] == endp)
    {
        FatalError("%s(%d): Unable to parse as comparison value %s\n",
                   file_name, file_line, toks[2]);
    }

    if(errno == ERANGE)
    {
        printf("Bad range: %s\n", toks[2]);
    }

    /* set offset */
    idx->offset = strtol(toks[3], &endp, 10);

    
    if(toks[3] == endp)
    {
        FatalError("%s(%d): Unable to parse as offset value %s\n",
                   file_name, file_line, toks[3]);
    }

    
    i = 4;

    /* is it a relative offset? */
    if(num_toks > 4)
    {
        while(i < num_toks)
        {
            cptr = toks[i];

            while(isspace((int)*cptr)) {cptr++;}

            if(!strcasecmp(cptr, "relative"))
            {
                /* the offset is relative to the last pattern match */
                idx->relative_flag = 1;
            }
            else if(!strcasecmp(cptr, "string"))
            {
                /* the data will be represented as a string that needs 
                 * to be converted to an int, binary is assumed otherwise
                 */
                idx->data_string_convert_flag = 1;
            }
            else if(!strcasecmp(cptr, "little"))
            {
                idx->endianess = LITTLE;
            }
            else if(!strcasecmp(cptr, "big"))
            {
                /* this is the default */
                idx->endianess = BIG;
            }
            else if(!strcasecmp(cptr, "hex"))
            {
                idx->base = 16;
            }
            else if(!strcasecmp(cptr, "dec"))
            {
                idx->base = 10;
            }
            else if(!strcasecmp(cptr, "oct"))
            {
                idx->base = 8;
            }
            else
            {
                FatalError("%s(%d): unknown modifier \"%s\"\n", 
                        file_name, file_line, cptr);
            }

            i++;
        }
    }

    /* idx->base is only set if the parameter is specified */
    if(!idx->data_string_convert_flag && idx->base)
    {
        FatalError("%s(%d): hex, dec and oct modifiers must be used in conjunction \n"
                   "        with the 'string' modifier\n", file_name,file_line);
    }
    
    mSplitFree(&toks, num_toks);
}


/****************************************************************************
 * 
 * Function: ByteTest(char *, OptTreeNode *, OptFpList *)
 *
 * Purpose: Use this function to perform the particular detection routine
 *          that this rule keyword is supposed to encompass.
 *
 * Arguments: p => pointer to the decoded packet
 *            otn => pointer to the current rule's OTN
 *            fp_list => pointer to the function pointer list
 *
 * Returns: If the detection test fails, this function *must* return a zero!
 *          On success, it calls the next function in the detection list 
 *
 ****************************************************************************/
#ifdef DETECTION_OPTION_TREE
int ByteTest(void *option_data, Packet *p)
{
    ByteTestData *btd = (ByteTestData *)option_data;
    int rval = DETECTION_OPTION_NO_MATCH;
    u_int32_t value = 0;
    int success = 0;
    int use_alt_buffer = p->packet_flags & PKT_ALT_DECODE;
    int dsize;
    const char *base_ptr, *end_ptr, *start_ptr;
    u_int32_t payload_bytes_grabbed = 0;
    PROFILE_VARS;

    PREPROC_PROFILE_START(byteTestPerfStats);

    if(use_alt_buffer)
    {
        dsize = p->alt_dsize;
        start_ptr = (char *)DecodeBuffer;
        DEBUG_WRAP(DebugMessage(DEBUG_PATTERN_MATCH, 
                    "Using Alternative Decode buffer!\n"););
    }
    else
    {
        dsize = p->dsize;
        start_ptr = (char *) p->data;
    }

    base_ptr = start_ptr;
    end_ptr = start_ptr + dsize;
    
    DEBUG_WRAP(DebugMessage(DEBUG_PATTERN_MATCH,
                "[*] byte test firing...\npayload starts at %p\n", start_ptr););

    if(doe_ptr)
    {
        /* @todo: possibly degrade to use the other buffer, seems non-intuitive*/        
        if(!inBounds((const u_int8_t *)start_ptr, (const u_int8_t *)end_ptr, doe_ptr))
        {
            DEBUG_WRAP(DebugMessage(DEBUG_PATTERN_MATCH,
                                    "[*] byte test bounds check failed..\n"););
            PREPROC_PROFILE_END(byteTestPerfStats);
            return rval;
        }
    }

    if(btd->relative_flag && doe_ptr)
    {
        DEBUG_WRAP(DebugMessage(DEBUG_PATTERN_MATCH,
                                "Checking relative offset!\n"););
        base_ptr = (const char *)doe_ptr + btd->offset;
    }
    else
    {
        DEBUG_WRAP(DebugMessage(DEBUG_PATTERN_MATCH,
                                "checking absolute offset %d\n", btd->offset););
        base_ptr = start_ptr + btd->offset;
    }


    /* both of these functions below perform their own bounds checking within
     * byte_extract.c
     */
       
    if(!btd->data_string_convert_flag)
    {
        if(byte_extract(btd->endianess, btd->bytes_to_compare,
                        (const u_int8_t *)base_ptr, (const u_int8_t *)start_ptr, (const u_int8_t *)end_ptr, &value))
        {
            DEBUG_WRAP(DebugMessage(DEBUG_PATTERN_MATCH,
                                    "Byte Extraction Failed\n"););

            PREPROC_PROFILE_END(byteTestPerfStats);
            return rval;
        }

        payload_bytes_grabbed = btd->bytes_to_compare;
    }
    else
    {
        payload_bytes_grabbed = string_extract(btd->bytes_to_compare, btd->base,
                                               (const u_int8_t *)base_ptr, (const u_int8_t *)start_ptr,
                                               (const u_int8_t *)end_ptr, &value);
        if (payload_bytes_grabbed < 0)
        {
            DEBUG_WRAP(DebugMessage(DEBUG_PATTERN_MATCH,
                                    "String Extraction Failed\n"););

            PREPROC_PROFILE_END(byteTestPerfStats);
            return rval;
        }

    }

    DEBUG_WRAP(DebugMessage(DEBUG_PATTERN_MATCH, 
                            "Grabbed %d bytes at offset %d, value = 0x%08X(%u)\n",
                            payload_bytes_grabbed, btd->offset, value, value); );

    switch(btd->operator)
    {
        case BT_LESS_THAN: if(value < btd->cmp_value)
                               success = 1;
                           break;

        case BT_EQUALS: if(value == btd->cmp_value)
                            success = 1;
                        break;

        case BT_GREATER_THAN: if(value > btd->cmp_value)
                                  success = 1;
                              break;

        case BT_AND: if ((value & btd->cmp_value) > 0)
                         success = 1;
                     break;

        case BT_OR: if ((value ^ btd->cmp_value) > 0)
                        success = 1;
                    break;
    }

    if (btd->not_flag)
    {
        DEBUG_WRAP(DebugMessage(DEBUG_PATTERN_MATCH, 
                    "checking for not success...flag\n"););
        if (!success)
        {
            rval = DETECTION_OPTION_MATCH;
        }
    }
    else if (success)
    {
        rval = DETECTION_OPTION_MATCH;
    }

    /* if the test isn't successful, this function *must* return 0 */
    PREPROC_PROFILE_END(byteTestPerfStats);
    return rval;
}
#else
int ByteTest(Packet *p, struct _OptTreeNode *otn, OptFpList *fp_list)
{
    ByteTestData *btd;
    u_int32_t value = 0;
    int success = 0;
    int use_alt_buffer = p->packet_flags & PKT_ALT_DECODE;
    int dsize;
    const char *base_ptr, *end_ptr, *start_ptr;
    u_int32_t payload_bytes_grabbed = 0;
    PROFILE_VARS;

    PREPROC_PROFILE_START(byteTestPerfStats);

    if(use_alt_buffer)
    {
        dsize = p->alt_dsize;
        start_ptr = (char *)DecodeBuffer;
        DEBUG_WRAP(DebugMessage(DEBUG_PATTERN_MATCH, 
                    "Using Alternative Decode buffer!\n"););
    }
    else
    {
        dsize = p->dsize;
        start_ptr = (char *) p->data;
    }

    base_ptr = start_ptr;
    end_ptr = start_ptr + dsize;
    
    DEBUG_WRAP(DebugMessage(DEBUG_PATTERN_MATCH,
                "[*] byte test firing...\npayload starts at %p\n", start_ptr););

    if(doe_ptr)
    {
        /* @todo: possibly degrade to use the other buffer, seems non-intuitive*/        
        if(!inBounds((const u_int8_t *)start_ptr, (const u_int8_t *)end_ptr, doe_ptr))
        {
            DEBUG_WRAP(DebugMessage(DEBUG_PATTERN_MATCH,
                                    "[*] byte test bounds check failed..\n"););
            PREPROC_PROFILE_END(byteTestPerfStats);
            return 0;
        }
    }

    btd = (ByteTestData *) fp_list->context;

    if(btd->relative_flag && doe_ptr)
    {
        DEBUG_WRAP(DebugMessage(DEBUG_PATTERN_MATCH,
                                "Checking relative offset!\n"););
        base_ptr = (const char *)doe_ptr + btd->offset;
    }
    else
    {
        DEBUG_WRAP(DebugMessage(DEBUG_PATTERN_MATCH,
                                "checking absolute offset %d\n", btd->offset););
        base_ptr = start_ptr + btd->offset;
    }


    /* both of these functions below perform their own bounds checking within
     * byte_extract.c
     */
       
    if(!btd->data_string_convert_flag)
    {
        if(byte_extract(btd->endianess, btd->bytes_to_compare,
                        (const u_int8_t *)base_ptr, (const u_int8_t *)start_ptr, (const u_int8_t *)end_ptr, &value))
        {
            DEBUG_WRAP(DebugMessage(DEBUG_PATTERN_MATCH,
                                    "Byte Extraction Failed\n"););

            PREPROC_PROFILE_END(byteTestPerfStats);
            return 0;
        }

        payload_bytes_grabbed = btd->bytes_to_compare;
    }
    else
    {
        payload_bytes_grabbed = string_extract(btd->bytes_to_compare, btd->base,
                                               (const u_int8_t *)base_ptr, (const u_int8_t *)start_ptr,
                                               (const u_int8_t *)end_ptr, &value);
        if (payload_bytes_grabbed < 0)
        {
            DEBUG_WRAP(DebugMessage(DEBUG_PATTERN_MATCH,
                                    "String Extraction Failed\n"););

            PREPROC_PROFILE_END(byteTestPerfStats);
            return 0;
        }

    }

    DEBUG_WRAP(DebugMessage(DEBUG_PATTERN_MATCH, 
                            "Grabbed %d bytes at offset %d, value = 0x%08X(%u)\n",
                            payload_bytes_grabbed, btd->offset, value, value); );

    switch(btd->operator)
    {
        case BT_LESS_THAN: if(value < btd->cmp_value)
                               success = 1;
                           break;

        case BT_EQUALS: if(value == btd->cmp_value)
                            success = 1;
                        break;

        case BT_GREATER_THAN: if(value > btd->cmp_value)
                                  success = 1;
                              break;

        case BT_AND: if ((value & btd->cmp_value) > 0)
                         success = 1;
                     break;

        case BT_OR: if ((value ^ btd->cmp_value) > 0)
                        success = 1;
                    break;
    }

    if (btd->not_flag)
    {
        DEBUG_WRAP(DebugMessage(DEBUG_PATTERN_MATCH, 
                    "checking for not success...flag\n"););
        if (!success)
        {
            PREPROC_PROFILE_END(byteTestPerfStats);
            return fp_list->next->OptTestFunc(p, otn, fp_list->next);
        }
    }
    else if (success)
    {
        PREPROC_PROFILE_END(byteTestPerfStats);
        return fp_list->next->OptTestFunc(p, otn, fp_list->next);
    }

    /* if the test isn't successful, this function *must* return 0 */
    PREPROC_PROFILE_END(byteTestPerfStats);
    return 0;
}
#endif
