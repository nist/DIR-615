# Generated automatically from Makefile.in by configure.
PRE_INCLUDE_PATH = ../.include/upnp

SUBDIRS = src sample

all:	
	cp inc/*.h $(PRE_INCLUDE_PATH) || exit 1;
	(for d in $(SUBDIRS); do $(MAKE) -C $$d all; done) || exit 1;

clean:	
	(for d in $(SUBDIRS); do $(MAKE) -C $$d clean ; done) || exit 1;

install:
	(for d in $(SUBDIRS); do $(MAKE) -C $$d install ; done) || exit 1;


