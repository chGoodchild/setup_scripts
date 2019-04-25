#!/bin/bash

# Install emacs
# http://www.seaandsailor.com/emacs-config.html
# http://stackoverflow.com/questions/218512/how-can-i-change-the-language-in-emacs-when-using-ispell
sudo apt-get -y install emacs
sudo apt-get -y install texlive auctex
sudo apt-get -y install texlive-latex-extra

# Add German language
sudo apt-get -y install kde-l10n-de
sudo apt-get -y install aspell-de
sudo apt -y install texlive-lang-german
sudo emacs /etc/locale.gen &

# VLC
sudo apt-get -y install vlc

# Install thunderbird
sudo apt-get -y install thunderbird
sudo apt-get -y install enigmail
sudo apt-get -y install enigmail-locale-de
#output<<$printf "You still have to open thunderbird and install enigmail"

# Install octave
# https://askubuntu.com/questions/616827/how-to-force-octave-to-launch-in-gui-mode-from-the-dock
sudo apt-get -y install octave octave-doc octave-htmldoc

# Install git
sudo apt-get -y install git

# Install svn
sudo apt-get -y install subversion
sudo mkdir svn

# Install Arduino
sudo apt-get -y install arduino

# Resource indicator
sudo apt-get install indicator-multiload

# Install openVpn
sudo apt-get -y install openvpn easy-rsa 

# Install rpm
sudo apt-get -y install rpm

# Install badblocks (if necessary). This is good for checking the integrity of flash memory.
sudo apt-get -y install badblocks

# Install Alien in order to convert RPM files into DEB files
# https://askubuntu.com/questions/2988/how-do-i-install-and-manage-rpms
sudo apt-get -y install alien
# sudo alien my_package.rpm
# sudo dpkg -i my_package.deb

# Curl (for installing signal)
sudo apt-get -y install curl

# Signal messenger
# Alternatively try: https://support.signal.org/hc/en-us/articles/214507138-How-do-I-install-Signal-Desktop-
curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt -y install signal-desktop

# Skype
wget https://repo.skype.com/latest/skypeforlinux-64.deb
sudo dpkg -i skypeforlinux-64.deb
sudo apt -y install -f

# Gimp
sudo apt-get -y install gimp

# Xournal
sudo apt-get -y install xournal

# Caffeine: Make sure the computer doesn't fall asleep
sudo apt-get -y install caffeine

# Brave
wget -O brave.deb https://laptop-updates.brave.com/latest/dev/ubuntu64
sudo dpkg -i brave.deb
sudo apt-get -f -y install

# PDF Schuffler
sudo apt-get -y install pdfshuffler


# Dropbox
# sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 1C61A2656FB57B7E4DE0F4C1FC918B335044912E  
# sudo apt-get -y install dropbox
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
~/.dropbox-dist/dropboxd

# Node JS und ionic...
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
sudo apt-get -y update && sudo apt-get -y install yarn
sudo npm install -g -y ionic
sudo apt install -y docker.io

sudo apt install -y tlp
sudo apt install -y powertop

# Uninstall packages that have become redundant.
sudo apt-get -y autoremove
