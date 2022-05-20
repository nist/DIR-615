include ../../.config

CFLAGS  += -I. -I$(KERNEL_PATH)/include/

all: libsutil.so libproject.so libipv6.so

clean:
	rm -rf *.o *.so *~

install:
	install -D libsutil.so $(TARGET)/lib/libsutil.so
	install -D libproject.so $(TARGET)/lib/libproject.so
	install -D libipv6.so $(TARGET)/lib/libipv6.so
	$(STRIP) $(TARGET)/lib/libsutil.so
	$(STRIP) $(TARGET)/lib/libproject.so
	$(STRIP) $(TARGET)/lib/libipv6.so

libsutil.so: sutil.o scmd_nvram.o
	$(LD) -shared -o $@ $^

libproject.so: project.o scmd_nvram.o
	$(LD) -shared -o $@ $^

libipv6.so: ipv6.o scmd_nvram.o
	$(LD) -shared -o $@ $^

