ifeq ($(PLATFORM), sl3516)
include ../.config
endif
all: mkfs

# note: for compatbility in different OS. You should use "root" account to build SDK instead of 
# 	non-root account. 

mkfs:
ifeq ($(PLATFORM), AthSDK_AP61)
	tar zxvf ../platform/AthSDK_AP61/rootfs.tgz ;\
	$(FS_PATH)/../setup_rootdir;
#else	
#	@if [ ! -d $(FS_PATH) ]; then \
		tar zxvf ./rootfs.tgz ;\
		install -d tmp ;\
		install -d target/etc target/tmp target/lib ;\
		install -d target/sbin target/bin target/usr/sbin target/usr/bin target/lib ;\
		cd target; ln -fs tmp var ;\
		tar zxvf $(PRJ_PATH)/lib/$(PLATFORM)-lib.tgz -C $(FS_PATH) ;\
#	fi

endif 

ifeq ($(PLATFORM), AR7100)
	rm -rf target
	tar -jxf ./rootfs_ap71.tar.bz2
endif 
ifeq ($(PLATFORM), AR9100)
	rm -rf target
	tar -jxf ../platform/AR9100/rootfs_ap81.tar.bz2
endif 
ifeq ($(PLATFORM), sl3516)
	rm -rf target
	#tar -jxf ../platform/$(PLATFORM)/rootfs_sl3516.tar.bz2
	#mv target_skeleton target
	cp -a ../platform/$(PLATFORM)/target .
	find target -type d -name "CVS"|xargs rm -rf
	
	#cp -Rf ..$(ENV_PATH)/platform/$(PLATFORM)/target ./
	#find target -type d -name ".cvs"|xargs rm -rf
	#svn co http://172.21.33.134/repos/router/trunk/project/DIR-730/target_skeleton target
	#find target -type d -name ".svn"|xargs rm -rf
	$(FS_PATH)/../../platform/$(PLATFORM)/setup_rootdir_sl3516	
endif 
ifeq ($(PLATFORM), AR7161)
	rm -rf target
	tar -jxf ../platform/AR7161/rootfs_ap94.tar.bz2
endif
ifeq ($(PLATFORM), MV88F6281)
	rm -rf target
	tar -jxf ../platform/MV88F6281/rootfs_mv_ap95.tar.bz2
endif

install:
	install -d $(IMG_PATH)
ifeq ($(PLATFORM), BCM5352)
	$(KERNEL_PATH)/scripts/cramfs/mkcramfs -u 0 -g 0 $(FS_PATH) ./tmp/target.cramfs
	trx -o $(IMG_PATH)/image.bin ./tmp/vmlinuz ./tmp/target.cramfs
	echo -n $(HARDWARE_ID) >> $(IMG_PATH)/image.bin
endif
ifeq ($(PLATFORM), MVL5181)
	$(TOOL_PATH)/mkfs.jffs2 -l -e 0x10000 --pad=0x500000 -r $(FS_PATH) -o $(IMG_PATH)/image.bin
	echo -n $(HARDWARE_ID) >> $(IMG_PATH)/image.bin
endif
ifeq ($(PLATFORM), AthSDK_AP61)
	cd $(TOOL_PATH)/../tools/lzma/sdk4.17/SRC/7zip/Compress/LZMA_Alone/ && $(MAKE)
	$(TOOL_PATH)/../tools/release_kernel.sh $(AP_TYPE)
	$(TOOL_PATH)/../tools/release_rootfs.sh $(AP_TYPE)
	$(TOOL_PATH)/../tools/release_image.sh $(AP_TYPE)		
endif

ifeq ($(PLATFORM), sl3516)
	#FIXME:
	#cd $(FS_PATH)/usr/libexec/ipsec && \
	for f in *; do (if file $$f | grep ARM > /dev/null; then ( $(APPS_CROSS)strip --strip-unneeded $$f); fi); done
	cd $(FS_PATH)/bin && \
	for f in *; do (if file $$f | grep ARM > /dev/null; then ( $(APPS_CROSS)strip --strip-unneeded $$f); fi); done
	cd $(FS_PATH)/sbin && \
	for f in *; do (if file $$f | grep ARM > /dev/null; then ( $(APPS_CROSS)strip --strip-unneeded $$f); fi); done
	cd $(FS_PATH)/usr/sbin && \
	for f in *; do (if file $$f | grep ARM > /dev/null; then ( $(APPS_CROSS)strip --strip-unneeded $$f); fi); done
	cd $(FS_PATH)/usr/bin && \
	for f in *; do (if file $$f | grep ARM > /dev/null; then ( $(APPS_CROSS)strip --strip-unneeded $$f); fi); done
	#cd $(FS_PATH)/lib && \
	for f in *; do (if file $$f | grep ARM > /dev/null; then ( $(APPS_CROSS)strip --strip-unneeded $$f); fi); done
	#cd $(FS_PATH)/lib/iptables && \
	for f in *; do (if file $$f | grep ARM > /dev/null; then ( $(APPS_CROSS)strip --strip-unneeded $$f); fi); done
	-mkdir $(FS_PATH)/dev/net
	-mknod $(FS_PATH)/dev/net/tun c 10 200
	-cp ../platform/$(PLATFORM)/sl-boot/board/lepus_linux/build/boot.img.hdr $(IMG_PATH)/boot.img
	$(KERNEL_PATH)/scripts/cramfs/mkcramfs  $(FS_PATH) ../image/target.cramfs
	cp $(KERNEL_PATH)/arch/arm/boot/zImage ../image/zImage
	#trx -o $(IMG_PATH)/image.bin ./tmp/vmlinuz ./tmp/target.cramfs
	#echo -n $(HARDWARE_ID) >> $(IMG_PATH)/image.bin
	cd .. && ./Image.sh $(MODEL_AREA) $(HARDWARE_ID) $(CONFIG_MODEL_NAME) RT2800	
