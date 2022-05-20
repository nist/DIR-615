#!/bin/bash

# source the variables needed for build
TOP=$1/build
cd $TOP

make BOARD_TYPE=ap83 BUILD_TYPE=jffs2 ap83_build
#make BOARD_TYPE=ap83 ram_build
#make BOARD_TYPE=ap83 uboot

echo "---------------------"
#find . -name \* -user root -exec sudo chown build {} \; -print 
#find . -name \.config  -exec chmod 777 {} \; -print 
