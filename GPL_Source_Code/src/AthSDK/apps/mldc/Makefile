
#CFLAGS += -I./ -I$(TOP)/sutil/ -I$(TOP)/nvram/ -I$(APPS_PATH)/libplatform -D$(PLATFORM)
#LDFLAGS += -L$(TOP)/nvram -lnvram -L$(TOP)/sutil -lsutil -L$(APPS_PATH)/libplatform -lversion

OBJS :=  gp.o if.o main.o misc.o timer.o timeh.o mld.o 

all: mldc

.c.o:
	$(CC) $(CFLAGS) -c $<
		

clean:
	rm -f *.o *~ mldc .*.depend


install: mldc
	install -d $(TARGET)/sbin
	install mldc $(TARGET)/sbin
	$(STRIP) $(TARGET)/sbin/mldc

mldc: $(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS)
