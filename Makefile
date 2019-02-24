
LIBSO := libfoo.so
LIBSOVER := $(LIBSO).1
LIBSOVERFULL := $(LIBSO).1.13.0


all: main


$(LIBSOVERFULL): foo.o
	$(CC) -shared -o $@ $^ -Wl,-soname,$(LIBSOVER)

$(LIBSO): $(LIBSOVER)
	ln -s $< $@

$(LIBSOVER): $(LIBSOVERFULL)
	ln -s $< $@


main: main.o $(LIBSO)
	$(CC) -L. -Wall -o $@ $< -lfoo


clean:
	rm -f $(LIBSO) $(LIBSOVER) $(LIBSOVERFULL) *.o


