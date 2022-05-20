# dnsmasq is Copyright (c) 2000-2007 Simon Kelley
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; version 2 dated June, 1991, or
#  (at your option) version 3 dated 29 June, 2007.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#    
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# jimmy added, used for mips environment
#export PATH=/opt/ap71_tools/mips32k/bin:/opt/ap71_tools/mips32k/lib:$(shell echo $$PATH)
#include ../../.config
#export CROSS_COMPILE := $(APPS_CROSS)
#export APPS_PATH := $(ENV_PATH)/apps
#export FS_PATH := $(ENV_PATH)/rootfs/target
#export TARGET := $(FS_PATH)
#export CC := $(CROSS_COMPILE)gcc
#export AS := $(CROSS_COMPILE)as
#export AR := $(CROSS_COMPILE)ar
#export LD := $(CROSS_COMPILE)ld
#export CCPP := $(CROSS_COMPILE)g++
#export COMPILER := $(CROSS_COMPILE)g++
#export STRIP := $(CROSS_COMPILE)strip
#export SIZE := $(CROSS_COMPILE)size
#export RANLIB := $(CROSS_COMPILE)ranlib
# -------------------------------

# jimmy modified
#PREFIX = /usr/local
PREFIX = ${TARGET}
# ---------------------
BINDIR = ${PREFIX}/sbin
MANDIR = ${PREFIX}/share/man
LOCALEDIR = ${PREFIX}/share/locale

SRC = src
PO = po
MAN = man

PKG_CONFIG = pkg-config
AWK = nawk
INSTALL = install

# jimmy marked
#DBUS_MINOR=" `echo $(COPTS) | ../bld/pkg-wrapper $(PKG_CONFIG) --modversion dbus-1 | $(AWK) -F . -- '{ if ($$(NF-1)) print \"-DDBUS_MINOR=\"$$(NF-1) }'`" 
#DBUS_CFLAGS="`echo $(COPTS) | ../bld/pkg-wrapper $(PKG_CONFIG) --cflags dbus-1`" 
#DBUS_LIBS="  `echo $(COPTS) | ../bld/pkg-wrapper $(PKG_CONFIG) --libs dbus-1`" 
#SUNOS_VER="  `if uname | grep SunOS 2>&1 >/dev/null; then uname -r | $(AWK) -F . -- '{ print \"-DSUNOS_VER=\"$$2 }'; fi`"
#SUNOS_LIBS=" `if uname | grep SunOS 2>&1 >/dev/null; then echo -lsocket -lnsl -lposix4; fi `"
# --------------------------------------------------------------------------------

all :   dnsmasq

dnsmasq :
# jimmy modifed
	cd $(SRC) && $(MAKE) \
  -f ../bld/Makefile dnsmasq 
#	cd $(SRC) && $(MAKE) \
# DBUS_MINOR=$(DBUS_MINOR) \
# DBUS_CFLAGS=$(DBUS_CFLAGS) \
# DBUS_LIBS=$(DBUS_LIBS) \
# SUNOS_LIBS=$(SUNOS_LIBS) \
# SUNOS_VER=$(SUNOS_VER) \
# -f ../bld/Makefile dnsmasq 
# -------------------------

clean :
	rm -f *~ $(SRC)/*.mo contrib/*/*~ */*~ $(SRC)/*.pot 
	rm -f $(SRC)/*.o $(SRC)/dnsmasq.a $(SRC)/dnsmasq core */core

install : all install-common

install-common :
# jimmy marked
#	$(INSTALL) -d $(DESTDIR)$(BINDIR) -d $(DESTDIR)$(MANDIR)/man8
#	$(INSTALL) -m 644 $(MAN)/dnsmasq.8 $(DESTDIR)$(MANDIR)/man8 
	$(INSTALL) -m 755 $(SRC)/dnsmasq $(DESTDIR)$(BINDIR)
# ---------------

all-i18n :
	cd $(SRC) && $(MAKE) \
 I18N=-DLOCALEDIR='\"$(LOCALEDIR)\"' \
 DBUS_MINOR=$(DBUS_MINOR) \
 DBUS_CFLAGS=$(DBUS_CFLAGS) \
 DBUS_LIBS=$(DBUS_LIBS) \
 SUNOS_LIBS=$(SUNOS_LIBS) \
 SUNOS_VER=$(SUNOS_VER) \
 -f ../bld/Makefile dnsmasq 
	cd $(PO); for f in *.po; do \
		cd ../$(SRC) && $(MAKE) -f ../bld/Makefile $${f%.po}.mo; \
	done

install-i18n : all-i18n install-common
	cd $(SRC); ../bld/install-mo $(DESTDIR)$(LOCALEDIR)
	cd $(MAN); ../bld/install-man $(DESTDIR)$(MANDIR)

merge :
	$(MAKE) I18N=-DLOCALEDIR='\"$(LOCALEDIR)\"' -f ../bld/Makefile -C $(SRC) dnsmasq.pot
	cd $(PO); for f in *.po; do \
		msgmerge -U $$f ../$(SRC)/dnsmasq.pot; \
	done


