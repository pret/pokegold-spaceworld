#!/bin/sh
# Compares baserom-gold.gb and pokegold-spaceworld.gb

# create baserom-gold.txt if necessary
if [ ! -f baserom-gold.txt ]; then
    hexdump -C baserom-gold.gb > baserom-gold.txt
fi

hexdump -C pokegold-spaceworld.gb > pokegold-spaceworld.txt

diff -u baserom-gold.txt pokegold-spaceworld.txt | less
