/*
** Copyright (C) 2005-2008 Sourcefire, Inc
** Author: Steven Sturges
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

/* $Id: sf_dynamic_preproc_lib.h,v 1.1 2008/10/01 06:17:14 ken_chiang Exp $ */

/* Snort Dynamic Preprocessor */

#ifndef __SF_DYNAMIC_PREPROC_LIB_H_
#define __SF_DYNAMIC_PREPROC_LIB_H_

#ifdef WIN32
#ifdef SF_SNORT_PREPROC_DLL
#define PREPROC_LINKAGE __declspec(dllexport)
#else
#define PREPROC_LINKAGE __declspec(dllimport)
#endif
#else /* WIN32 */
#define PREPROC_LINKAGE
#endif /* WIN32 */

#endif  /* __SF_DYNAMIC_PREPROC_LIB_H_ */
