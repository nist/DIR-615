#include <tomcrypt_test.h>

void run_cmd(int res, int line, char *file, char *cmd)
{
   if (res != CRYPT_OK) {
      fprintf(stderr, "%s (%d)\n%s:%d:%s\n", error_to_string(res), res, file, line, cmd);
      if (res != CRYPT_NOP) {
         exit(EXIT_FAILURE);
      }
   }
}

/* $Source: /cvsroot/Eagle/apps/dropbear/libtomcrypt/testprof/test_driver.c,v $ */
/* $Revision: 1.1 $ */
/* $Date: 2009/03/09 08:50:44 $ */
