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

/* $Id: tag.h,v 1.1 2008/10/01 06:17:10 ken_chiang Exp $ */
#ifndef __TAG_H__
#define __TAG_H__

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include "rules.h"
#include "event.h"
#include "decode.h"

void InitTag(void);
void ParseTag(char *, OptTreeNode *);
int CheckTagList(Packet *, Event *);
void SetTags(Packet *, OptTreeNode *, u_int32_t);
void TagCacheReset(void);

#endif /* __TAG_H__ */