endif


ifeq ($(PLATFORM), AR7100)
	rm -rf $(FS_PATH)/man/
	$(APPS_CROSS)strip $(FS_PATH)/bin/*
	$(APPS_CROSS)strip $(FS_PATH)/lib/*
	$(APPS_CROSS)strip $(FS_PATH)/sbin/*
	cp $(KERNEL_PATH)/arch/mips/boot/vmlinux.* /$(IMG_PATH)/
	$(TOOL_PATH)/../tools/release_rootfs.sh $(AP_TYPE)
	$(TOOL_PATH)/../tools/release_image.sh ap71	
endif

ifeq ($(PLATFORM), AR9100)
	rm -rf $(FS_PATH)/man/
	$(APPS_CROSS)strip $(FS_PATH)/bin/*
	$(APPS_CROSS)strip $(FS_PATH)/lib/*
	$(APPS_CROSS)strip $(FS_PATH)/sbin/*
	cp $(KERNEL_PATH)/arch/mips/boot/vmlinux.* /$(IMG_PATH)/
	$(TOOL_PATH)/../tools/mkuImage.sh $(KERNEL_PATH) $(IMG_PATH)
	$(TOOL_PATH)/../tools/release_rootfs.sh $(AP_TYPE)
ifeq ($(ETH_SWITCH), CFG_RTL8366SR_PHY) 
	$(TOOL_PATH)/../tools/release_image.sh $(CONFIG_MODEL_NAME)$(CONFIG_LANGUAGE_PACK)_$(AP_TYPE)_rtl8366sr_
endif	
ifneq ($(ETH_SWITCH), CFG_RTL8366SR_PHY) 
	$(TOOL_PATH)/../tools/release_image.sh $(CONFIG_MODEL_NAME)$(CONFIG_LANGUAGE_PACK)_$(AP_TYPE)_
endif
endif

ifeq ($(PLATFORM), AR7161)
	rm -rf $(FS_PATH)/man/
	$(APPS_CROSS)strip $(FS_PATH)/bin/*
	$(APPS_CROSS)strip $(FS_PATH)/lib/*
	$(APPS_CROSS)strip $(FS_PATH)/sbin/*
	cp $(KERNEL_PATH)/arch/mips/boot/vmlinux.* /$(IMG_PATH)/
	$(TOOL_PATH)/../tools/mkuImage.sh $(KERNEL_PATH) $(IMG_PATH) $(AP_TYPE)
	$(TOOL_PATH)/../tools/release_rootfs.sh $(AP_TYPE)
	$(TOOL_PATH)/../tools/release_image.sh $(CONFIG_MODEL_NAME)_$(AP_TYPE)_
endif

ifeq ($(PLATFORM), MV88F6281)
	rm -rf $(FS_PATH)/man/
	$(APPS_CROSS)strip $(FS_PATH)/bin/*
#	$(APPS_CROSS)strip $(FS_PATH)/lib/*
	find $(FS_PATH)/lib/ -name *so* -type f | xargs $(APPS_CROSS)strip 
	find $(FS_PATH)/lib/ -name *.a -type f | xargs $(APPS_CROSS)strip 
	$(APPS_CROSS)strip $(FS_PATH)/sbin/*
	cp $(KERNEL_PATH)/arch/arm/boot/vmlinux.* /$(IMG_PATH)/
	cp $(KERNEL_PATH)/arch/arm/boot/Image /$(IMG_PATH)/
	cp $(KERNEL_PATH)/arch/arm/boot/uImage /$(IMG_PATH)/
	$(FS_PATH)/../../platform/$(PLATFORM)/setup_rootdir	
	$(TOOL_PATH)/../tools/mkuImage.sh $(KERNEL_PATH) $(IMG_PATH) $(AP_TYPE)
	$(TOOL_PATH)/../tools/release_rootfs.sh $(AP_TYPE)
	$(TOOL_PATH)/../tools/release_image.sh $(CONFIG_MODEL_NAME)_$(AP_TYPE)_
endif

clean:
	rm -fr target 
	rm -fr tmp
	rm -fr $(IMG_PATH)
	
