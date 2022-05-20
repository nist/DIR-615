ifndef BOARD_TYPE
#error "You have to define Board Type to use this Makefile"
ifeq ($(AP_TYPE), ap81)
BOARD_TYPE = ap81
endif
ifeq ($(AP_TYPE), ap83)
BOARD_TYPE = ap83
endif		
endif

ifndef BUILD_TYPE
#error "You have to define Build Type to use this Makefile"
BUILD_TYPE = jffs2
endif

#
# Include the specific configuration files from the config.boardtype file
# here.  This removes the need to set environmental variables through a
# script before building
#

include scripts/$(BOARD_TYPE)/config.$(BOARD_TYPE)

#
# Put in safety checks here to ensure all required variables are defined in
# the configuration file
#

ifndef TOOLPREFIX
#error "Must specify TOOLPREFIX value"
endif

ifndef TOOLCHAIN
#error "Must specify TOOLCHAIN value"
endif

ifndef TOOLARCH
#error "Must specify TOOLARCH value"
endif

ifndef KERNEL
#error "Must specify KERNEL value"
endif

ifndef KERNELVER
#error "Must specify KERNELVER value"
endif

ifndef KERNELTARGET
#error "Must specify KERNELTARGET value"
endif

ifndef KERNELARCH
#error "Must specify KERNELARCH value"
endif

ifndef TOOLPREFIX
#error "Must specify TOOLPREFIX value"
endif

ifndef BUSYBOX
#error "Must specify BUSYBOX value"
endif

#
# Other environmental variables that are configured as per the configuration file
# specified above.  These contain all platform specific configuration items.
#

#export TOPDIR=$(PWD)/..
export TOPDIR=$(PWD)
export INSTALL_ROOT=$(TOPDIR)/rootfs.build
#export TFTPPATH=/tftpboot/`whoami`
export TFTPPATH=/tftpboot/
export IMAGEPATH=$(TOPDIR)/images/$(BOARD_TYPE)

export STRIP=$(TOOLPREFIX)strip
#export KERNELPATH=$(TOPDIR)/linux/kernels/$(KERNEL)
export KERNELPATH=$(KERNEL_PATH)
export MAKEARCH=$(MAKE) ARCH=$(KERNELARCH) CROSS_COMPILE=$(TOOLPREFIX)

export TOOLPATH=$(TOPDIR)/build/$(TOOLCHAIN)/$(TOOLARCH)/
export BOOTLOADERDIR=$(TOPDIR)/platform/$(PLATFORM)/u-boot

export PATH:=$(TOPDIR)/build/util:$(TOOLPATH)/bin:$(TOPDIR)/linux:$(TOPDIR)/build:$(BOOTLOADERDIR)/ecos/tools/bin:`pwd`:${PATH}

# madwifi
export HAL=$(TOPDIR)/wlan/madwifi/hal/main
export ATH_PHYERR=$(TOPDIR)/wlan/madwifi/dfs
export ATH_RATE=$(TOPDIR)/wlan/madwifi/ratectrl11n/
export MODULEPATH=$(INSTALL_ROOT)/lib/modules/$(KERNELVER)/net

#
# This is to allow the target file system size to be specified on the command
# line, if desired
#

ifndef TARGETFSSIZE
export TARGETFSSIZE=2621440
endif


ENTRY=`readelf -a vmlinux|grep "Entry"|cut -d":" -f 2`
LDADR=`readelf -a vmlinux|grep "\[ 1\]"|cut -d" " -f 26`

#
# Include the board specific make file
#

include scripts/$(BOARD_TYPE)/Makefile.$(BOARD_TYPE)

#
# Common targts
#

