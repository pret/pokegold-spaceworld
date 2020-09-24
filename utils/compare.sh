#!/bin/sh
# Compares baserom.gb and pokegold-spaceworld.gb

# create baserom.txt if necessary
if [ ! -f baserom.txt ]; then
    hexdump -C baserom.gb > baserom.txt
fi

hexdump -C pokegold-spaceworld.gb > pokegold-spaceworld.txt

diff -u baserom.txt pokegold-spaceworld.txt | less
