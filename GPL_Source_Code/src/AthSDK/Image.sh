#!/bin/bash

PWD=`pwd`
IMG_DIR=$PWD/image
ZIMAGE_PATH=$IMG_DIR/zImage
CRAMFS_TARGET=$IMG_DIR/target.cramfs
KR_SIZE=`ls -l $ZIMAGE_PATH|awk '{print $5}'`
FS_SIZE=`ls -l $CRAMFS_TARGET|awk '{print $5}'`

ErrorOut()
{
	echo $1
	exit 1
}

if [ ! -f "$ZIMAGE_PATH" ]; then
	ErrorOut "Kernel image not found."
fi

if [ ! -f "$CRAMFS_TARGET" ]; then
	ErrorOut "File system image not found."
fi

echo "AREA: $1"
echo "HARDWARE_ID: $2"
$PWD/apps/header/header $1 $KR_SIZE $FS_SIZE $2 $IMG_DIR/header.hdr
cp $IMG_DIR/zImage $IMG_DIR/$3_$4_image.bin
cat $IMG_DIR/target.cramfs >> $IMG_DIR/$3_$4_image.bin
cat $IMG_DIR/header.hdr >> $IMG_DIR/$3_$4_image.bin
rm -rf $IMG_DIR/header.hdr

echo
echo "Firmware Image: $PWD/image/$3_$4_image.bin"
echo
