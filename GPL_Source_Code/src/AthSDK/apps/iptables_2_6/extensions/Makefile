#! /usr/bin/make

# WARNING:
# only add extensions here that are either present in the kernel, or whose
# header files are present in the include/linux directory of this iptables
# package (HW)
#
include $(KERNEL_PATH)/.config

obj-y += SNAT SAME DNAT standard tcp udp icmp
obj-$(CONFIG_IP_NF_CONNTRACK) += conntrack

################################################################
#   Date:	2009-02-20
#   Name:	Chase Cheng
#   Reason: Fit KERNEL structure for kernel version 2.6.19 later
#
ifdef CONFIG_NETFILTER_XT_MATCH_HELPER
CONFIG_IP_NF_MATCH_HELPER = $(CONFIG_NETFILTER_XT_MATCH_HELPER)
endif
ifdef CONFIG_NETFILTER_XT_MATCH_LIMIT
CONFIG_IP_NF_MATCH_LIMIT = $(CONFIG_NETFILTER_XT_MATCH_LIMIT)
endif
ifdef CONFIG_NETFILTER_XT_MATCH_MAC
CONFIG_IP_NF_MATCH_MAC = $(CONFIG_NETFILTER_XT_MATCH_MAC)
endif
ifdef CONFIG_NETFILTER_XT_MATCH_MARK
CONFIG_IP_NF_MATCH_MARK = $(CONFIG_NETFILTER_XT_MATCH_MARK)
endif
ifdef CONFIG_NETFILTER_XT_MATCH_TCPMSS
CONFIG_IP_NF_MATCH_TCPMSS = $(CONFIG_NETFILTER_XT_MATCH_TCPMSS)
endif
ifdef CONFIG_NETFILTER_XT_TARGET_MARK
CONFIG_IP_NF_TARGET_MARK = $(CONFIG_NETFILTER_XT_TARGET_MARK)
endif
ifdef CONFIG_NETFILTER_XT_MATCH_STATE
CONFIG_IP_NF_MATCH_STATE = $(CONFIG_NETFILTER_XT_MATCH_STATE)
endif
ifdef CONFIG_NETFILTER_XT_MATCH_LENGTH
CONFIG_IP_NF_MATCH_LENGTH = $(CONFIG_NETFILTER_XT_MATCH_LENGTH)
endif
###################################################################

# MATCH
obj-$(CONFIG_IP_NF_MATCH_HELPER) += helper
obj-$(CONFIG_IP_NF_MATCH_LIMIT) += limit
obj-$(CONFIG_IP_NF_MATCH_MAC) += mac
obj-$(CONFIG_IP_NF_MATCH_MARK) += mark
obj-$(CONFIG_IP_NF_MATCH_OWNER) += owner
obj-$(CONFIG_IP_NF_MATCH_URLFILTER) += urlfilter
obj-$(CONFIG_IP_NF_MATCH_TCPMSS) += tcpmss
obj-$(CONFIG_IP_NF_MATCH_TTL) += ttl
obj-$(CONFIG_IP_NF_MATCH_STATE) += state
obj-$(CONFIG_IP_NF_MATCH_TOS) += tos
obj-$(CONFIG_IP_NF_MATCH_TIME) += time
obj-$(CONFIG_IP_NF_MATCH_IPRANGE) += iprange
obj-$(CONFIG_IP_NF_MATCH_LENGTH) += length
obj-$(CONFIG_IP_NF_MATCH_TOS) += tos
obj-$(CONFIG_IP_NF_MATCH_MPORT) += mport

