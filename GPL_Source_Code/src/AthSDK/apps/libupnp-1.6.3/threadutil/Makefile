# Generated automatically from Makefile.in by configure.
PRE_INCLUDE_PATH = ../.include/upnp
PRE_LIBS_PATH = ../.libs

UPNP_INCLUDE_HEADER = \
                        inc/FreeList.h inc/LinkedList.h \
                        inc/ThreadPool.h inc/TimerThread.h \
                        inc/ithread.h

OBJS = src/FreeList.o src/LinkedList.o src/ThreadPool.o src/TimerThread.o

upnpinclude_HEADERS     = \
                        inc/FreeList.h inc/LinkedList.h \
                        inc/ThreadPool.h inc/TimerThread.h \
                        inc/ithread.h

SRCDIR = .
CFLAGS += -I$(SRCDIR)/inc -I$(SRCDIR)/src/inc -g -O2 -Os -Wall \
	 -I../upnp/inc -D_GNU_SOURCE -pthread

ifeq ($(ENABLE_DEBUG),y)
CFLAGS         += -DDEBUG -DSTATS
else
CFLAGS         += -DNDEBUG -DNO_DEBUG
endif


LIB_BIN = libthreadutil.a


all: $(OBJS)
	@echo "Building $(LIB_BIN) ..."
#	@echo "CC=$(CC)"
	$(STRIP) --strip-unneeded $(OBJS) || exit 1;
	$(AR) -rcu $(LIB_BIN) $(OBJS) || exit 1;
	$(RANLIB) $(LIB_BIN) || exit 1;
	cp $(UPNP_INCLUDE_HEADER) $(PRE_INCLUDE_PATH) || exit 1;
	cp $(LIB_BIN) $(PRE_LIBS_PATH) || exit 1;

install:
#	cd upnp/sample/linux-igd; $(MAKE) install


clean:
	rm -rf $(OBJS)
	rm -rf $(LIB_BIN)
	rm -rf *~
	rm -rf $(PRE_INCLUDE_PATH)/*.h
	rm -rf $(PRE_LIBS_PATH)/$(LIB_BIN)

.c.o: src/inc/ixmlmembuf.h src/inc/ixmlparser.h
	$(CC) $(CFLAGS) -c $< -o $*.o



