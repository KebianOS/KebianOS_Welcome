CC     = gcc
CFLAGS = $(shell pkg-config --cflags gtk+-3.0) -Wall
LIBS   = $(shell pkg-config --libs gtk+-3.0)
DEB     = kebianos-welcome_$(VERSION)_$(ARCH).deb
VERSION = $(shell dpkg-parsechangelog -l changelog -S Version)
ARCH    = $(shell dpkg --print-architecture)


kebianoswelcome: main.c
	$(CC) $(CFLAGS) -o kebianoswelcome main.c $(LIBS)

run: kebianoswelcome
	./kebianoswelcome

clean:
	rm -f kebianoswelcome
	rm -rf build
	rm *.deb
	rm *.buildinfo
	rm *.changes

deb: kebianoswelcome
	sudo apt install debhelper-compat
	mkdir -p build/debian build/usr/bin build/debian/source build/usr/share/applications
	cp changelog build/debian
	cp kebianoswelcome build/usr/bin
	cp install build/debian
	cp rules build/debian
	cp source/format build/debian/source/format
	cp kebianoswelcome.desktop build/usr/share/applications
	cp control build/debian
	cd build && dpkg-buildpackage -us -uc -b

install: deb
	sudo apt install ./$(DEB)

.PHONY: run clean
