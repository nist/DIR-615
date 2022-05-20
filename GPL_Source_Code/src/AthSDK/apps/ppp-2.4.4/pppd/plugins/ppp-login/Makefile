# Makefile for RADIUS plugin
#
# Copyright 2002 Roaring Penguin Software Inc.
#

DESTDIR = $(INSTROOT)/
MANDIR = $(DESTDIR)/share/man/man8
LIBDIR = $(DESTDIR)/lib/pppd/$(VERSION)

VERSION = $(shell awk -F '"' '/VERSION/ { print $$2; }' ../../patchlevel.h)

INSTALL	= install

PLUGIN=ppp-login.so
CFLAGS=-I. -I../.. -I../../../include -O2 -fPIC -DRC_LOG_FACILITY=LOG_DAEMON

all: $(PLUGIN)

install: all
	$(INSTALL) -d -m 755 $(LIBDIR)
	$(INSTALL) -c -m 755 ppp-login.so $(LIBDIR)

ppp-login.so: ppp-login.o
	$(CC) -o ppp-login.so -shared ppp-login.o

clean:
	rm -f *.o *.so

distclean:
	rm -f *.o *.so

dist-clean: distclean
