TOPDIR := ../..

SUBDIRS =

O_TARGET = cli.o

SOURCES = CLI.c

#**********************
#bin_PROG = prog
#prog_SOURCE = prog.c xxx.c yyy.c
#prog_LIB = prog.o xxx.a yyy.a
#**********************
bin_PROG =

#**********************
#test_PROG = mytest
#mytestg_SOURCE = prog.c xxx.c yyy.c
#mytest_LIB = prog.o xxx.a yyy.a
#**********************
test_PROG = tr069
#tr069_SOURCE = tr069_cli.c ../tools/agent_conf.c
tr069_SOURCE = tr069_cli.c 
tr069_LIB =

CFLAGS = -I../public/conf -I../public/msg -I../public/str
DEFS   = 
INCLUDE = 

LDFLAGS =
LDLIBS  = -L../public/ -lpublic

include $(TOPDIR)/rules.mk
