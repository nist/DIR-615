#include <tommath.h>
#ifdef BN_MP_SIGNED_BIN_SIZE_C
/* LibTomMath, multiple-precision integer library -- Tom St Denis
 *
 * LibTomMath is a library that provides multiple-precision
 * integer arithmetic as well as number theoretic functionality.
 *
 * The library was designed directly after the MPI library by
 * Michael Fromberger but has been written from scratch with
 * additional optimizations in place.
 *
 * The library is free for all purposes without any express
 * guarantee it works.
 *
 * Tom St Denis, tomstdenis@gmail.com, http://math.libtomcrypt.com
 */

/* get the size for an signed equivalent */
int mp_signed_bin_size (mp_int * a)
{
  return 1 + mp_unsigned_bin_size (a);
}
#endif

/* $Source: /cvsroot/Eagle/apps/dropbear/libtommath/bn_mp_signed_bin_size.c,v $ */
/* $Revision: 1.1 $ */
/* $Date: 2009/03/09 08:50:44 $ */