# TARGET
obj-$(CONFIG_IP_NF_TARGET_MASQUERADE) += MASQUERADE
obj-$(CONFIG_IP_NF_TARGET_MIRROR) += MIRROR
obj-$(CONFIG_IP_NF_TARGET_REDIRECT) += REDIRECT
obj-$(CONFIG_IP_NF_TARGET_PORTTRIGGER) += PORTTRIGGER
obj-$(CONFIG_IP_NF_TARGET_TCPMSS) += TCPMSS
obj-$(CONFIG_IP_NF_TARGET_LOG) += LOG
obj-$(CONFIG_IP_NF_TARGET_TOS) += TOS
obj-$(CONFIG_IP_NF_TARGET_MARK) += MARK
obj-$(CONFIG_IP_NF_TARGET_REJECT) += REJECT
obj-$(CONFIG_IP_NF_TARGET_NATTYPE) += NATTYPE

PF_EXT_SLIB := $(obj-y) $(obj-m)
#PF_EXT_SLIB:=conntrack helper icmp iprange length limit mac mark owner standard state tcp tcpmss tos ttl udp CONNMARK DNAT LOG MARK MASQUERADE MIRROR REDIRECT REJECT SAME SNAT TCPMSS TOS TTL mport time urlfilter PORTTRIGGER
#PF6_EXT_SLIB:=eui64 hl icmpv6 length limit mac mark multiport owner physdev standard tcp udp HL LOG NFQUEUE MARK TRACE
PF6_EXT_SLIB:=

# Optionals
PF_EXT_SLIB_OPTS:=$(foreach T,$(wildcard extensions/.*-test),$(shell KERNEL_DIR=$(KERNEL_DIR) $(T)))
PF6_EXT_SLIB_OPTS:=$(foreach T,$(wildcard extensions/.*-test6),$(shell KERNEL_DIR=$(KERNEL_DIR) $(T)))

PF_EXT_ALL_SLIB:=$(patsubst extensions/libipt_%.c, %, $(wildcard extensions/libipt_*.c))
PF6_EXT_ALL_SLIB:=$(patsubst extensions/libip6t_%.c, %, $(wildcard extensions/libip6t_*.c))

PF_EXT_MAN_ALL_MATCHES:=$(foreach T,$(PF_EXT_ALL_SLIB),$(shell test -f extensions/libipt_$(T).man && grep -q register_match extensions/libipt_$(T).c  && echo $(T)))
PF_EXT_MAN_ALL_TARGETS:=$(foreach T,$(PF_EXT_ALL_SLIB),$(shell test -f extensions/libipt_$(T).man && grep -q register_target extensions/libipt_$(T).c && echo $(T)))
PF6_EXT_MAN_ALL_MATCHES:=$(foreach T,$(PF6_EXT_ALL_SLIB),$(shell test -f extensions/libip6t_$(T).man && grep -q register_match6 extensions/libip6t_$(T).c  && echo $(T)))
PF6_EXT_MAN_ALL_TARGETS:=$(foreach T,$(PF6_EXT_ALL_SLIB),$(shell test -f extensions/libip6t_$(T).man && grep -q register_target6 extensions/libip6t_$(T).c && echo $(T)))

PF_EXT_MAN_MATCHES:=$(filter $(PF_EXT_ALL_SLIB), $(PF_EXT_MAN_ALL_MATCHES))
PF_EXT_MAN_TARGETS:=$(filter $(PF_EXT_ALL_SLIB), $(PF_EXT_MAN_ALL_TARGETS))
PF_EXT_MAN_EXTRA_MATCHES:=$(filter-out $(PF_EXT_MAN_MATCHES), $(PF_EXT_MAN_ALL_MATCHES))
PF_EXT_MAN_EXTRA_TARGETS:=$(filter-out $(PF_EXT_MAN_TARGETS), $(PF_EXT_MAN_ALL_TARGETS))
PF6_EXT_MAN_MATCHES:=$(filter $(PF6_EXT_ALL_SLIB), $(PF6_EXT_MAN_ALL_MATCHES))
PF6_EXT_MAN_TARGETS:=$(filter $(PF6_EXT_ALL_SLIB), $(PF6_EXT_MAN_ALL_TARGETS))
PF6_EXT_MAN_EXTRA_MATCHES:=$(filter-out $(PF6_EXT_MAN_MATCHES), $(PF6_EXT_MAN_ALL_MATCHES))
PF6_EXT_MAN_EXTRA_TARGETS:=$(filter-out $(PF6_EXT_MAN_TARGETS), $(PF6_EXT_MAN_ALL_TARGETS))


