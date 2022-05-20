#!/bin/sh

if [ $# != 1 ]; then
echo "usage: release_rootfs.sh  apType "
echo "ex   : release_rootfs.sh  ap30 "
exit 1
fi

if [ -z $TFTPPATH ]; then
echo "TFTPPATH is not defined! "
exit 1
fi

if [ -z $KERNELPATH ]; then
echo "KERNELPATH is not defined! "
exit 1
fi

if [ -z $INSTALLPATH ]; then
echo "INSTALLPATH is not defined! "
exit 1
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

HAS_4MB_FLASH=`grep "CONFIG_FLASH_4MB=y" $KERNELPATH/.config`
HAS_2MB_FLASH=`grep "CONFIG_FLASH_2MB=y" $KERNELPATH/.config`

if [ $1 == "ap51" -o $1 == "ap51-debug" -o  $1 == "ap48" -o $1 == "ap48-debug" -o $1 == "ap43" -o $1 == "ap43-debug" -o $1 == "ap61" -o $1 == "ap61-debug" -o $1 == "ap63" -o $1 == "ap63-debug" ]; then
    ERASEBLOCK=0x10000
else
    ERASEBLOCK=0x1000
fi

FLASHSIZE="2MB"

if [ $1 == "ap51" -o $1 == "ap51-debug" -o $1 == "ap48" -o $1 == "ap48-debug" -o $1 == "ap43" -o $1 == "ap43-debug" -o $1 == "ap61" -o $1 == "ap61-debug" -o $1 == "ap63" -o $1 == "ap63-debug" ]; then
    PADSIZE=0x140000
else
    PADSIZE=0x141000
fi

if [ ! -z $HAS_4MB_FLASH ]; then
#    PADSIZE=0x300000
#    PADSIZE=0x2DFFE8
#    PADSIZE=0x350000
     PADSIZE=0x300000
     FLASHSIZE="4MB"
fi

if [ $PLATFORM == ap61 ]; then
mkdir -p $INSTALLPATH
pushd $FS_PATH
echo " $PLATFORM "
#echo "**** Creating jffs2 rootfs for $FLASHSIZE flash part ****"
#mkfs.jffs2 -r . -o $INSTALLPATH/jffs2.$1.bin -b --squash --pad=$PADSIZE --eraseblock=$ERASEBLOCK
#sudo cp -f $INSTALLPATH/jffs2.$1.bin $TFTPPATH 
#sudo cp -f $INSTALLPATH/jffs2.$1.bin $IMG_PATH 
#rm -rf $INSTALLPATH/jffs2.*
#echo "  rootfs partition length = $PADSIZE"

#echo ""
#echo "---------------------Create CRAMFS for flash part ------------------------"
#mkcramfs -u -0 -g 0 /home/AthSDK/rootfs/target $INSTALLPATH/jffs2.$1.bin
#sudo cp -f $INSTALLPATH/jffs2.$1.bin $TFTPPATH
#sudo cp -f $INSTALLPATH/jffs2.$1.bin $IMG_PATH
#echo " Cramfs create finish"
echo ""
echo "---------------------Create SQUASHFS for flash part ------------------------"
mksquashfs $TOPDIR/AthSDK/rootfs/target $INSTALLPATH/jffs2.$1.bin -be
sudo cp -f $INSTALLPATH/jffs2.$1.bin $TFTPPATH 
sudo cp -f $INSTALLPATH/jffs2.$1.bin $IMG_PATH 
rm -rf $INSTALLPATH/jffs2.*
echo " Squashfs create finish"

echo ""
popd

echo ""
echo "  Flash using RedBoot commands:"
echo "    RedBoot> load -r -b %{FREEMEMLO} jffs2.$1.bin"
echo "    RedBoot> fis create -f 0xbfc30000 -e 0 rootfs"
echo ""

else

if [ $PLATFORM == AP94 ]; then
	echo "---------------------Create SQUASHFS for $CONFIG_MODEL_NAME $LANGUAGE_PACK flash part----------------"
	$FS_PATH/../setup_rootdir_ap94
	$TOOL_PATH/mksquashfs_ap71 $FS_PATH $IMG_PATH/ap94-squash -be
	chmod 644 $IMG_PATH/ap94-squash 
#	dd if=$IMG_PATH/ap94-squash of=$IMG_PATH/ap94-squash_l bs=2818048 count=1 conv=sync
#	Support Single Langue => rootfs size upperbond = 3MB, CONFIG_MODEL_NAME=DIR-825_B1
#	Support Multi-Langue => rootfs size upperbond = 4.5MB, CONFIG_MODEL_NAME=DIR-825WW_B1
	if [ $LANGUAGE_PACK == Multi ]; then
		dd if=$IMG_PATH/ap94-squash of=$IMG_PATH/ap94-squash_l bs=5242880 count=1 conv=sync
	else	
		dd if=$IMG_PATH/ap94-squash of=$IMG_PATH/ap94-squash_l bs=3145728 count=1 conv=sync
	fi	
#	NickChou: using ap94-squash_l for fixed rootfs size	
	echo "---------------------AP94 Squashfs create finish ---------------------------"

else
if [ $PLATFORM == MV_AP95 ]; then
	$FS_PATH/../setup_rootdir_mv_ap95
	echo "---------------------Create SQUASHFS for $CONFIG_MODEL_NAME $LANGUAGE_PACK flash part----------------"
	# squashfs 4.0
	$TOOL_PATH/mksquashfs4 $FS_PATH $IMG_PATH/mv_ap95-squash
	$TOOL_PATH/mksquashfs4 $FS_PATH $IMG_PATH/mv_ap95-squash-lzma -lzma
	chmod 644 $IMG_PATH/mv_ap95-squash 
	chmod 644 $IMG_PATH/mv_ap95-squash-lzma 
#	dd if=$IMG_PATH/mv_ap95-squash of=$IMG_PATH/mv_ap95-squash_l bs=2818048 count=1 conv=sync
	echo "---------------------MV_AP95 Squashfs create finish ---------------------------"
	echo "---------------------Create JFFS2FS for $CONFIG_MODEL_NAME $LANGUAGE_PACK flash part----------------"
#	mkfs.jffs2 -r $FS_PATH -o $IMG_PATH/$1-jffs2 -b --squash --pad=$PADSIZE --eraseblock=$ERASEBLOCK
	mkfs.jffs2 -r $FS_PATH -o $IMG_PATH/$1-jffs2 -b --squash --pad=6291456 --eraseblock=$ERASEBLOCK
	echo "---------------------MV_AP95 JFFS2FS create finish ---------------------------"

else

echo " Using mksquashfs_ap71 :"
echo " $PLATFORM "
	$FS_PATH/../setup_rootdir_ap71
	$TOOL_PATH/mksquashfs_ap71 $FS_PATH $IMG_PATH/pb42-squash -be 
	chmod 644 $IMG_PATH/pb42-squash 
	dd if=$IMG_PATH/pb42-squash of=$IMG_PATH/pb42-squash_l bs=2818048 count=1 conv=sync
fi # MV_AP95

fi # AP94

fi # ap61

#sudo cp -r $KERNELPATH/arch/mips/ar531x/ROOTDISK/rootdir/lib/modules $TFTPPATH/${1}_modules
