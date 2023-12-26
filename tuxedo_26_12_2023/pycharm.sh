#!/bin/bash

PYCHARM_VERSION="2023.3.2"
PYCHARM_TAR="pycharm-community-${PYCHARM_VERSION}.tar.gz"
DOWNLOAD_URL="https://download.jetbrains.com/python/${PYCHARM_TAR}"

# Check if the file already exists locally
if [ ! -f "$PYCHARM_TAR" ]; then
    # Download PyCharm only if the file is not present
    wget -nc "$DOWNLOAD_URL"
fi

# Unpack PyCharm
tar -xzvf "$PYCHARM_TAR"

# Add any additional commands you need here

mkdir -p ~/bin
ln -s ~/Documents/install_scripts/pycharm-community-2023.3.2/bin/pycharm.sh ~/bin/pycharm

# Append export PATH to the end of .bashrc
echo 'export PATH=~/bin:"$PATH"' >> ~/.bashrc

# Apply changes to the current session
source ~/.bashrc
