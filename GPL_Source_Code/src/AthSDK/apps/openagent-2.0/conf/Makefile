#TOPDIR := ..

#SUBDIRS = Dllso_example

clean:

install:
	if [ ! -d $(TARGET)/etc/opnagent ]; then \
		mkdir -p $(TARGET)/etc/openagent; \
		cp -f $(APPS_PATH)/openagent-2.0/conf/param.x* $(TARGET)/etc/openagent/; \
	fi

#include $(TOPDIR)/rules.mk
