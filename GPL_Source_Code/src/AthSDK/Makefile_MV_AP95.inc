#
# (C) Copyright 2004 Atheros Communications, Inc.
# All rights reserved.
#
export ENETDIR=$(ENV_PATH)/platform/$(PLATFORM)/drivers/net/ag7100/
export ATH_TOOL_DIR=$(WL_PATH)/linux/tools/

# Set the HAL directory if you have the HAL sources
ifndef HAL 
export HAL=$(WL_PATH)/802_11/common/lmac/hal
endif

# Set the Atheros Rate Control directory if you have the proprietary rate control
ifndef ATH_RATE 
export ATH_RATE=$(WL_PATH)/802_11/common/lmac/ratectr
endif

# Set the Phyerr (radar) directory if you have the proprietary phyerr control
ifndef ATH_PHYERR
export ATH_PHYERR=$(WL_PATH)/802_11/common/lmac/dfs
endif

ifndef KERNELVERSION 
export LSDK_KERNELVERSION =2.6.29
endif

export KERNELRELEASE =2.6.29
export MADWIFITARGET=mipsisa32-be-elf 
ifndef MODULEPATH
export MODULEPATH := $(FS_PATH)/lib/modules/$(LSDK_KERNELVERSION)/net
endif

export MAKEARCH=$(MAKE) ARCH=mips CROSS_COMPILE=arm-none-linux-gnueabi-
export KERNELPATH=$(KERNEL_PATH)
export AP_TYPE=mv_ap95
export BUS=AHB
export TOOLPREFIX := $(KRL_CROSS)
export TOOLPATH := /opt/gcc/bin

ifndef TFTPPATH
export TFTPPATH=/tftpboot
endif

ifndef INSTALLPATH
export INSTALLPATH=$(KERNELPATH)/install
endif

ifndef TOPDIR
export TOPDIR=$(PWD)/..
endif

#NickChou cooy from Z:\AthSDK\platform\AR7161\scripts\ap94\config.ap94
export AH_CAL_IN_FLASH=1
export AH_CAL_RADIOS=2
export AH_CAL_LOCATIONS=0xbf661000,0xbf665000

