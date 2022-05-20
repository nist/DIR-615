PRE_INCLUDE_PATH = ../.include
PRE_LIBS_PATH = ../.libs

XML_CONFIG_PATH = $(TARGET)/etc/linuxigd
UPNPD_CONFIG_PATH = $(TARGET)/etc

CFLAGS += -g -O2 -Os -Wall \
	-I../../../.include \
	-D_GNU_SOURCE 

LIBS =  ../../../.libs/libupnp.a \
	../../../.libs/libixml.a \
	../../../.libs/libthreadutil.a \
	-lpthread

#LIBS= -lpthread -lupnp -lixml -lthreadutil -L$(LIBUPNP_PREFIX)/lib -L../libs
FILES= main.o gatedevice.o pmlist.o util.o config.o

ifdef HAVE_LIBIPTC
ifdef LIBIPTC_PREFIX
LIBS += -L$(LIBIPTC_PREFIX)/lib
INCLUDES += -I$(LIBIPTC_PREFIX)/include
endif

LIBS += -liptc
INCLUDES += -DHAVE_LIBIPTC
FILES += iptc.o
endif

all: upnpd

upnpd: $(FILES)
	$(CC) $(CFLAGS) $(FILES) $(LIBS) -o $@
	@echo "make $@ finished on `date`"


%.o:	%.c
	$(CC) $(CFLAGS) -c $< -o $*.o
#	$(CC) $(CFLAGS) $(INCLUDES) -c $<

clean:
	rm -f *.o upnpd *~

install: upnpd
	install -d $(XML_CONFIG_PATH)
	install etc/gatedesc.xml $(XML_CONFIG_PATH)
	install etc/gateconnSCPD.xml $(XML_CONFIG_PATH)
	install etc/gateicfgSCPD.xml $(XML_CONFIG_PATH)
	install etc/dummy.xml $(XML_CONFIG_PATH)
	install etc/upnpd.conf $(UPNPD_CONFIG_PATH)
	install upnpd $(TARGET)/sbin
	install mod_upnpd_xml.sh $(TARGET)/etc

