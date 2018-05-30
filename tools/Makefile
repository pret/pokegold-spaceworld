.PHONY: all clean

CC := gcc
CFLAGS := -O3 -std=c99 -Wall -Wextra

tools := \
	scan_includes \
	pkmncompress \
	gfx

all: $(tools)
	@:

clean:
	rm -f $(tools)

%: %.c
	$(CC) $(CFLAGS) -o $@ $<

