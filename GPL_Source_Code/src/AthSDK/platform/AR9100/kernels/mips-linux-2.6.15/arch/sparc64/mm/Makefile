# $Id: Makefile,v 1.1.1.1 2007/06/26 07:59:20 albert Exp $
# Makefile for the linux Sparc64-specific parts of the memory manager.
#

EXTRA_AFLAGS := -ansi
EXTRA_CFLAGS := -Werror

obj-y    := ultra.o tlb.o fault.o init.o generic.o

obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
