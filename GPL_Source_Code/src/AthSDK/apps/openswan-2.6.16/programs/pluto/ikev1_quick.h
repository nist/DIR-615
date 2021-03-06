/* IPsec DOI and Oakley resolution routines
 * Copyright (C) 1998-2002  D. Hugh Redelmeier.
 * Copyright 2005 Michael C. Richardson <mcr@xelerance.com>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.  See <http://www.fsf.org/copyleft/gpl.txt>.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 * for more details.
 *
 * RCSID $Id: ikev1_quick.h,v 1.1 2008/10/01 03:00:01 ken_chiang Exp $
 */

extern stf_status quick_outI1(int whack_sock
    , struct state *isakmp_sa
    , struct connection *c
    , lset_t policy
    , unsigned long try
    , so_serial_t replacing);

extern state_transition_fn
    quick_inI1_outR1,
    quick_inR1_outI2,
    quick_inI2;

