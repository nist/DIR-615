
include ./../.config

OBJS += wakeOnLanProxy.o

INSTALLDIR = $(TARGET)

all: wakeOnLanProxy
		
clean:
	rm -f *.o *~ wakeOnLanProxy

install: all
	install -D wakeOnLanProxy $(INSTALLDIR)/sbin/wakeOnLanProxy
	$(STRIP) --strip-unneeded  $(INSTALLDIR)/sbin/wakeOnLanProxy

uninstall:
	rm -rf $(INSTALLDIR)/sbin/wakeOnLanProxy

httpd: $(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS)
