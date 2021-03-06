#include <stdio.h>
#include <string.h>
#include <stddef.h>
#include <sys/types.h>
#include <openswan.h>

#include "constants.h"
#include "defs.h"
#include "log.h"
#include "libsha2/sha2.h"
#include "alg_info.h"
#include "ike_alg.h"

static void sha256_hash_final(u_char *hash, sha256_context *ctx)
{
	sha256_final(ctx);
	memcpy(hash, &ctx->sha_out[0], SHA2_256_DIGEST_SIZE);
}
static void sha512_hash_final(u_char *hash, sha512_context *ctx)
{
	sha512_final(ctx);
	memcpy(hash, &ctx->sha_out[0], SHA2_512_DIGEST_SIZE);
}
struct hash_desc hash_desc_sha2_256 = {
	common:{officname:  "sha256",
		algo_type: IKE_ALG_HASH,
		algo_id:   OAKLEY_SHA2_256,
		algo_next: NULL, },
	hash_ctx_size: sizeof(sha256_context),
	hash_key_size: 0,
	hash_digest_len: SHA2_256_DIGEST_SIZE,
        hash_init: (void (*)(void *))sha256_init,
	hash_update: (void (*)(void *, const u_char *, size_t ))sha256_write,
	hash_final:(void (*)(u_char *, void *))sha256_hash_final,
};
struct hash_desc hash_desc_sha2_512 = {
	common:{officname: "sha512",
		algo_type: IKE_ALG_HASH,
		algo_id:   OAKLEY_SHA2_512,
		algo_next: NULL, },
	hash_ctx_size: sizeof(sha512_context),
	hash_key_size: 0,
	hash_digest_len: SHA2_512_DIGEST_SIZE,
        hash_init: (void (*)(void *))sha512_init,
	hash_update: (void (*)(void *, const u_char *, size_t ))sha512_write,
	hash_final:(void (*)(u_char *, void *))sha512_hash_final,
};
int ike_alg_sha2_init(void);
int
ike_alg_sha2_init(void)
{
	int ret;
	ret = ike_alg_register_hash(&hash_desc_sha2_512);
	if (ret)
		goto out;
	ret = ike_alg_register_hash(&hash_desc_sha2_256);
out:
	return ret;
}
/*
IKE_ALG_INIT_NAME: ike_alg_sha2_init
*/
