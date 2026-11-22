CC     = gcc
CFLAGS = $(shell pkg-config --cflags gtk+-3.0) -Wall
LIBS   = $(shell pkg-config --libs gtk+-3.0)

main: main.c
	$(CC) $(CFLAGS) -o main main.c $(LIBS)

run: main
	./main

clean:
	rm -f main

.PHONY: run clean