allman:
	@echo ALL_SLIB: $(PF_EXT_ALL_SLIB)
	@echo ALL_MATCH: $(PF_EXT_MAN_ALL_MATCHES)
	@echo ALL_TARGET: $(PF_EXT_MAN_ALL_TARGETS)

PF_EXT_SLIB+=$(PF_EXT_SLIB_OPTS)
PF6_EXT_SLIB+=$(PF6_EXT_SLIB_OPTS)

OPTIONALS+=$(patsubst %,IPv4:%,$(PF_EXT_SLIB_OPTS))
OPTIONALS+=$(patsubst %,IPv6:%,$(PF6_EXT_SLIB_OPTS))

ifndef NO_SHARED_LIBS
SHARED_LIBS+=$(foreach T,$(PF_EXT_SLIB),extensions/libipt_$(T).so)
EXTRA_INSTALLS+=$(foreach T, $(PF_EXT_SLIB), $(DESTDIR)$(LIBDIR)/iptables/libipt_$(T).so)

ifeq ($(DO_IPV6), 1)
SHARED_LIBS+=$(foreach T,$(PF6_EXT_SLIB),extensions/libip6t_$(T).so)
EXTRA_INSTALLS+=$(foreach T, $(PF6_EXT_SLIB), $(DESTDIR)$(LIBDIR)/iptables/libip6t_$(T).so)
endif
else 	# NO_SHARED_LIBS
EXT_OBJS+=$(foreach T,$(PF_EXT_SLIB),extensions/libipt_$(T).o)
EXT_FUNC+=$(foreach T,$(PF_EXT_SLIB),ipt_$(T))
EXT_OBJS+= extensions/initext.o
ifeq ($(DO_IPV6), 1)
EXT6_OBJS+=$(foreach T,$(PF6_EXT_SLIB),extensions/libip6t_$(T).o)
EXT6_FUNC+=$(foreach T,$(PF6_EXT_SLIB),ip6t_$(T))
EXT6_OBJS+= extensions/initext6.o
endif	# DO_IPV6
endif	# NO_SHARED_LIBS

ifndef TOPLEVEL_INCLUDED
local:
	cd .. && $(MAKE) $(SHARED_LIBS)
endif

ifdef NO_SHARED_LIBS
extensions/libext.a: $(EXT_OBJS)
	rm -f $@; ar crv $@ $(EXT_OBJS)

extensions/libext6.a: $(EXT6_OBJS)
	rm -f $@; ar crv $@ $(EXT6_OBJS)

extensions/initext.o: extensions/initext.c
extensions/initext6.o: extensions/initext6.c

extensions/initext.c: extensions/Makefile
	echo "" > $@
	for i in $(EXT_FUNC); do \
		echo "extern void $${i}_init(void);" >> $@; \
	done
	echo "void init_extensions(void) {" >> $@
	for i in $(EXT_FUNC); do \
		echo "	$${i}_init();" >> $@; \
	done
	echo "}" >> $@

extensions/initext6.c: extensions/Makefile
	echo "" > $@
	for i in $(EXT6_FUNC); do \
		echo "extern void $${i}_init(void);" >> $@; \
	done
	echo "void init_extensions(void) {" >> $@
	for i in $(EXT6_FUNC); do \
		echo "	$${i}_init();" >> $@; \
	done
	echo "}" >> $@

extensions/lib%.o: extensions/lib%.c
	$(CC) $(CFLAGS) -D_INIT=$*_init -c -o $@ $<

endif
 
