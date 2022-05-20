/* small demo app that just includes a cipher/hash/prng */
#include <tomcrypt.h>

int main(void)
{
   register_cipher(&rijndael_enc_desc);
   register_prng(&yarrow_desc);
   register_hash(&sha256_desc);
   return 0;
}

/* $Source: /cvsroot/Eagle/apps/dropbear/libtomcrypt/demos/small.c,v $ */
/* $Revision: 1.1 $ */
/* $Date: 2009/03/09 08:50:42 $ */
