/* $Id: sp_ip_fragbits.h,v 1.1 2008/10/01 06:17:13 ken_chiang Exp $ */

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
/* Snort Detection Plugin Header for IP Fragment Bits plugin*/

#ifndef __SP_IP_FRAGBITS_H__
#define __SP_IP_FRAGBITS_H__

void SetupFragBits(void);
void SetupFragOffset(void);
#ifdef DETECTION_OPTION_TREE
u_int32_t IpFragBitsCheckHash(void *d);
int IpFragBitsCheckCompare(void *l, void *r);
u_int32_t IpFragOffsetCheckHash(void *d);
int IpFragOffsetCheckCompare(void *l, void *r);
#endif

#endif  /* __SP_IP_FRAGBITS_H__ */
