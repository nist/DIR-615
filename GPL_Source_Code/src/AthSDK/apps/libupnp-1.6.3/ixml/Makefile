# Generated automatically from Makefile.in by configure.
PRE_INCLUDE_PATH = ../.include/upnp
PRE_LIBS_PATH = ../.libs

OBJS = src/ixml.o src/node.o src/ixmlparser.o \
                        src/ixmlmembuf.o src/nodeList.o \
                        src/element.o src/attr.o src/document.o \
                        src/namedNodeMap.o

CFLAGS += -I./inc -I./src/inc -g -O2 -Os -Wall \
	-D_GNU_SOURCE -pthread

ifeq ($(ENABLE_DEBUG),y)
CFLAGS         += -DDEBUG
else
CFLAGS         += -DNDEBUG
endif

LIB_BIN = libixml.a


#ar cru .libs/libixml.a  src/ixml.o src/node.o src/ixmlparser.o src/ixmlmembuf.o src/nodeList.o src/element.o src/attr.o src/document.o src/namedNodeMap.o
#ranlib .libs/libixml.a

all: $(OBJS)
	@echo "Building $(LIB_BIN) ..."
#	@echo "                  "
#	@echo "                  "
#	@echo "                  "
#	@echo "CC=$(CC)"
#	@echo "AS=$(AS)"
#	@echo "AR=$(AR)"
#	@echo "STRIP = $(STRIP)"
#	@echo "RANLIB = $(RANLIB)"
#	@echo "                  "
#	@echo "                  "
#	@echo "                  "
	$(STRIP) --strip-unneeded $(OBJS) || exit 1;
	$(AR) -rcu $(LIB_BIN) $(OBJS) || exit 1;
	$(RANLIB) $(LIB_BIN) || exit 1;
	cp inc/*.h $(PRE_INCLUDE_PATH) || exit 1;
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



