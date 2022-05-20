# Generated automatically from Makefile.in by configure.
#include ../../../../../../../.config
#export CROSS_COMPILE := $(APPS_CROSS)
#export APPS_PATH := $(ENV_PATH)/apps
#export FS_PATH := $(ENV_PATH)/rootfs/target
#export TARGET := $(FS_PATH)
#export CC := $(CROSS_COMPILE)gcc
#export AS := $(CROSS_COMPILE)as
#export AR := $(CROSS_COMPILE)ar
#export LD := $(CROSS_COMPILE)ld
#export CCPP := $(CROSS_COMPILE)g++
#export COMPILER := $(CROSS_COMPILE)g++
#export STRIP := $(CROSS_COMPILE)strip
#export SIZE := $(CROSS_COMPILE)size
#export RANLIB := $(CROSS_COMPILE)ranlib
#export TOP := $(APPS_PATH)
# -------------------------------------


OBJS = uri.o

CFLAGS = -I../../../../../ -I../../../../src/inc -I../../../../../ixml/inc/ \
	-I../../../../../threadutil/inc/ -I../../../../../upnp/inc/ \
	-g -O2 -Os -Wall \
	-D_GNU_SOURCE -pthread


ifeq ($(ENABLE_DEBUG),y)
CFLAGS         += -DDEBUG
else
CFLAGS         += -DNDEBUG
endif

#LIB_BIN = libthreadutil.a


all: $(OBJS)
	@echo "Building $(LIB_BIN) ..."
	$(STRIP) --strip-unneeded $(OBJS)

install:
#	cd upnp/sample/linux-igd; $(MAKE) install


clean:
	rm -rf $(OBJS)
	rm -rf *~

.c.o:
	$(CC) $(CFLAGS) -c $< -o $*.o



