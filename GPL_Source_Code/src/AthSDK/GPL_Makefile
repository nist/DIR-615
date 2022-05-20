include .config

include $(ENV_PATH)/platform/$(PLATFORM)/env.mk

export PLATFORM := $(PLATFORM)
export WL_PLATFORM := $(WL_PLATFORM)

export PRJ_PATH := $(ENV_PATH)
export FS_PATH := $(ENV_PATH)/rootfs/target

ifeq ($(WL_PLATFORM), AP71)	
include Makefile_ap71.inc
endif

ifeq ($(WL_PLATFORM), ap61)	
include Makefile.inc
endif

ifeq ($(WL_PLATFORM), AP81)	
include Makefile_ap81.inc
endif

ifeq ($(WL_PLATFORM), AP83)	
include Makefile_ap83.inc
ifeq ($(ETH_SWITCH), CFG_RTL8366SR_PHY)	
export ETH_SWITCH := $(ETH_SWITCH)
endif
endif

ifeq ($(WL_PLATFORM), AP94)	
include Makefile_ap94.inc
endif

ifeq ($(WL_PLATFORM), AP95)	
include Makefile_MV_AP95.inc
endif

ifeq ($(WL_PLATFORM), PB44)	
include Makefile_pb44.inc
endif

ifeq ($(WL_PLATFORM), RT2880)
export KERNEL_PATH := $(ENV_PATH)/platform/$(PLATFORM)/kernels/2.6.15_storlink
export LOADER_PATH := $(ENV_PATH)/platform/$(PLATFORM)/sl-boot
else
ifeq ($(WL_PLATFORM), PB44)	
export KERNEL_PATH := $(ENV_PATH)/platform/$(PLATFORM)/kernels/2.6.15_storlink
export LOADER_PATH := $(ENV_PATH)/platform/$(PLATFORM)/sl-boot
else	
ifeq ($(WL_PLATFORM), AP95)	
export KERNEL_PATH := $(ENV_PATH)/platform/$(PLATFORM)/kernels/arm-linux-$(LSDK_KERNELVERSION)
export LOADER_PATH := $(ENV_PATH)/platform/$(PLATFORM)/redboot_cobra
else
ifeq ($(WL_PLATFORM), AP94)
export KERNEL_PATH := $(ENV_PATH)/platform/$(PLATFORM)/kernels/mips-linux-$(LSDK_KERNELVERSION)
export LOADER_PATH := $(ENV_PATH)/platform/$(PLATFORM)/redboot_cobra
else
export KERNEL_PATH := $(ENV_PATH)/platform/$(PLATFORM)/kernels/mips-linux-$(LSDK_KERNELVERSION)
export LOADER_PATH := $(ENV_PATH)/platform/$(PLATFORM)/redboot_cobra
endif
endif
endif
endif


export WL_PATH := $(ENV_PATH)/wireless/$(WL_PLATFORM)
export APPS_PATH := $(ENV_PATH)/apps
export IMG_PATH := $(ENV_PATH)/image
export TOOL_PATH := $(ENV_PATH)/tools
export WWW_PATH := $(ENV_PATH)/www/$(CONFIG_MODEL_NAME)
export PLATFORM_PATH := $(ENV_PATH)/platform/$(PLATFORM)
export PATH:=$(TOOL_PATH):${PATH}

export CONFIG_MODEL_NAME := $(CONFIG_MODEL_NAME)
export CONFIG_MODEL_NAME_NO_DASH := $(shell perl -w $(PRJ_PATH)/tools/split.pl $(CONFIG_MODEL_NAME))
export HARDWARE_ID := $(HARDWARE_ID)
export APPS_CROSS := $(APPS_CROSS)
export KRL_CROSS := $(KRL_CROSS)
export WL_CROSS := $(WL_CROSS)

export APPS_CFLAG := $(APPS_CFLAG)
export KRL_CFLAG := $(KRL_CFLAG)
export WL_CFLAG := $(WL_CFLAG)



all: mytools build install

normal: normal_build install

normal_build:
	$(MAKE) -C apps;	

ifeq ($(PLATFORM), sl3516)
export SVNREV := $(SVNREV)
APPS:=$(wildcard apps/*)
APPS+=apps/cgi apps/cmds
$(APPS):
	$(MAKE) -C apps $(notdir $@)

$(addsuffix -install, $(APPS)):
	$(MAKE) -C apps $(notdir $@)
$(addsuffix -clean, $(APPS)):
	$(MAKE) -C apps $(notdir $@)
endif

build:
	echo $(PATH)
	rm -fr $(IMG_PATH)
	mkdir -p $(IMG_PATH)
ifeq ($(CONFIG_MODEL_NAME),TEW-670APB)
	sh $(WWW_PATH)/init_apps.sh
endif

ifeq ($(CONFIG_MODEL_NAME),WLAN-2000)
	sh $(WWW_PATH)/init_apps.sh
endif

	$(MAKE) -C rootfs
	$(MAKE) -C platform
	$(MAKE) -C apps 
	
mytools:
	@echo =================== tools ===================
	$(MAKE) -C ./tools/cp_html
	$(MAKE) -C ./tools/squashfs-tools

install:
	$(MAKE) -C platform install
	$(MAKE) -C apps install
	$(MAKE) -C rootfs install
	@echo =================== Finish ===================

clean:
	$(MAKE) -C apps clean
	$(MAKE) -C platform clean
	$(MAKE) -C rootfs clean
	$(MAKE) -C ./tools/cp_html clean
	$(MAKE) -C ./tools/squashfs-tools clean

conf mconf:
	$(MAKE) -C config
	@./config/$@ ./config/Config
	# kernel configure
	$(MAKE) apps$@

appsconf:
	$(MAKE) -C $(APPS_PATH) config

appsmconf:
	$(MAKE) -C $(APPS_PATH) menuconfig
		

menuconfig: mconf

# Default configurations
.config:
	cp config/defconfig $@
	$(MAKE) mconf
    
apps:
	$(MAKE) -C apps clean
	$(MAKE) -C apps 

#
### Generic rules
#
%:
	[ ! -d $* ] || $(MAKE) -C $*

%-clean:
	[ ! -d $* ] || $(MAKE) -C $* clean

%-install:
	[ ! -d $* ] || $(MAKE) -C $* install
		
.PHONY: all clean install
.PHONY: apps 
ifneq ($(PLATFORM), sl3516)
.PHONY: dummy
else
.PHONY: dummy $(APPS)
endif
