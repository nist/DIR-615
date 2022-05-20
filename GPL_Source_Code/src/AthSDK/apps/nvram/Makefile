#
# Makefile for ARM-Linux (Star Platfrom)
#

#CFLAGS += -DNVRAM_DEBUG
ifeq ($(CONFIG_VLAN_ROUTER),y)
CFLAGS +=-DCONFIG_VLAN_ROUTER
endif 

ifeq ($(CONFIG_WAN_8021X),y)
CFLAGS += -DCONFIG_WAN_8021X
endif

CFLAGS  += -I. -I$(APPS_PATH)/sutil/
LDFLAGS += -L.
OBJS := nvram.o main.o

all: libnvram.so nvram

clean:
	rm -rf *.o *.so *~ nvram

install:
	install -d $(TARGET)/bin
	install nvram $(TARGET)/bin
	$(STRIP)	$(TARGET)/bin/nvram
	install -D libnvram.so $(TARGET)/lib/libnvram.so
	$(STRIP) $(TARGET)/lib/libnvram.so
	install $(WWW_PATH)/nvram.default $(TARGET)/etc/

uninstall:
	rm -rf $(TARGET)/bin/nvram
	rm -rf $(TARGET)/lib/libnvram.so

libnvram.so: nvram.o
ifeq ($(PLATFORM), sl3516)
	$(CC) -shared -o $@ $^
else
	$(LD) -shared -o $@ $^
endif
	
nvram: main.o
	$(CC) -o  $@ $^ $(CFLAGS) $(LDFLAGS) -lnvram
	

