#include <stdio.h>

int main(void)
{
   char buf[4096];
   int x;
   
   while (fgets(buf, sizeof(buf)-2, stdin) != NULL) {
        for (x = 0; x < 128; ) {
            printf("0x%c%c, ", buf[x], buf[x+1]);
            if (!((x += 2) & 31)) printf("\n");
        }
   }
}


/* $Source: /cvsroot/Eagle/apps/dropbear/libtomcrypt/notes/etc/whirltest.c,v $ */
/* $Revision: 1.1 $ */
/* $Date: 2009/03/09 08:50:42 $ */
