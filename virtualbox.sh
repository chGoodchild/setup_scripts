#!/bin/bash

# Install virtual box
sudo apt-get -y install software-properties-common python-software-properti>
sudo apt-add-repository "deb http://download.virtualbox.org/virtualbox/debi>
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt->
sudo apt-get -y update
sudo apt-get -y install virtualbox-5.0 dkms
sudo apt-get -y --force-yes install virtualbox-5.1
 
 
# Make USB work in virtual box
# https://askubuntu.com/questions/25596/how-to-set-up-usb-for-virtualbox
sudo usermod -aG vboxusers chandran  # Add myself to the virtual box group
