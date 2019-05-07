#!/bin/bash

# First get the file from github
git clone https://github.com/tgingold/ghdl
cd ghdl
./configure --prefix=/usr/local

# fatal error: zlib.h: No such file or directory include <zlib.h>
sudo apt-get -y install libz-dev

make
make install
sudo apt-get -y install gtkwave

# Usage instructions:
echo "Usage instructions:"
wget -qO- https://github.com/chGoodchild/setup_scripts/raw/master/using_ghdl.sh
