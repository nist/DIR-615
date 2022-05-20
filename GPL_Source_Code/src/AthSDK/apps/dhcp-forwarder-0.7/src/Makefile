# jimmy created

# for test, if u want to directly make in this directory
# unmark the line below
# for : DIR-615
#include $(ENV_PATH)/platform/$(PLATFORM)/env.mk
# for : DIR-730
#export PATH+=:/usr/local/920t_le/bin
# -------------------------------------------

include ../../../.config

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

#gcc  -g -O2 -Wall -W -Wno-unused-function -std=c99 -pedantic   -o dhcp-fwd  
CFLAGS += -I../ -Wall -g -O2
CFLAGS += -DHAVE_CONFIG_H
CFLAGS += -DCFG_FILENAME='"/tmp/etc/dhcp-fwd.cfg"'

#OBJS = src/parser.o src/main.o src/cfg.o src/recvfromflags.o src/output.o   
OBJS = parser.o main.o cfg.o recvfromflags.o output.o   
BIN = dhcp-fwd

all: $(BIN)

$(BIN): $(OBJS)
	$(CC) $(OBJS) -o $@

clean:
#	/bin/rm -f src/*.o
	rm -f *.o
	rm -f $(BIN)
	

install: $(BIN)
	cp $(BIN) $(TARGET)/sbin


.SUFFIXES: .o .c

.c.o : 
## if main.c, then $< would be main.c, $@ would be main.o
	$(CC) $(CFLAGS) -c $<



