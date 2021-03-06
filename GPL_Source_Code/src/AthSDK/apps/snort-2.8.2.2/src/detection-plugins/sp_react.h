/* $Id: sp_react.h,v 1.1 2008/10/01 06:17:13 ken_chiang Exp $ */

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

#ifndef __SP_REACT_H__
#define __SP_REACT_H__
#if defined(ENABLE_RESPONSE) || defined(ENABLE_REACT)

void SetupReact(void);
#ifdef DETECTION_OPTION_TREE
void ReactFree(void *d);
u_int32_t ReactHash(void *d);
int ReactCompare(void *l, void *r);
#endif

#endif  /* ENABLE_RESPONSE || ENABLE_REACT */
#endif  /* __SP_REACT_H__ */
