# Router rc Makefile
#

CFLAGS += -I./ -I$(TOP)/sutil/ -I$(APPS_PATH)/libplatform -D$(PLATFORM)
LDFLAGS = 

OBJS :=  sserver.o 

all: nmbd

.c.o:
	$(CC) $(CFLAGS) -c $<
		

clean:
	rm -f *.o *~ nmbd .*.depend

install: nmbd
	install -d $(TARGET)/sbin
	install nmbd $(TARGET)/sbin
	$(STRIP) $(TARGET)/sbin/nmbd
nmbd: $(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS)
#	$(CC) -o $@ $(OBJS) $(CFLAGS)
