include ../../.config
CFLAGS = -Wall -W -O2

OBJS = cache.o rfc1035.o util.o option.o forward.o network.o \
       dnsmasq.o netlink.o bpf.o \
       log.o

DEPENDENCE_FILE = ../bld/Makefile

# jimmy removed objects to reduce code size
#OBJS += dbus.o tftp.o

# jimmy added flag

# if want IPv6 support, mark this line
#DISABLE_IPV6 = -DNO_IPV6

ifneq ($(CONFIG_IPV6_SUPPORT),y)
  DISABLE_IPV6 = -DNO_IPV6 
endif

#DHCP_SUPPORT = -DHAVE_DHCP  #  to reduce code size

ifeq ($(DHCP_SUPPORT),-DHAVE_DHCP)
OBJS += dhcp.o lease.o rfc2131.o isc.o helper.o
endif

ifeq ($(CONFIG_OPENDNS),y)
CFLAGS += -DOPENDNS
endif
# ---------------------------------

.c.o: $(DEPENDENCE_FILE)
# jimmy modified
	$(CC) $(CFLAGS) $(DHCP_SUPPORT) $(DISABLE_IPV6) -c $<
#	$(CC) $(CFLAGS) $(COPTS) $(DBUS_MINOR) $(I18N) $(DBUS_CFLAGS) $(SUNOS_VER) $(RPM_OPT_FLAGS) -c $<
# --------------------


dnsmasq : $(DEPENDENCE_FILE) $(OBJS)
# jimmy modified
	$(CC) $(LDFLAGS) -o $@  $(OBJS) $(LIBS) 
#	$(CC) $(LDFLAGS) -o $@  $(OBJS) $(DBUS_LIBS) $(SUNOS_LIBS) $(LIBS) 
# -----------------
 
dnsmasq.pot : $(OBJS:.o=.c) dnsmasq.h config.h
	xgettext -d dnsmasq --foreign-user --keyword=_ -o dnsmasq.pot -i $(OBJS:.o=.c)

%.mo : ../po/%.po dnsmasq.pot
	msgmerge -o - ../po/$*.po dnsmasq.pot | msgfmt -o $*.mo -
