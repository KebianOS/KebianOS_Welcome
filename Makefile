CC      = gcc
CFLAGS  = $(shell pkg-config --cflags gtk+-3.0) -Wall -O2 -g
LIBS    = $(shell pkg-config --libs gtk+-3.0)
BIN     = kebianoswelcome
VERSION = $(shell dpkg-parsechangelog -l changelog -S Version)
ARCH    = $(shell dpkg --print-architecture)
DEB     = kebianos-welcome_$(VERSION)_$(ARCH).deb

$(BIN): main.c
	$(CC) $(CFLAGS) -o $@ $< $(LIBS)

run: $(BIN)
	./$(BIN)

deb: $(BIN)
	rm -rf build
	mkdir -p build/debian/source build/usr/bin build/usr/share/applications
	cp changelog control install rules build/debian/
	cp source/format build/debian/source/format
	cp $(BIN) build/usr/bin/
	cp kebianoswelcome.desktop build/usr/share/applications/
	cd build && dpkg-buildpackage -us -uc -b

install: deb
	sudo apt install ./$(DEB)

clean:
	rm -rf $(BIN) build
	rm -f *.deb *.buildinfo *.changes

.PHONY: run deb install clean
