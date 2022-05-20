# Dnsmasq Makefile

OBJS = cache.o rfc1035.o dhcp.o util.o option.o forward.o network.o dnsmasq.o
BINDIR = $(TARGET)/sbin

all : dnsmasq

clean :
	rm -f *~ $(OBJS) dnsmasq

.c.o: dnsmasq.h
	$(CC) $(CFLAGS) -W -c $*.c 


dnsmasq : $(OBJS) dnsmasq.h config.h
	$(CC) -o $@  $(OBJS) $(LIBS)

install : dnsmasq
	install -d $(BINDIR) 
	install -m 755 dnsmasq $(BINDIR)




