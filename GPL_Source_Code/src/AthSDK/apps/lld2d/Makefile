#include ../.config

OS_LAYER = osl-linux.c
LDFLAGS = 
CFILES = $(OS_LAYER) main.c event.c util.c packetio.c band.c state.c sessionmgr.c enumeration.c mapping.c seeslist.c tlv.c qospktio.c
OBJFILES = $(patsubst %c,%o,$(CFILES))

all: dep lld2d

clean:
	rm -f .depend *~ lld2d $(OBJFILES)

lld2d: $(OBJFILES)
	$(CC) $(CFLAGS) -o lld2d $(OBJFILES) $(LDFLAGS)

dep:
	$(CC) $(CFLAGS) -M $(CFILES) >.depend

install:
	cp -f lld2d $(TARGET)/sbin
	cp -f /$(WWW_PATH)/lltd.ico $(TARGET)/etc/icon.ico
#-include .depend