rootfs_prep:
	@echo $(NEWPATH)
	rm -rf $(INSTALL_ROOT); mkdir $(INSTALL_ROOT)
	cp -R ../rootfs/common/* $(INSTALL_ROOT)
	cp -Rf ../rootfs/$(BOARD_TYPE)/* $(INSTALL_ROOT)
	chmod 755 $(INSTALL_ROOT)/etc/rc.d/*
	chmod 755 $(INSTALL_ROOT)/etc/ath/*
	chmod 755 $(INSTALL_ROOT)/etc/ath/default/*
	
toolchain_build:
	@echo making toolchain_build
	cd $(TOOLCHAIN) && \
	cp -f $(BOARD_TYPE).config .config && \
	cp -f toolchain/uClibc/$(BOARD_TYPE).config toolchain/uClibc/uClibc.config && \
	$(MAKE)
	# install libraries
	cd $(TOOLCHAIN) && make PREFIX=$(INSTALL_ROOT) install

check_tftp: image_prep
	if test -d $$TFTPPATH; then echo $$TFTPPATH exists; else mkdir $$TFTPPATH; fi;

image_prep:
	if test -d $(TOPDIR)/images; then echo $(TOPDIR)/images exists; \
	else \
	mkdir $(TOPDIR)/images; \
	fi;
	if test -d $(IMAGEPATH); then echo $(IMAGEPATH) exists; \
	else \
	mkdir $(IMAGEPATH); \
	fi;

kernel_clean: 
	cd $(KERNELPATH) &&  $(MAKEARCH) mrproper 

kernel_info:
	cd $(KERNELPATH) && rm -f vmlinux.info
	cd $(KERNELPATH) && echo "entry:"${ENTRY} >> vmlinux.info
	cd $(KERNELPATH) && echo "link: 0x"${LDADR} >> vmlinux.info
	cp $(KERNELPATH)/vmlinux.info $(TFTPPATH)
	cp $(KERNELPATH)/vmlinux.info $(IMAGEPATH)

#
# Use different kernel_build rules depending on the type of target
#

ifeq ($(KERNELTARGET), zImage)
kernel_build: 
	@echo " zimage Making Kernel Build Version $(EXTRAVERSION) $(ETH_SWITCH)"
	exit
	cd $(KERNELPATH) && $(MAKEARCH) $(BOARD_TYPE)_defconfig
	cd $(KERNELPATH) && $(MAKEARCH)
	cd $(KERNELPATH)/arch/$(KERNELARCH)/boot && \
	cp $(KERNELTARGET) $(TFTPPATH) && cp $(KERNELTARGET) $(IMAGEPATH)
else	
kernel_build: 
	@echo " Making Kernel Build Version $(EXTRAVERSION) $(ETH_SWITCH)"
	cp -f $(WWW_PATH)/bsp.h	$(KERNELPATH)/init/
ifeq ($(BOARD_TYPE), ap83)	
	@echo "$(BOARD_TYPE) $(ETH_SWITCH) $(KERNELARCH)"
ifeq ($(ETH_SWITCH), CFG_RTL8366SR_PHY)	
	pwd	
	cp -f $(KERNELPATH)/arch/mips/configs/$(BOARD_TYPE)_defconfig_rtl8366sr $(KERNELPATH)/arch/mips/configs/$(BOARD_TYPE)_defconfig
	cd $(KERNELPATH) && $(MAKEARCH) $(BOARD_TYPE)_defconfig
endif
ifneq ($(ETH_SWITCH), CFG_RTL8366SR_PHY)	
	cp -f $(KERNELPATH)/arch/mips/configs/$(BOARD_TYPE)_defconfig_aths26 $(KERNELPATH)/arch/mips/configs/$(BOARD_TYPE)_defconfig	
	cd $(KERNELPATH) && $(MAKEARCH) $(BOARD_TYPE)_defconfig
endif	
endif
ifneq ($(BOARD_TYPE), ap83)
	@echo "apxx $(BOARD_TYPE) $(ETH_SWITCH)"
	cd $(KERNELPATH) && $(MAKEARCH) $(BOARD_TYPE)_defconfig
endif	
	cd $(KERNELPATH) && $(MAKEARCH) $(KERNELTARGET)
	mkdir -p $(TOPDIR)/images/
	mkdir -p $(TOPDIR)/images/$(BOARD_TYPE)	
	cp $(KERNELTARGET) $(TFTPPATH) && \
	cp $(KERNELTARGET) $(IMAGEPATH) && \
	gzip -f $(KERNELTARGET) && \
	cp $(KERNELTARGET).gz $(TFTPPATH) && \
	cp $(KERNELTARGET).gz $(IMAGEPATH);
	cd $(KERNELPATH)/arch/$(KERNELARCH)/boot && \
	/opt/ap71_tools/lzma e $(KERNELTARGET) vmlinux.lzma -d23
endif

redboot_build:
	cd $(BOOTLOADERDIR) && $(MAKEARCH) mrproper
	cd $(BOOTLOADERDIR) && $(MAKEARCH) $(BOARD_TYPE)_config
	cd $(BOOTLOADERDIR) && $(MAKEARCH) all

busybox_build: 
	@echo making busybox
	cd ../apps/$(BUSYBOX); $(MAKE) PREFIX=$(INSTALL_ROOT) uninstall; \
	make clean; \
	cp -f defconfig-$(BOARD_TYPE)$(BUILD_DEBUG) .config; \
	$(MAKE); $(MAKE) PREFIX=$(INSTALL_ROOT) install

wireless_tools:
	@echo making wireless_tools
	if test -n "$(WIRELESSTOOLS)"; then \
	cd ../apps/$(WIRELESSTOOLS); make clean; make; \
	$(STRIP) $(WIRELESSTOOLSLIB); \
	$(STRIP) iwpriv;  \
	$(STRIP) iwconfig; \
	$(STRIP) iwlist; \
	cp -f $(WIRELESSTOOLSLIB) $(INSTALL_ROOT)/lib; \
	cp -f iwpriv $(INSTALL_ROOT)/sbin; \
	cp -f iwconfig $(INSTALL_ROOT)/sbin; \
	cp -f iwlist $(INSTALL_ROOT)/sbin; \
	cd $(TOPDIR)/wlan/madwifi/madwifi/tools && make clean \
	&&  make BUILD_STATIC=$(BUILD_STATIC) &&  $(STRIP) wlanconfig && \
	cp -f wlanconfig $(INSTALL_ROOT)/sbin && \
	$(STRIP) athstats athstatsclr athdebug 80211stats 80211debug athkey athampdutrc athcwm atrc pktlogconf pktlogdump radartool && \
	tar -czvf $(INSTALL_ROOT)/sbin/debug.tgz athstats athstatsclr athdebug 80211stats 80211debug athkey athampdutrc athcwm atrc pktlogconf pktlogdump radartool; \
	fi

hal_build: 
	@echo making hal
	if test -n "$(MADWIFITARGET)"; then \
	cd $(HAL)/linux && make TARGET=$(MADWIFITARGET) clean &&  \
	make TARGET=$(MADWIFITARGET) && make TARGET=$(MADWIFITARGET) release; \
	fi

madwifi_build: hal_build wireless_tools
	@echo making madwifi
	cd $(TOPDIR)/wlan/madwifi/madwifi && \
	$(MAKEARCH) TARGET=$(MADWIFITARGET) clean \
	&&  $(MAKEARCH) TARGET=$(MADWIFITARGET) && \
	$(MAKEARCH)  TARGET=$(MADWIFITARGET) install
	$(MAKE) $(BUILD_TYPE)_build
	
hostapd: openssl
	if ( test -e ../apps/wpa/hostapd-0.4.8 ) then \
	cd ../apps/wpa/hostapd-0.4.8; cp -f defconfig .config; make clean; make; \
	make PREFIX=$(INSTALL_ROOT)/sbin CONFIG_PATH=$(INSTALL_ROOT)/etc/ath DEFAULT_CFG=$(INSTALL_ROOT)/etc/ath/default install; \
	fi

openssl:
	if (test -e ../apps/wpa/wsc/lib/openssl-0.9.8a ) then \
	chmod -R 755 ../apps/wpa/wsc/lib/openssl-0.9.8a; \
	cd ../apps/wpa/wsc/lib/openssl-0.9.8a; make clean; make; fi

wsc: hostapd
	if (test -e ../apps/wpa/wsc/src/linux ) then \
	chmod -R 755 ../apps/wpa/wsc/src/lunux; \
	cd ../apps/wpa/wsc/src/linux; make clean; \
	make PREFIX=$(INSTALL_ROOT)/sbin CONFIG_PATH=$(INSTALL_ROOT)/etc/ath DEFAULT_CFG=$(INSTALL_ROOT)/etc/ath/default install; \
	fi

wpa_supplicant:
	if (test -e ../apps/wpa/wpa_supplicant-0.5.5 ) then \
	cd ../apps/wpa/wpa_supplicant-0.5.5; cp -f defconfig .config; make clean; \
    make; make PREFIX=$(INSTALL_ROOT)/sbin install; \
	fi

sar:
	@echo making sar
	cd ../apps/sysstat-6.0.1/ && rm -f sysstat.cron.daily && rm -f sysstat.cron.hourly && $(MAKE) CC=$(TOOLPREFIX)gcc 
	cd ../apps/sysstat-6.0.1/ && cp sar $(INSTALL_ROOT)/usr/bin/
	cd ../apps/sysstat-6.0.1/ && cp sadc $(INSTALL_ROOT)/usr/bin/

ram_build:
	@echo making ramfs
	cd util && \
	genext2fs -b 4096 -i 512 -D dev.txt -d rootdir $(BOARD_TYPE)-ramdisk
	cd util && gzip --best -f $(BOARD_TYPE)-ramdisk
	cd util && cp $(BOARD_TYPE)-ramdisk.gz $(TFTPPATH) 
	cd util && cp $(BOARD_TYPE)-ramdisk.gz $(IMAGEPATH) 

uimage:	kernel_build
	@echo making uImage
	cd util && mkuImage.sh $(UBOOTDIR)/tools $(KERNELPATH) 
	
jffs2_build:
	@echo making jffs2
	util/mkfs.jffs2 --root=$(INSTALL_ROOT) --eraseblock=0x10000 -b -D scripts/$(BOARD_TYPE)/dev.txt --squash -o $(BOARD_TYPE)-jffs2 --pad=$(TARGETFSSIZE)
	cp $(TOPDIR)/build/$(BOARD_TYPE)-jffs2 $(TFTPPATH)
	cp $(TOPDIR)/build/$(BOARD_TYPE)-jffs2 $(IMAGEPATH)
	
