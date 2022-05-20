
#You can modify it for your compiler

#CC = cc
#LD = ld
#STRIP = strip
LDFLAGS = -s

DEFS    = -D_KERNEL_ -DUSE_SSL
#INCLUDE = -I/usr/src/linux-2.4.20-8/include -I/usr/kerberos/include
INCLUDE = -I$(KERNEL_PATH)/include -I$(APPS_PATH)/openssl/include 
#LDLIBS  = -lpthread -ldl -lssl 
LDLIBS  += -lpthread -L$(APPS_PATH)/openssl/ -lssl -lcrypto 
CFLAGS += -Wall -g3 -O2

objs := $(SOURCES:.c=.o)
dirs := $(patsubst %, %_sub, $(SUBDIRS))
dirclean := $(patsubst %, %_clr, $(SUBDIRS))
dirinstall := $(patsubst %, %_install, $(SUBDIRS))

all: $(dirs) $(objs) O_TAR bin_prog test $(SHARED_LIB)
	@echo Build successufully...

%.o:%.c
	$(CC) $(CFLAGS) $(DEFS) $(INCLUDE) -c $< -o $@

$(dirs):
	make -C $(patsubst %_sub, %, $@) -f Makefile

O_TAR: $(objs)
ifdef O_TARGET

	$(LD) $(LDFLAGS) $(LDLIB) -r $(objs) $(LIBS) -o $(join lib, $(O_TARGET))

endif

bin_prog: clrbin $(bin_PROG)

clrbin: $($(join $@, _LIB))
ifdef bin_PROG
	rm -f $(bin_PROG)
endif


$(bin_PROG):

	$(CC) $(CFLAGS) $(DEFS) $(INCLUDE) $(LDFLAGS) $(LDLIBS) $($(join $@, _LIB)) -o $@ $($(join $@, _SOURCE))
	$(STRIP) $@


test: clrtst $(test_PROG)

clrtst:
ifdef test_PROG
	rm -f $(test_PROG)
endif

$(test_PROG):
	$(CC) $(CFLAGS) $(DEFS) $(INCLUDE) $(LDFLAGS) $(LDLIBS) $($(join $@, _LIB)) -o $@ $($(join $@, _SOURCE))

$(SHARED_LIB):
	$(CC) $(CFLAGS) -fPIC -shared $($(join $@, _LIB)) -o $@

install: $(dirinstall)
ifdef test_PROG
	cp -f $(test_PROG) $(TARGET)/sbin
endif
ifdef bin_PROG
	cp -f $(bin_PROG) $(TARGET)/sbin
endif
ifdef SHARED_LIB
	cp -f $(SHARED_LIB) $(TARGET)/lib
endif

$(dirinstall):
	make -C $(patsubst %_install, %, $@) -f Makefile install

clean: $(dirclean)
	rm -f $(objs)  $(patsubst %, lib%, $(O_TARGET)) $(bin_PROG) $(test_PROG) $(SHARED_LIB)

$(dirclean):
	make -C $(patsubst %_clr, %, $@) -f Makefile clean

