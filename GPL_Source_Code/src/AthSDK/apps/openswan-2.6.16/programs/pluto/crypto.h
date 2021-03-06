/* crypto interfaces
 * Copyright (C) 1998, 1999  D. Hugh Redelmeier.
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
 * RCSID $Id: crypto.h,v 1.1 2008/10/01 03:00:01 ken_chiang Exp $
 */

#ifndef _CRYPTO_H
#define _CRYPTO_H

#include <gmp.h>    /* GNU MP library */

#include "sha1.h"
#include "md5.h"
#ifdef USE_SHA2
#include "libsha2/sha2.h"
#endif

#include "mpzfuncs.h"

extern void init_crypto(void);

/* Oakley group descriptions */

extern MP_INT groupgenerator;	/* MODP group generator (2) */

struct oakley_group_desc {
    u_int16_t group;
    MP_INT *modulus;
    size_t bytes;
};

extern const struct oakley_group_desc unset_group;	/* magic signifier */
extern const struct oakley_group_desc *lookup_group(u_int16_t group);
extern const struct oakley_group_desc oakley_group[];
extern const unsigned int oakley_group_size;

/* unification of cryptographic encoding/decoding algorithms
 * The IV is taken from and returned to st->st_new_iv.
 * This allows the old IV to be retained.
 * Use update_iv to commit to the new IV (for example, once a packet has
 * been validated).
 */

#define MAX_OAKLEY_KEY_LEN_OLD  (3 * DES_CBC_BLOCK_SIZE)
#define MAX_OAKLEY_KEY_LEN  (256/BITS_PER_BYTE)

struct state;	/* forward declaration, dammit */

struct encrypt_desc;
struct hash_desc;
struct encrypt_desc *crypto_get_encrypter(int alg);
struct hash_desc *crypto_get_hasher(oakley_hash_t alg);
void crypto_cbc_encrypt(const struct encrypt_desc *e, bool enc, u_int8_t *buf, size_t size, struct state *st);

#define update_iv(st)	passert(st->st_new_iv_len <= sizeof(st->st_iv)); memcpy((st)->st_iv, (st)->st_new_iv \
    , (st)->st_iv_len = (st)->st_new_iv_len)

#define init_new_iv(st)     passert(st->st_new_iv_len <= sizeof(st->st_new_iv)); memcpy((st)->st_new_iv, (st)->st_iv, (st)->st_new_iv_len);
#define save_iv(st, tmp)    passert((st)->st_iv_len <= sizeof((tmp))); memcpy((tmp), (st)->st_iv, (st)->st_iv_len);
#define save_new_iv(st, tmp)  passert((st)->st_new_iv_len <= sizeof((tmp))); memcpy((tmp), (st)->st_new_iv, (st)->st_new_iv_len);
#define set_iv(st, tmp)     passert((st)->st_iv_len <= sizeof((st)->st_iv)); memcpy((st)->st_iv, (tmp), (st)->st_iv_len);
#define set_new_iv(st, iv)  passert((st)->st_new_iv_len <= sizeof((st)->st_new_iv)); memcpy((st)->st_new_iv, (iv), (st)->st_new_iv_len);
#define set_ph1_iv(st, iv)  passert((st)->st_ph1_iv_len <= sizeof((st)->st_ph1_iv)); memcpy((st)->st_ph1_iv, (iv), (st)->st_ph1_iv_len);

/* unification of cryptographic hashing mechanisms */

union hash_ctx {
    MD5_CTX ctx_md5;
    SHA1_CTX ctx_sha1;
#ifdef USE_SHA2
    sha256_context ctx_sha256;
    sha512_context ctx_sha512;
#endif
};


/* HMAC package
 * Note that hmac_ctx can be (and is) copied since there are
 * no persistent pointers into it.
 */

#ifndef NO_HASH_CTX
struct hmac_ctx {
    const struct hash_desc *h;	/* underlying hash function */
    size_t hmac_digest_len;	/* copy of h->hash_digest_len */
    union hash_ctx hash_ctx;	/* ctx for hash function */
    u_char buf1[HMAC_BUFSIZE], buf2[HMAC_BUFSIZE];
#ifdef USE_SHA2
    sha256_context ctx_sha256;
    sha512_context ctx_sha512;
#endif
};

extern void hmac_init(
    struct hmac_ctx *ctx,
    const struct hash_desc *h,
    const u_char *key,
    size_t key_len);

#define hmac_init_chunk(ctx, h, ch) hmac_init((ctx), (h), (ch).ptr, (ch).len)

extern void hmac_reinit(struct hmac_ctx *ctx);	/* saves recreating pads */

extern void hmac_update(
    struct hmac_ctx *ctx,
    const u_char *data,
    size_t data_len);

#define hmac_update_chunk(ctx, ch) hmac_update((ctx), (ch).ptr, (ch).len)

extern void hmac_final(u_char *output, struct hmac_ctx *ctx);

#define hmac_final_chunk(ch, name, ctx) { \
	pfreeany((ch).ptr); \
	(ch).len = (ctx)->hmac_digest_len; \
	(ch).ptr = alloc_bytes((ch).len, name); \
	hmac_final((ch).ptr, (ctx)); \
    }
#endif

#endif /* _CRYPTO_H */

/*
 * Local Variables:
 * c-basic-offset:4
 * c-style: pluto
 * End:
 */
