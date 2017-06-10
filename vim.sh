#! /bin/bash

# Edited with vim
# Install vim
sudo apt-get -y install vim

# Vim with configurations from thefux
cd
mkdir vim_repo
cd vim_repo
git init
git clone https://github/thefux/gitTest
mv .vim ~/.
mv .vimrc ~/.
