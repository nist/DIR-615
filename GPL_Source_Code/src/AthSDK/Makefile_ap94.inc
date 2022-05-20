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
export LSDK_KERNELVERSION =2.6.15
endif

export KERNELRELEASE =2.6.15
export MADWIFITARGET=mipsisa32-be-elf 
ifndef MODULEPATH
export MODULEPATH := $(FS_PATH)/lib/modules/$(LSDK_KERNELVERSION)/net
endif

export MAKEARCH=$(MAKE) ARCH=mips CROSS_COMPILE=mips-linux-
export KERNELPATH=$(KERNEL_PATH)
export AP_TYPE=ap94
export BUS=AHB
export TOOLPREFIX := $(KRL_CROSS)
export TOOLPATH := /opt/ap71_tools/mips32k/bin

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
export BUILD_WPA2=y
export MADWIFIPATH=/home/AthSDK/wireless/AP94/802_11/linux/
export MADWIFIINC=/home/AthSDK/wireless/AP94/802_11/
#for station forwarding support
export CONFIG_ETHERSTA=n
export BUS=PCI
export MADWIFITARGET=mipsisa32-be-elf
export FUSIONTARGET=mipsisa32-be-elf
#
# Set a large file size image to take advantage of the 8 MB part by default
#
export TARGETFSSIZE=0x600000

#
# Select the support required for this board
#

export AH_SUPPORT_AR5210=0
export AH_SUPPORT_AR5211=0
export AH_SUPPORT_AR5212=0
export AH_SUPPORT_AR5416=1
export AH_SUPPORT_5111=0
export AH_SUPPORT_5112=0
export AH_SUPPORT_2413=0
export AH_SUPPORT_5413=0
export AH_SUPPORT_2316=0
export AH_SUPPORT_2317=0
export AH_SUPPORT_2425=0
export AH_SUPPORT_2133=1

#
# Environmental variables used to configure the HAL/ATH layers at compile time
#
export ATH_RB=0
export ATH_CAP_PHYERR_DIAG=0
export AH_DEBUG=0
export ATH_FORCE_BIAS=1
export ATH_SUPPORT_DFS=1
export IEEE_MCAST_ENHANCEMENT=1
export ATH_SUPPORT_IQUE=1
export ATH_WPS_IE=1