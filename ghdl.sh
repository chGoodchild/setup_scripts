#!/bin/bash

# First get the file from github
git clone https://github.com/tgingold/ghdl
cd ghdl
./configure --prefix=/usr/local
make
make install
sudo apt-get install gtkwave
