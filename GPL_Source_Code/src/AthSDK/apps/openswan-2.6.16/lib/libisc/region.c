/*
 * Copyright (C) 2004  Internet Systems Consortium, Inc. ("ISC")
 * Copyright (C) 2002  Internet Software Consortium.
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND ISC DISCLAIMS ALL WARRANTIES WITH
 * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS.  IN NO EVENT SHALL ISC BE LIABLE FOR ANY SPECIAL, DIRECT,
 * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
 * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
 * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 * PERFORMANCE OF THIS SOFTWARE.
 */

/* $ISC-Id:region.c,v 1.2.202.3 2004/03/08 09:04:50 marka Exp $ */
/* $Id: region.c,v 1.1 2008/10/01 02:18:49 ken_chiang Exp $ */

#include <config.h>

#include <stdlib.h>
#include <string.h>

#include <isc/region.h>
#include <isc/util.h>

int
isc_region_compare(isc_region_t *r1, isc_region_t *r2) {
	unsigned int l;
	int result;

	REQUIRE(r1 != NULL);
	REQUIRE(r2 != NULL);
	       
	l = (r1->length < r2->length) ? r1->length : r2->length;

	if ((result = memcmp(r1->base, r2->base, l)) != 0)
		return ((result < 0) ? -1 : 1);
	else
		return ((r1->length == r2->length) ? 0 :
			(r1->length < r2->length) ? -1 : 1);
}
