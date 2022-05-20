# Generated automatically from Makefile.in by configure.
PRE_LIBS_PATH = ../../.libs

SUBDIRS = api gena genlib soap ssdp urlconfig uuid
ifeq ($(ENABLE_DEBUG),y)
API_OBJS = api/upnpapi.o api/upnptools.o api/upnpdebug.o
else
API_OBJS = api/upnpapi.o api/upnptools.o
endif
SSDP_OBJS = ssdp/ssdp_device.o ssdp/ssdp_ctrlpt.o ssdp/ssdp_server.o
SOAP_OBJS = soap/soap_device.o soap/soap_ctrlpt.o soap/soap_common.o
GENLIB_OBJS = genlib/miniserver/miniserver.o genlib/service_table/service_table.o \
	genlib/util/membuffer.o genlib/util/strintmap.o genlib/util/upnp_timeout.o \
	genlib/util/util.o genlib/client_table/client_table.o genlib/net/sock.o \
	genlib/net/http/httpparser.o genlib/net/http/httpreadwrite.o \
	genlib/net/http/statcodes.o genlib/net/http/webserver.o \
	genlib/net/http/parsetools.o genlib/net/uri/uri.o 
GENA_OBJS = gena/gena_device.o gena/gena_ctrlpt.o gena/gena_callback2.o
UUID_OBJS = uuid/md5.o uuid/sysdep.o uuid/uuid.o
URLCONFIG = urlconfig/urlconfig.o

LIB_OBJS = $(SSDP_OBJS) $(SOAP_OBJS) $(GENLIB_OBJS) \
	 $(GENA_OBJS) $(API_OBJS) $(UUID_OBJS) $(URLCONFIG)

LIB_BIN = libupnp.a


all:	
	(for d in $(SUBDIRS); do $(MAKE) -C $$d all; done) || exit 1;
	$(AR) -rcu $(LIB_BIN) $(LIB_OBJS) || exit 1;
	$(RANLIB) $(LIB_BIN) || exit 1;
	cp $(LIB_BIN) $(PRE_LIBS_PATH) || exit 1;

clean:	
	(for d in $(SUBDIRS); do $(MAKE) -C $$d clean ; done) || exit 1;
	rm -rf $(LIB_BIN)
	rm -rf $(PRE_LIBS_PATH)/$(LIB_BIN)

install:
#	cd upnp/sample/linux-igd; $(MAKE) install


