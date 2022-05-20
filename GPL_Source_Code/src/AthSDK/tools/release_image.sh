#!/bin/sh

#if [ -z $TFTPPATH ]; then
#echo "TFTPPATH is not defined! "
#exit 1
#fi

PRJ_PATH=$PRJ_PATH
# check the text file to cat into image
if [ -f hwid.txt ]; then
        rm -f hwid.txt
fi

#
# 	Date:	2009-07-15
# 	Name:	jimmy huang
#	Reason:	For us to build image not in /home/AthSDK
#			ex: we can build it under /home/AthSDK-test
#
# oriiginal 
#PLATFORM=`grep WL_PLATFORM= /home/AthSDK/.config | cut -f 2 -d '='`

# For us to build image not in /home/AthSDK
#PLATFORM=`grep WL_PLATFORM= $ENV_PATH/.config | cut -f 2 -d '='`

# Due to what we really need is WL_PLATFORM, and it is export in /home/AthSDK/Makefile,
# why we just take $WL_PLATFORM to use ...
PLATFORM=$WL_PLATFORM

if [ $PLATFORM == ap61 ]; then
cd $IMG_PATH
rm -rf $1image.bin
dd if=vmlinux.$1.bin.l7 of=$1image.bin bs=1k 
dd if=jffs2.$1.bin of=$1image.bin bs=1k seek=576
#dd if=jffs2.$1.bin of=$1image.bin bs=1k seek=640
#dd if=jffs2.$1.bin of=$1image.bin bs=1k seek=512
echo -n $HARDWARE_ID >> $1image.bin
#rm -rf vmlinux*
#rm -rf jffs2.*
cp $1image.bin $TFTPPATH

elif [ $PLATFORM == AR7100 ]; then  
echo $PLATFORM 
cd $IMG_PATH
dd if=vmlinux.lzma of=$1image.bin bs=1k 
dd if=pb42-squash_l of=$1image.bin bs=1k seek=1024
echo -n $HARDWARE_ID >> $1image.bin
cp $1image.bin $TFTPPATH

elif [ $PLATFORM == AP94 ]; then
echo $PLATFORM release_image  
date=`date +%F%H%M`  
cd $IMG_PATH
rm -rf $1image.bin
dd if=vmlinux.lzma.ub of=$1image.bin bs=1k

#NickChou: using ap94-squash_l for fixed rootfs size
dd if=ap94-squash_l of=$1image.bin bs=1k seek=1024
#dd if=ap94-squash of=$1image.bin bs=1k seek=1024

echo -n $HARDWARE_COUNTRYID$HARDWARE_ID >> $1image.bin
cp $1image.bin $TFTPPATH
#cp $1image.bin /home/AthSDK/"$date"-$1image.bin
rm ap94-squash*

elif [ $PLATFORM == MV_AP95 ]; then
echo $PLATFORM release_image  
date=`date +%F%H%M`  
cd $IMG_PATH
rm -rf $1image.squashfs.bin
rm -rf $1image.squashfs-lzma.bin
rm -rf $1image.jffs2.bin

# squashfs
dd if=vmlinux.lzma.ub of=$1image.squashfs.bin bs=1k
dd if=mv_ap95-squash of=$1image.squashfs.bin bs=1k seek=1536

# squashfs-lzma
dd if=vmlinux.lzma.ub of=$1image.squashfs-lzma.bin bs=1k
dd if=mv_ap95-squash-lzma of=$1image.squashfs-lzma.bin bs=1k seek=1536

# jffs2
dd if=vmlinux.lzma.ub of=$1image.jffs2.bin bs=1k
dd if=mv_ap95-jffs2 of=$1image.jffs2.bin bs=1k seek=1536


echo -n $HARDWARE_COUNTRYID$HARDWARE_ID >> $1image.squashfs.bin
echo -n $HARDWARE_COUNTRYID$HARDWARE_ID >> $1image.jffs2.bin
cp $1image.squashfs.bin $TFTPPATH
cp $1image.squashfs-lzma.bin $TFTPPATH
cp $1image.jffs2.bin $TFTPPATH
#cp $1image.bin /home/AthSDK/"$date"-$1image.bin
#rm mv_ap95-jffs2*
#rm mv_ap95-squash*

else 
echo $PLATFORM 
cd $IMG_PATH
dd if=vmlinux.lzma.ub of=$1image.bin bs=1k 
dd if=pb42-squash_l of=$1image.bin bs=1k seek=1024
#   Date: 2009-2-18
#   Name: Ken Chiang
#   Reason: To use different hardware country ID for US and other regions for DIR-615_C1.
#   Notice :
echo -n $HARDWARE_COUNTRYID$HARDWARE_ID >> $1image.bin
cp $1image.bin $TFTPPATH
rm pb42-squash*
fi
