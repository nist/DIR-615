# www Makefile
#
# Copyright 2005, CAMEO Corporation 
# All Rights Reserved.

include $(APPS_PATH)/.config
INSTALLDIR = $(FS_PATH)

ifeq ($(CONFIG_TEST_PAGE),y)
	WWW_INSTALL += install-test-page
endif

ifeq ($(CONFIG_WWW),y)
	WWW_INSTALL += install-www
endif

ifeq ($(CONFIG_SSI_WWW), y)
	WWW_INSTALL += install-www
endif

ifeq ($(CONFIG_MODEL_NAME), DIR-730)
	include $(APPS_PATH)/../.config
	FIRMWARE_VERSION=`cat ./${CONFIG_MODEL_NAME}/version.c|grep VER_FIRMWARE|awk 'BEGIN {FS="\\""}; {print $$2}'`
	FIRMWARE_BUILD=`cat ./${CONFIG_MODEL_NAME}/version.c|grep VER_BUILD|awk 'BEGIN {FS="\\""}; {print $$2}'`
	FIRMWARE_DATE=`cat ./${CONFIG_MODEL_NAME}/version.c|grep VER_DATE|awk 'BEGIN {FS="\\""}; {print $$2}'`
	KERNEL_VERSION=`cat ../platform/${PLATFORM}/doc/linux_version.c|grep __CAMEO_LINUX_VERSION__|awk 'BEGIN {FS="\\""}; {print $$2}'`
	KERNEL_SDK=`cat ../apps/doc/apps_version.c|grep __CAMEO_ATHEROS_VERSION__|awk 'BEGIN {FS="\\""}; {print $$2}'`
	KERNEL_BUILD=`cat ../platform/${PLATFORM}/doc/linux_version.c|grep __CAMEO_LINUX_BUILD__|awk 'BEGIN {FS="\\""}; {print $$2}'`
	KERNEL_DATE=`cat ../platform/${PLATFORM}/doc/linux_version.c|grep __CAMEO_LINUX_BUILD_DATE__|awk 'BEGIN {FS="\\""}; {print $$2}'`
	KERNEL_TAG="KERNEL: ${KERNEL_VERSION}, SDK: ${KERNEL_SDK}, Build: ${KERNEL_BUILD}, Date: ${KERNEL_DATE}<Br>"
	WIRELESS_VERSION=`cat ../wireless/${WL_PLATFORM}/doc/wireless_version.c|grep __CAMEO_WIRELESS_VERSION__|awk 'BEGIN {FS="\\""}; {print $$2}'`
	WIRELESS_BUILD=`cat ../wireless/${WL_PLATFORM}/doc/wireless_version.c|grep __CAMEO_WIRELESS_BUILD__|awk 'BEGIN {FS="\\""}; {print $$2}'`
	WIRELESS_DATE=`cat ../wireless/${WL_PLATFORM}/doc/wireless_version.c|grep __CAMEO_WIRELESS_DATE_|awk 'BEGIN {FS="\\""}; {print $$2}'`
	WIRELESS_TAG="WLAN Version: ${WIRELESS_VERSION}, Build: ${WIRELESS_BUILD}, Date: ${WIRELESS_DATE}<Br>"
	TAIL="</body></html>"
endif

#	Date:		2009-05-26
#	Name:		Jimmy Huang
#	Reason:		Modified Makefile to support project depended packages
#	Notice :	When you want to add a project depended packages, please follow steps described below
#		1. www/model_name/project_apps/Makefile
#			append package directory name to variable PROJECT_APPS
#		2. make sure the CFLAGS or CONFIG flags your packages used must be bring to 
#			www/model_name/project_apps/Makefile
#

PROJETC_APPS_PATH = $(WWW_PATH)/project_apps

all:
	@if [ -d $(PROJETC_APPS_PATH) ]; then \
		$(MAKE) -C $(PROJETC_APPS_PATH) all || exit 1; \
	fi

clean:
	@if [ -d $(PROJETC_APPS_PATH) ]; then \
		$(MAKE) -C $(PROJETC_APPS_PATH) clean || exit 1; \
	fi

install: $(WWW_INSTALL) all
	@if [ -d $(PROJETC_APPS_PATH) ]; then \
		$(MAKE) -C $(PROJETC_APPS_PATH) install || exit 1; \
	fi

install-www: 
	mkdir -p $(INSTALLDIR)/www
#	cp -R ./$(CONFIG_MODEL_NAME)/www$(CONFIG_LANGUAGE_PACK)/* $(INSTALLDIR)/www
	$(TOOL_PATH)/cp_html/cp_html $(CONFIG_MODEL_NAME)/www$(CONFIG_LANGUAGE_PACK) $(INSTALLDIR)/www
	if [ -f $(WWW_PATH)/pre_customer.sh ]; then \
	install $(WWW_PATH)/pre_customer.sh $(FS_PATH)/etc/rc.d/; \
	chmod 777 $(FS_PATH)/etc/rc.d/pre_customer.sh; \
	fi
	if [ -f $(WWW_PATH)/post_customer.sh ] ; then \
	install $(WWW_PATH)/post_customer.sh $(FS_PATH)/etc/rc.d/; \
	chmod 777 $(FS_PATH)/etc/rc.d/post_customer.sh; \
	fi 

