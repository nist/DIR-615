# http Makefile
# Copyright 2005, CAMEO Corporation
# All Rights Reserved.
#

ifeq ($(CONFIG_HTTPD_PURE),y)
CFLAGS += -DPURE_NETWORK_ENABLE
endif
	
ifeq ($(CONFIG_TC),y)
CFLAGS += -DCONFIG_TC
endif

ifeq ($(CONFIG_XML_AGENT),y)
CFLAGS += -DXML_AGENT
endif

ifeq ($(CONFIG_AJAX),y)
CFLAGS += -DAJAX
endif

# Support radvd or not
ifeq ($(CONFIG_RADVD),y)
CFLAGS +=-DRADVD
endif

# Support graphic auth or not
ifeq ($(CONFIG_AUTHGRAPH),y)
CFLAGS += -DAUTHGRAPH
endif

# Support HTTPS
ifeq ($(CONFIG_HTTPS),y)
CFLAGS += -DHAVE_HTTPS -I$(APPS_PATH)/openssl/include
LDFLAGS += -L$(APPS_PATH)/openssl -lssl -lcrypto
endif

CFLAGS += -I. -I$(APPS_PATH)/sutil/ -I$(APPS_PATH)/nvram/ -I$(APPS_PATH)/udhcp -I$(APPS_PATH)/libplatform/ -I$(KERNEL_PATH)/include/
CFLAGS += -D$(CONFIG_MODEL_NAME) -D$(PLATFORM)

ifeq ($(CONFIG_IPV6_SUPPORT),y)
LDFLAGS += -lipv6
endif

ifeq ($(CONFIG_UPNP_ATH_MINIUPNPD_1_3_CHECK_VS_NVRAM),y)
	CFLAGS += -DUPNP_CHECK_VS_NVRAM
endif

LDFLAGS += -L$(APPS_PATH)/nvram -lnvram -L$(APPS_PATH)/sutil -lsutil -lproject -L$(APPS_PATH)/libplatform -lversion

LDFLAGS += -L$(APPS_PATH)/libplatform -lvct
LDFLAGS_CUST = -L$(APPS_PATH)/httpd -lhttpd
 
OBJS += cgi.o ej.o httpd.o core.o cmobasicapi.o file.o log.o httpd_util.o

OBJ_CUSTOMER = customer.o

INSTALLDIR = $(TARGET)

all: httpd_gpl
		
clean:
	rm -f *.o httpd
	rm -f $(WWW_PATH)/*.o

install: all
	install -D httpd $(INSTALLDIR)/sbin/httpd
	$(STRIP) --strip-unneeded  $(INSTALLDIR)/sbin/httpd

uninstall:
	rm -rf $(INSTALLDIR)/sbin/httpd

httpd: $(OBJS) $(OBJ_CUSTOMER)
	$(AR) rcs libhttpd.a $(OBJS)
	$(CC) $(OBJ_CUSTOMER) $(LDFLAGS_CUST) $(LDFLAGS) -o httpd

httpd_gpl:  $(OBJ_CUSTOMER)
	$(CC) $(OBJ_CUSTOMER) $(LDFLAGS_CUST) $(LDFLAGS) -o httpd


