CFLAGS = -Wall -g3 -O2
CFLAGS += -I$(APPS_PATH)/openagent-2.0/src/public/conf
LDFLAGS = -s
LDLIBS  = -L$(APPS_PATH)/openagent-2.0/src/public -lpublic 
libdev.so:
	$(CC) $(CFLAGS) $(LDFLAGS) $(LDLIBS) -fPIC -shared *.c -o libdev.so
#	gcc -fPIC -shared *.c -o libdev.so

clean:
	rm -f *.o *.so
install:
	cp ./libdev.so $(TARGET)/lib
