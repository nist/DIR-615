all:
	@echo "Multicast Routing daemon/framework for IPv6"
	@echo "  (c) 2004, 2005, 2006"
	@echo "         Universidade de Aveiro,"
	@echo "         Instituto de Telecomunicacoes - Polo Aveiro"

	@$(MAKE) -C src
install:
	make install -C src
clean:
	make clean -C src

.PHONY: config

config:
	@config/base.pl
