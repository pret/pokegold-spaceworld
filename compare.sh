#!/usr/bin/env bash

if [ -z ${1+x} ]
then BUILD_NAME=gold_debug
else BUILD_NAME=$1
fi

diff <(hexdump -C baserom_${BUILD_NAME}.gb) <(hexdump -C poke${BUILD_NAME}_spaceworld.gb) | less
