# Generated automatically from Makefile.in by configure.

SUBDIRS = http uri
OBJS = sock.o

CFLAGS = -I../../../../ -I../../../src/inc -I../../../../ixml/inc/ \
	-I../../../../threadutil/inc/ -I../../../../upnp/inc/ \
	-g -O2 -Os -Wall \
	-D_GNU_SOURCE -pthread


#ENABLE_DEBUG
#CFLAGS         += -DDEBUG -DSTATS
#DISABLE_DEBUG
#AM_CPPFLAGS         += -DNO_DEBUG -DNDEBUG

#LIB_BIN = libthreadutil.a


all: $(OBJS)
	$(STRIP) --strip-unneeded $(OBJS)
	(for d in $(SUBDIRS); do $(MAKE) -C $$d all; done) || exit 1;

install:
#	cd upnp/sample/linux-igd; $(MAKE) install


clean:
	rm -rf $(OBJS)
	(for d in $(SUBDIRS); do $(MAKE) -C $$d clean ; done) || exit 1;

.c.o:
	$(CC) $(CFLAGS) -c $< -o $*.o



