# DDNS noip2 Makefile
include ../.config
CFLAGS += -I.  -I$(APPS_PATH)/sutil/ -I$(APPS_PATH)/nvram/
#LDFLAGS += -L$(APPS_PATH)/sutil -lsutil -L$(APPS_PATH)/nvram -lnvram -L$(APPS_PATH)/libplatform -lversion
LDFLAGS += -L$(APPS_PATH)/libplatform -lversion
OBJS1 = noip2.o md5.o utility.o
ALL = noip2

all: $(ALL)

noip2:$(OBJS1)
	$(CC) -o $@ $^ $(LDFLAGS)

	
install:
	$(CROSS_COMPILE)strip $(ALL)
	cp $(ALL) $(TARGET)/sbin
	
clean:
	rm -f *.o *~ $(ALL)
