# Generated automatically from Makefile.in by configure.
OBJS = md5.o uuid.o sysdep.o


CFLAGS = -I../../../ -I../../src/inc -I../../../ixml/inc/ \
	-I../../../threadutil/inc/ -I../../../upnp/inc/ \
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