EXTRAS += extensions/libipt_targets.man
extensions/libipt_targets.man: $(patsubst %,extensions/libipt_%.man,$(PF_EXT_MAN_ALL_TARGETS))
	@for ext in $(PF_EXT_MAN_TARGETS); do \
	    echo ".SS $$ext" ;\
	    cat extensions/libipt_$$ext.man ;\
	done >extensions/libipt_targets.man
	@if [ -n "$(PF_EXT_MAN_EXTRA_TARGETS)" ]; then \
	    extra=$(PF_EXT_MAN_EXTRA_TARGETS) ;\
	    for ext in $${extra:-""}; do \
		echo ".SS $$ext (not supported, see Patch-O-Matic)" ;\
		cat extensions/libipt_$$ext.man ;\
	    done ;\
       	fi >>extensions/libipt_targets.man

EXTRAS += extensions/libipt_matches.man
extensions/libipt_matches.man: $(patsubst %,extensions/libipt_%.man,$(PF_EXT_MAN_ALL_MATCHES))
	@for ext in $(PF_EXT_MAN_MATCHES); do \
	    echo ".SS $$ext" ;\
	    cat extensions/libipt_$$ext.man ;\
	done >extensions/libipt_matches.man
	@if [ -n "$(PF_EXT_MAN_EXTRA_MATCHES)" ]; then \
	    extra=$(PF_EXT_MAN_EXTRA_MATCHES) ;\
	    for ext in $${extra:-""}; do \
		echo ".SS $$ext (not supported, see Patch-O-Matic)" ;\
		cat extensions/libipt_$$ext.man ;\
	    done ;\
       	fi >>extensions/libipt_matches.man

EXTRAS += extensions/libip6t_targets.man
extensions/libip6t_targets.man: $(patsubst %, extensions/libip6t_%.man, $(PF6_EXT_MAN_ALL_TARGETS))
	@for ext in $(PF6_EXT_MAN_TARGETS); do \
	    echo ".SS $$ext" ;\
	    cat extensions/libip6t_$$ext.man ;\
	done >extensions/libip6t_targets.man
	@if [ -n "$(PF6_EXT_MAN_EXTRA_TARGETS)" ]; then \
	    extra=$(PF6_EXT_MAN_EXTRA_TARGETS) ;\
	    for ext in $${extra:-""}; do \
		echo ".SS $$ext (not supported, see Patch-O-Matic)" ;\
		cat extensions/libip6t_$$ext.man ;\
	    done ;\
       	fi >>extensions/libip6t_targets.man

EXTRAS += extensions/libip6t_matches.man
extensions/libip6t_matches.man: $(patsubst %, extensions/libip6t_%.man, $(PF6_EXT_MAN_ALL_MATCHES))
	@for ext in $(PF6_EXT_MAN_MATCHES); do \
	    echo ".SS $$ext" ;\
	    cat extensions/libip6t_$$ext.man ;\
	done >extensions/libip6t_matches.man
	@if [ -n "$(PF6_EXT_MAN_EXTRA_MATCHES)" ]; then \
	    extra=$(PF6_EXT_MAN_EXTRA_MATCHES) ;\
	    for ext in $${extra:-""}; do \
		echo ".SS $$ext (not supported, see Patch-O-Matic)" ;\
		cat extensions/libip6t_$$ext.man ;\
	    done ;\
       	fi >>extensions/libip6t_matches.man

$(DESTDIR)$(LIBDIR)/iptables/libipt_%.so: extensions/libipt_%.so
	@[ -d $(DESTDIR)$(LIBDIR)/iptables ] || mkdir -p $(DESTDIR)$(LIBDIR)/iptables
	cp $< $@

$(DESTDIR)$(LIBDIR)/iptables/libip6t_%.so: extensions/libip6t_%.so
	@[ -d $(DESTDIR)$(LIBDIR)/iptables ] || mkdir -p $(DESTDIR)$(LIBDIR)/iptables
	cp $< $@
