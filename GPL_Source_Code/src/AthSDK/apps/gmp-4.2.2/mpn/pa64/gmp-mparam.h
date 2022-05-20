/* gmp-mparam.h -- Compiler/machine parameter header file.

Copyright 1991, 1993, 1994, 1999, 2000, 2001, 2002, 2003, 2004, 2006 Free
Software Foundation, Inc.

This file is part of the GNU MP Library.

The GNU MP Library is free software; you can redistribute it and/or modify it
under the terms of the GNU Lesser General Public License as published by the
Free Software Foundation; either version 3 of the License, or (at your
option) any later version.

The GNU MP Library is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License
for more details.

You should have received a copy of the GNU Lesser General Public License along
with the GNU MP Library.  If not, see http://www.gnu.org/licenses/.  */

#define BITS_PER_MP_LIMB 64
#define BYTES_PER_MP_LIMB 8

/* 800 MHz PA 8900 */

/* Generated by tuneup.c, 2004-02-06, cc version B.11.X.32509-32512.GP */

#define MUL_KARATSUBA_THRESHOLD          23
#define MUL_TOOM3_THRESHOLD             102

#define SQR_BASECASE_THRESHOLD            4
#define SQR_KARATSUBA_THRESHOLD          54
#define SQR_TOOM3_THRESHOLD             108

#define MULLOW_BASECASE_THRESHOLD         0  /* always */
#define MULLOW_DC_THRESHOLD             119
#define MULLOW_MUL_N_THRESHOLD          406

#define DIV_SB_PREINV_THRESHOLD           0  /* always */
#define DIV_DC_THRESHOLD                116
#define POWM_THRESHOLD                  190

#define GCD_ACCEL_THRESHOLD               3
#define GCDEXT_THRESHOLD                  0  /* always */
#define JACOBI_BASE_METHOD                2

#define DIVREM_1_NORM_THRESHOLD           0  /* always */
#define DIVREM_1_UNNORM_THRESHOLD         0  /* always */
#define MOD_1_NORM_THRESHOLD              0  /* always */
#define MOD_1_UNNORM_THRESHOLD            0  /* always */
#define USE_PREINV_DIVREM_1               1
#define USE_PREINV_MOD_1                  1
#define DIVREM_2_THRESHOLD                0  /* always */
#define DIVEXACT_1_THRESHOLD              0  /* always */
#define MODEXACT_1_ODD_THRESHOLD          0  /* always */

#define GET_STR_DC_THRESHOLD             20
#define GET_STR_PRECOMPUTE_THRESHOLD     22
#define SET_STR_THRESHOLD             13752

#define MUL_FFT_TABLE  { 464, 928, 1856, 3840, 9216, 20480, 49152, 196608, 786432, 3145728, 12582912, 0 }
#define MUL_FFT_MODF_THRESHOLD          328
#define MUL_FFT_THRESHOLD              2176

#define SQR_FFT_TABLE  { 496, 1056, 2368, 4864, 11264, 28672, 81920, 196608, 786432, 3145728, 12582912, 0 }
#define SQR_FFT_MODF_THRESHOLD          344
#define SQR_FFT_THRESHOLD              2560
