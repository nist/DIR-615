/*
// I retain copyright in this code but I encourage its free use provided
// that I don't carry any responsibility for the results. I am especially 
// happy to see it used in free and open source software. If you do use 
// it I would appreciate an acknowledgement of its origin in the code or
// the product that results and I would also appreciate knowing a little
// about the use to which it is being put. I am grateful to Frank Yellin
// for some ideas that are used in this implementation.
//
// Dr B. R. Gladman <brg@gladman.uk.net> 6th April 2001.
//
// This is an implementation of the AES encryption algorithm (Rijndael)
// designed by Joan Daemen and Vincent Rijmen. This version is designed
// to provide both fixed and dynamic block and key lengths and can also 
// run with either big or little endian internal byte order (see aes.h). 
// It inputs block and key lengths in bytes with the legal values being 
// 16, 24 and 32.
*
*/

#ifdef __KERNEL__
#include <linux/types.h>
#else
#include <sys/types.h>
#endif
#include "klips-crypto/aes_cbc.h"
#include "klips-crypto/cbc_generic.h"
#ifdef OCF_ASSIST
#include "klips-crypto/ocf_assist.h"
#endif

/* returns bool success */
int AES_set_key(aes_context *aes_ctx, const u_int8_t *key, int keysize) {
	aes_set_key(aes_ctx, key, keysize, 0);
	return 1;	
}

#ifdef OCF_ASSIST

CBC_IMPL_BLK16(_AES_cbc_encrypt, aes_context, u_int8_t *, aes_encrypt, aes_decrypt);

int
AES_cbc_encrypt(aes_context *ctx, const u_int8_t *in, u_int8_t *out, int ilen,
		const u_int8_t *iv, int encrypt)
{
	if (ocf_aes_assist() & OCF_PROVIDES_AES) {
		return ocf_aes_cbc_encrypt(ctx, in, out, ilen, iv, encrypt);
	} else {
		return _AES_cbc_encrypt(ctx, in, out, ilen, iv, encrypt);
	}
}

#else
CBC_IMPL_BLK16(AES_cbc_encrypt, aes_context, u_int8_t *, aes_encrypt, aes_decrypt);
#endif


/*
 * $Log: aes_cbc.c,v $
 * Revision 1.1  2008/10/01 02:27:54  ken_chiang
 * *** empty log message ***
 *
 * Revision 1.2  2004/07/10 07:48:40  mcr
 * Moved from linux/crypto/ciphers/aes/aes_cbc.c,v
 *
 * Revision 1.1  2004/04/06 02:48:12  mcr
 * 	pullup of AES cipher from alg-branch.
 *
 *
 */