ifeq ($(CONFIG_RUSSIA_WIZARD_PAGES),y)	
	mv $(INSTALLDIR)/www/wizard3.russia.asp $(INSTALLDIR)/www/wizard3.asp
endif
ifeq ($(CONFIG_MODEL_NAME), DIR-730)
	mkdir -p $(INSTALLDIR)/www/ssl
	mkdir -p $(INSTALLDIR)/www/tmp
	@if [ "$(MODEL_AREA)" == "" ];then echo "unknow area WW|NA=$(MODEL_AREA)";exit 1;fi
	cp -a $(CONFIG_MODEL_NAME)/www$(AREA)/* $(INSTALLDIR)/www
	cp ./$(CONFIG_MODEL_NAME)/www/auth.asp $(INSTALLDIR)/www/ssl
	@cp ./$(CONFIG_MODEL_NAME)/www/deny.html $(INSTALLDIR)/www/tmp
	@cp ./$(CONFIG_MODEL_NAME)/www/wlan.txt $(INSTALLDIR)/www/tmp
	@cat ./$(CONFIG_MODEL_NAME)/www/version_1.txt > $(INSTALLDIR)/www/tmp/version.txt
	@cat ./$(CONFIG_MODEL_NAME)/www/version_1.txt > $(INSTALLDIR)/www/tmp/chklst.txt
	@echo "Firmware External Version: V${FIRMWARE_VERSION}"'<!--# echo model_area -->'"<Br>" >> $(INSTALLDIR)/www/tmp/version.txt
	@echo "Firmware Internal Version: V${FIRMWARE_VERSION}"'<!--# echo model_area -->'"b${FIRMWARE_BUILD}<br>" >> $(INSTALLDIR)/www/tmp/version.txt
	@echo "Firmware Version: ver${FIRMWARE_VERSION}"'<!--# echo model_area -->'"b${FIRMWARE_BUILD}<br>" >> $(INSTALLDIR)/www/tmp/chklst.txt
	@echo "Date: " >> $(INSTALLDIR)/www/tmp/version.txt
	@echo "Firmware Date: " >> $(INSTALLDIR)/www/tmp/chklst.txt
	@echo "${FIRMWARE_DATE}"|awk '{print $$2,$$3,$$4}' >> $(INSTALLDIR)/www/tmp/version.txt
	@echo "${FIRMWARE_DATE}"|awk '{print $$2,$$3,$$4}' >> $(INSTALLDIR)/www/tmp/chklst.txt
	@echo "<Br>" >> $(INSTALLDIR)/www/tmp/version.txt
	@echo "<Br>" >> $(INSTALLDIR)/www/tmp/chklst.txt
	@echo "Checksum: <!--# exec cgi /bin/checksum --><BR>" >> $(INSTALLDIR)/www/tmp/version.txt
	@echo ${KERNEL_TAG} >> $(INSTALLDIR)/www/tmp/version.txt
	@echo ${WIRELESS_TAG} >> $(INSTALLDIR)/www/tmp/version.txt
	@echo "Checksum: <!--# exec cgi /bin/checksum --><BR>" >> $(INSTALLDIR)/www/tmp/chklst.txt
	@echo ${KERNEL_TAG} >> $(INSTALLDIR)/www/tmp/chklst.txt
	@echo ${WIRELESS_TAG} >> $(INSTALLDIR)/www/tmp/chklst.txt
	@cat ./$(CONFIG_MODEL_NAME)/www/version_2.txt >> $(INSTALLDIR)/www/tmp/version.txt
	@cat ./$(CONFIG_MODEL_NAME)/www/version_2.txt >> $(INSTALLDIR)/www/tmp/chklst.txt
	@echo ${TAIL} >> $(INSTALLDIR)/www/tmp/version.txt
	@echo ${TAIL} >> $(INSTALLDIR)/www/tmp/chklst.txt

#	@cp $(INSTALLDIR)/www/tmp/version.txt $(INSTALLDIR)/www/tmp/chklst.txt
	@perl -i -pe "s#JAR Notify: .*##" $(INSTALLDIR)/www/tmp/chklst.txt
	@perl -i -pe "s#JAR Global: .*##" $(INSTALLDIR)/www/tmp/chklst.txt
	@perl -i -pe "s#Utility Notify: .*##" $(INSTALLDIR)/www/tmp/chklst.txt
	@perl -i -pe "s#Utility Global: .*##" $(INSTALLDIR)/www/tmp/chklst.txt
	@perl -i -pe "s#Firmware Notify: .*##" $(INSTALLDIR)/www/tmp/chklst.txt
	@perl -i -pe "s#Firmware Global: .*##" $(INSTALLDIR)/www/tmp/chklst.txt
	@perl -i -pe "s/WLAN Domain/Wireless Domain/g" $(INSTALLDIR)/www/tmp/chklst.txt
	@perl -i -pe "s/wlan0_domain/wlan0_domain_description/g" $(INSTALLDIR)/www/tmp/version.txt
	rm -fr $(INSTALLDIR)/www/CVS
endif

install-test-page:
	mkdir -p $(INSTALLDIR)/www
	cp -R Test-Page/* $(INSTALLDIR)/www
	rm -fr $(INSTALLDIR)/www/CVS
