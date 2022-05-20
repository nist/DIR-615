/*
 * Multicast Routing Daemon (MRD)
 *   msnip_def.h
 *
 * Copyright (C) 2004, 2005
 *  Universidade de Aveiro, Instituto Telecomunicacoes - Polo Aveiro
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 * Authors:	Hugo Santos <hsantos@av.it.pt>
 */

#ifndef _mrd_msnip_def_h_
#define _mrd_msnip_def_h_

#include <netinet/in.h>
#include <netinet/icmp6.h>

#define MSNIP_HIS_REPORT 202
#define MSNIP_MRM_REPORT 203

enum {
	MSNIP_TRANSMIT = 1,
	MSNIP_HOLD = 2
};

struct msnip_his : icmp6_hdr {
};

struct msnip_mrm : icmp6_hdr {
	struct {
		uint8_t rectype;
		uint8_t resv[3];
		in6_addr address;
	} __attribute((packed)) records[0];
};

#endif

