
LIBSO := libfoo.so
LIBSOVER := $(LIBSO).1
LIBSOVERFULL := $(LIBSO).1.13.0

BARSO := libbar.so
BARSOVER := $(BARSO).1
BARSOVERFULL := $(BARSO).1.13.0


CC := gcc
CFLAGS := -I.

all: main


$(LIBSOVERFULL): foo.o $(BARSO)
	$(CC) $(CFLAGS) -L. -shared -o $@ $< -Wl,-soname,$(LIBSOVER) -lbar

$(LIBSO): $(LIBSOVER)
	ln -s $< $@

$(LIBSOVER): $(LIBSOVERFULL)
	ln -s $< $@


$(BARSOVERFULL): bar.o
	$(CC) $(CFLAGS) -shared -o $@ $^ -Wl,-soname,$(BARSOVER)

$(BARSO): $(BARSOVER)
	ln -s $< $@

$(BARSOVER): $(BARSOVERFULL)
	ln -s $< $@


main: main.o $(LIBSO) $(BARSO)
	$(CC) -L. -Wall -o $@ $< -lfoo -lbar


clean:
	rm -f $(LIBSO) $(LIBSOVER) $(LIBSOVERFULL) $(BARSO) $(BARSOVER) $(BARSOVERFULL) *.o


