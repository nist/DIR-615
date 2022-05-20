#!/bin/bash
# aes_tab.o is a pseudo object as it's made from aes.o and MPI is optional
export a=`echo -n "src/ciphers/aes/aes_enc.o " ; find . -type f | sort | grep "[.]/src" | grep "[.]c" | grep -v "sha224" | grep -v "sha384" | grep -v "aes_tab" | grep -v "twofish_tab" | grep -v "whirltab" | grep -v "dh_sys" | grep -v "ecc_sys" | grep -v "mpi[.]c" | grep -v "sober128tab" | sed -e 'sE\./EE' | sed -e 's/\.c/\.o/' | xargs`
perl ./parsenames.pl OBJECTS "$a"
export a=`find . -type f | grep [.]/src | grep [.]h | sed -e 'se\./ee' | xargs`
perl ./parsenames.pl HEADERS "$a"

# $Source: /cvsroot/Eagle/apps/dropbear/libtomcrypt/genlist.sh,v $   
# $Revision: 1.1 $   
# $Date: 2009/03/09 08:50:42 $ 
