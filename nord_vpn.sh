#!/bin/bash

sudo apt-get -y install openvpn
cd /etc/openvpn/
sudo wget https://nordvpn.com/api/files/zip
sudo apt-get -y install ca-certificates
sudo apt-get -y install unzip
sudo unzip zip
sudo rm zip
sudo apt-get -y install network-manager-openvpn-gnome
sudo service network-manager restart
# The remaining steps are here:
# https://nordvpn.com/tutorials/linux/openvpn/
