thread=0
resolved=0
full=0

ifeq ($(full),1)
	thread=1
	resolved=1
endif
ifeq (${thread},1)
	CFLAG+=-lpthread -D __USE_PTHREAD__
endif
ifeq ($(resolved),1)
	CFLAG+= -D __USE_DNS_RESOLVED__
endif

OBJS += crowdcontrol.o clist.o

all: crowdcontrol
		
clean:
	rm -f *.o *~ crowdcontrol	

install: all
	install -D crowdcontrol $(TARGET)/sbin/crowdcontrol	

uninstall:
	rm -rf $(TARGET)/sbin/crowdcontrol

crowdcontrol: $(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS)
