# This Makefile has only been tested on linux.  It uses
# MinGW32 to cross-compile for windows.  To install and
# configure MinGW32 on linux, see http://www.mingw.org


ifeq "$(PLATFORM)" ""
PLATFORM := $(shell uname)
endif


# This is where the mingw32 compiler exists in Ubuntu 8.04.
# Your compiler location may vary.
WIN32_CC=/usr/bin/i586-mingw32msvc-gcc

CC=gcc
CFLAGS=-Wall -pedantic -s -O3
SRCDIR=nailgun-client


ifeq "$(PLATFORM)" "Darwin"
# OSX options, compile 32/64bit binary targetting OS X 10.6 Snow Leopard
CFLAGS=-Wall -pedantic -Os -arch i386 -arch x86_64 -mmacosx-version-min=10.6
endif

ng: ${SRCDIR}/ng.c
	@echo "Building ng client.  To build a Windows binary, type 'make ng.exe'"
	${CC} ${CFLAGS} -o ng ${SRCDIR}/ng.c
	strip ng

install: ng
	install ng /usr/local/bin/ng
	
ng.exe: ${SRCDIR}/ng.c
	${WIN32_CC} -o ng.exe ${SRCDIR}/ng.c -lwsock32 -O3 ${CFLAGS}
# any idea why the command line is so sensitive to the order of
# the arguments?  If CFLAGS is at the beginning, it won't link.
	
clean:
	@echo ""
	@echo "If you have a Windows binary, 'make clean' won't delete it."
	@echo "You must remove this manually.  Most users won't have MinGW"
	@echo "installed - so I'd rather not delete something you can't rebuild."
	@echo ""
	rm -f ng
#	rm -f ng.exe
