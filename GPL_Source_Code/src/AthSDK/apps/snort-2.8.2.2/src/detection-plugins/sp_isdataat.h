/*
** Copyright (C) 2003-2008 Sourcefire, Inc.
** 
** Brian Caswell <bmc@snort.org>
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

/* $Id: sp_isdataat.h,v 1.1 2008/10/01 06:17:13 ken_chiang Exp $ */

#ifndef __SP_ISDATAAT_H__
#define __SP_ISDATAAT_H__

void SetupIsDataAt(void);
#ifdef DETECTION_OPTION_TREE
u_int32_t IsDataAtHash(void *d);
int IsDataAtCompare(void *l, void *r);
#endif

#endif  /* __SP_ISDATAAT_H__ */
