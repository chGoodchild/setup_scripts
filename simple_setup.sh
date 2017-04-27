#! /bin/bash

echo "Please enter the path to the tar installation file: "
read path

tar -xzf "$path"

echo "Please enter the path with out .tar.gz at the end: "
read path

cd "$path"
./configure
make
sudo make install

