/*
 *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
 *                         device functionality on Windows.
 *
 *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
 *
 *  This source code is Copyright (C) 2002-2008 Telethra, Inc.,
 *  and is released under the GPL version 2 (see below), however due
 *  to the extra costs of supporting Windows Vista, OpenVPN Solutions
 *  LLC reserves the right to change the terms of the TAP-Win32/TAP-Win64
 *  license for versions 9.1 and higher prior to the official release of
 *  OpenVPN 2.1.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License version 2
 *  as published by the Free Software Foundation.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program (see the file COPYING included with this
 *  distribution); if not, write to the Free Software Foundation, Inc.,
 *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

typedef struct
{
  volatile long count;
} MUTEX;

#define MUTEX_SLEEP_TIME  10000 // microseconds

#define INIT_MUTEX(m) { (m)->count = 0; }

#define ACQUIRE_MUTEX_BLOCKING(m)                         \
{                                                         \
    while (NdisInterlockedIncrement (&((m)->count)) != 1) \
    {                                                     \
        NdisInterlockedDecrement(&((m)->count));          \
        NdisMSleep(MUTEX_SLEEP_TIME);                     \
    }                                                     \
}

#define RELEASE_MUTEX(m)                                  \
{                                                         \
        NdisInterlockedDecrement(&((m)->count));          \
}

#define ACQUIRE_MUTEX_NONBLOCKING(m, result)              \
{                                                         \
    if (NdisInterlockedIncrement (&((m)->count)) != 1)    \
    {                                                     \
        NdisInterlockedDecrement(&((m)->count));          \
        result = FALSE;                                   \
    }                                                     \
    else                                                  \
    {                                                     \
	result = TRUE;                                    \
    }                                                     \
}

#define ACQUIRE_MUTEX_ADAPTIVE(m, result)                 \
{                                                         \
    result = TRUE;                                        \
    while (NdisInterlockedIncrement (&((m)->count)) != 1) \
    {                                                     \
        NdisInterlockedDecrement(&((m)->count));          \
        if (KeGetCurrentIrql () < DISPATCH_LEVEL)         \
            NdisMSleep(MUTEX_SLEEP_TIME);                 \
        else                                              \
        {                                                 \
	    result = FALSE;                               \
	    break;                                        \
        }                                                 \
    }                                                     \
}
