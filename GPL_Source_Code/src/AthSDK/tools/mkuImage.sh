#!/bin/sh -x

#
# $1 == u-boot/tools path
# $2 == kernel tree path
# $3 == kernel type
#
MKIMAGE=$TOOL_PATH/mkimage
VMLINUX=$1/vmlinux
VMLINUXBIN=$1/arch/mips/boot/vmlinux.bin

if [ $3 == ap94 ]; then
	#NickChou for AP94 Low memory load
	LDADDR=0x80002000
else
if [ $3 == mv_ap95 ]; then
#	LDADDR=0xF8100000
	LDADDR=0x00008000
else
LDADDR=0x80060000
fi
fi

TFTPPATH=/tftpboot
IMAGEDIR=$2/vmlinux.lzma

ENTRY=`readelf -a ${VMLINUX}|grep "Entry"|cut -d":" -f 2`

if [ $3 == mv_ap95 ]; then
	ENTRY=0x00008000
fi

#gzip -f ${VMLINUXBIN}

#${MKIMAGE} -A mips -O linux -T kernel -C gzip \
#        -a ${LDADDR} -e ${ENTRY} -n "Linux Kernel Image"    \
#               -d ${VMLINUXBIN}.gz ${TFTPPATH}/vmlinux.gz.uImage

if [ $3 == mv_ap95 ]; then
${MKIMAGE} -A arm -O linux -T kernel -C lzma \
        -a ${LDADDR} -e ${ENTRY} -n "Linux Kernel Image"    \
                -d ${IMAGEDIR} $2/vmlinux.lzma.ub
else
${MKIMAGE} -A mips -O linux -T kernel -C lzma \
        -a ${LDADDR} -e ${ENTRY} -n "Linux Kernel Image"    \
                -d ${IMAGEDIR} $2/vmlinux.lzma.ub
fi
