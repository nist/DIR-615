export CROSS_COMPILE := $(KRL_CROSS)
export CC := $(CROSS_COMPILE)gcc
export AR := $(CROSS_COMPILE)ar
export AS := $(CROSS_COMPILE)as
export LD := $(CROSS_COMPILE)ld
export NM := $(CROSS_COMPILE)nm
export RANLIB := $(CROSS_COMPILE)ranlib
export STRIP := $(CROSS_COMPILE)strip
export SIZE := $(CROSS_COMPILE)size

all:
	if [ ! -f $(KERNEL_PATH)/.config ]; then \
		$(MAKE) config; \
	fi
	$(MAKE) kernel

clean:
	$(MAKE) -C $(KERNEL_PATH) clean
	
ifeq ($(PLATFORM), AthSDK_AP61)	
	cd $(TOOL_PATH)/../tools/lzma/sdk4.17/SRC/7zip/Compress/LZMA_Alone/ && $(MAKE) clean
endif

ifeq ($(PLATFORM), AR7100)	
	cd $(TOOL_PATH)/../tools/lzma/sdk4.17/SRC/7zip/Compress/LZMA_Alone/ && $(MAKE) clean 
endif

ifeq ($(PLATFORM), AR7161)	
	cd $(TOOL_PATH)/../tools/lzma/sdk4.17/SRC/7zip/Compress/LZMA_Alone/ && $(MAKE) clean
endif

config:
ifeq ($(PLATFORM), AthSDK_AP61)
	make -C ./$(PLATFORM) kernel_dep
else
	cp $(PRJ_PATH)/www/$(CONFIG_MODEL_NAME)/config/$(CONFIG_MODEL_NAME).linux.config $(KERNEL_PATH)/.config 
	make -C $(KERNEL_PATH) oldconfig 
	make -C $(KERNEL_PATH) dep 
endif	
ifeq ($(PLATFORM), MVL5181)
	$(MAKE) -C $(KERNEL_PATH) bzImage 
endif

kernel:
	if grep -q "CONFIG_MODULES=y" $(KERNEL_PATH)/.config ; then \
		$(MAKE) -C $(KERNEL_PATH) modules ; \
	fi
ifeq ($(PLATFORM), BCM5352)	
	$(MAKE) -C $(KERNEL_PATH)
endif
ifeq ($(PLATFORM), MVL5181)
	$(MAKE) -C $(KERNEL_PATH) uImage
endif
ifeq ($(PLATFORM), AthSDK_AP61)
	make -C ./$(PLATFORM) kernel_build
endif
ifeq ($(PLATFORM), AR7100)
	$(MAKE) -C ./$(PLATFORM) kernel_build
endif
ifeq ($(PLATFORM), AR9100)
	$(MAKE) -C ./$(PLATFORM) kernel_build
endif
ifeq ($(PLATFORM), sl3516)
	cp -f $(WWW_PATH)/bsp.h	$(KERNEL_PATH)/init/
	cp -f $(WWW_PATH)/bsp.h	$(KERNEL_PATH)/drivers/usb/core/
	$(MAKE) -C $(KERNEL_PATH) zImage 
	$(MAKE) -C $(KERNEL_PATH) modules
endif
ifeq ($(PLATFORM), AR7161)
	$(MAKE) -C ./$(PLATFORM) kernel_build
endif


enet:
	make -C ./$(PLATFORM) enet_build

redboot_build:
ifeq ($(PLATFORM), sl3516)
	cp -f $(WWW_PATH)/defaultConf.h ./$(PLATFORM)/sl-boot/src/sys/
	cp -f $(WWW_PATH)/bsp.h	./$(PLATFORM)/sl-boot/src/net/
	make -C ./$(PLATFORM)/sl-boot/board/lepus_linux/build/
else
	make -C ./$(PLATFORM) redboot_build
endif

install:
	if [ -f $(KERNEL_PATH)/../../driver/Makefile ]; then \
		$(MAKE) -C $(KERNEL_PATH)/../../driver/ install ;\
	fi
	if grep -q "CONFIG_MODULES=y" $(KERNEL_PATH)/.config ; then \
		$(MAKE) -C $(KERNEL_PATH) modules_install DEPMOD=/bin/true INSTALL_MOD_PATH=$(FS_PATH) ; \
	fi
ifeq ($(PLATFORM), BCM5352)
	cp $(KERNEL_PATH)/arch/mips/brcm-boards/bcm947xx/compressed/vmlinuz $(FS_PATH)/../tmp
	cp $(KERNEL_PATH)/arch/mips/brcm-boards/bcm947xx/compressed/zImage $(FS_PATH)/../tmp
endif
ifeq ($(PLATFORM), MVL5181)
	cp $(KERNEL_PATH)/arch/arm/boot/uImage $(FS_PATH)
endif
