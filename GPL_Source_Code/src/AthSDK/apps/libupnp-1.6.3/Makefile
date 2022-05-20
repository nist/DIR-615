# below is used for mips environment
include ../../.config
export CROSS_COMPILE := $(APPS_CROSS)
export APPS_PATH := $(ENV_PATH)/apps
export FS_PATH := $(ENV_PATH)/rootfs/target
export TARGET := $(FS_PATH)
export CC := $(CROSS_COMPILE)gcc
export AS := $(CROSS_COMPILE)as
export AR := $(CROSS_COMPILE)ar
export LD := $(CROSS_COMPILE)ld
export CCPP := $(CROSS_COMPILE)g++
export COMPILER := $(CROSS_COMPILE)g++
export STRIP := $(CROSS_COMPILE)strip
export SIZE := $(CROSS_COMPILE)size
export RANLIB := $(CROSS_COMPILE)ranlib
# -------------------------------
SUBDIRS = ixml threadutil upnp
PRE_INCLUDE_PATH = .include
PRE_LIBS_PATH = .libs
ENABLE_DEBUG = n

#export ENABLE_DEBUG = y
export ENABLE_DEBUG = n

all:	
	@echo "Building libupnp-1.6.3 ..."
#	@echo "CC=$(CC)"
#	@echo "AS=$(AS)"
#	@echo "AR=$(AR)"
#	@echo "STRIP = $(STRIP)"
#	@echo "RANLIB = $(RANLIB)"
#	@echo "PRE_INCLUDE_PATH = $(PRE_INCLUDE_PATH) "
#	@echo "PRE_LIBS_PATH = $(PRE_LIBS_PATH)"
# do not marked the line below, because some situation our makefiles
# can't detect some files have been changed, unless we fix it :(
	(for d in $(SUBDIRS); do $(MAKE) -C $$d clean; done) || exit 1;
	mkdir -p $(PRE_INCLUDE_PATH)/upnp
	mkdir -p $(PRE_LIBS_PATH)
	(for d in $(SUBDIRS); do $(MAKE) -C $$d all; done) || exit 1;

clean:
	rm -rf $(PRE_INCLUDE_PATH)
	rm -rf $(PRE_LIBS_PATH)	
	rm -rf *~
	(for d in $(SUBDIRS); do $(MAKE) -C $$d clean ; done) || exit 1;

install:
	(for d in $(SUBDIRS); do $(MAKE) -C $$d install ; done) || exit 1;


