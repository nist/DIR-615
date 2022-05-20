/*
 * Multicast Routing Daemon (MRD)
 *   mrd_components.cpp
 *
 * Copyright (C) 2004 Univ. Aveiro, Instituto Telecomunicacoes - Polo Aveiro
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
 * Authors:	Hugo Santos, <hsantos@av.it.pt>
 */

#include <mrd/mrd.h>

#include <mrdpriv/bsd/mfa.h>
#include <mrdpriv/bsd/rib.h>

bool mrd::prepare_os_components() {
	m_mfa = new bsd_mfa();

	return true;
}

void mrd::prepare_second_components() {
	if (!m_rib_handler)
		m_rib_handler = new bsd_rib();
}

const char *mrd::loopback_interface_name() const {
	return "lo0";
}

