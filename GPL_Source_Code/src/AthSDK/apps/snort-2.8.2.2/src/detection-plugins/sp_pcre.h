/* $Id: sp_pcre.h,v 1.1 2008/10/01 06:17:13 ken_chiang Exp $ */
/*
** Copyright (C) 2003 Brian Caswell <bmc@snort.org>
** Copyright (C) 2003 Michael J. Pomraning <mjp@securepipe.com>
** Copyright (C) 2003-2008 Sourcefire, Inc.
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

/*  I N C L U D E S
**********************************************************/

/*  D E F I N E S
************************************************************/
#ifndef __SNORT_PCRE_H__
#define __SNORT_PCRE_H__

void SetupPcre(void);

#ifdef DETECTION_OPTION_TREE
#include <pcre.h>
typedef struct _PcreData
{
    pcre *re;           /* compiled regex */
    pcre_extra *pe;     /* studied regex foo */
    int options;        /* sp_pcre specfic options (relative & inverse) */
    char *expression;
    u_int32_t search_offset;
} PcreData;

void PcreFree(void *d);
u_int32_t PcreHash(void *d);
int PcreCompare(void *l, void *r);
void PcreDuplicatePcreData(void *src, PcreData *pcre_dup);
int PcreAdjustRelativeOffsets(PcreData *pcre, u_int32_t search_offset);
#endif

#endif /* __SNORT_PCRE_H__ */
