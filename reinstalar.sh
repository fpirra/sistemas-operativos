#!/bin/bash

rm -r tmp
rm -r grupo09/bin/
rm -r grupo09/dirconf/
rm -r grupo09/log/
rm -r grupo09/mae/
./compresstest.sh
cd tmp
tar -xvf grupo09.tar.gz
cd grupo09
./INSTALEP
cd bin
. ./INITEP
