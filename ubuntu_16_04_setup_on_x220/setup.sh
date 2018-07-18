#!/bin/bash

# Install emacs
# http://www.seaandsailor.com/emacs-config.html
# http://stackoverflow.com/questions/218512/how-can-i-change-the-language-in-emacs-when-using-ispell
sudo apt-get -y install emacs
sudo apt-get -y install texlive auctex

# Add German language
sudo apt-get -y install kde-l10n-de
sudo apt-get -y install aspell-de
sudo apt -y install texlive-lang-german
sudo emacs /etc/locale.gen &

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
sudo apt-get -y install svn
sudo mkdir svn

# Install Arduino
sudo apt-get -y install arduino

# Install rpm
sudo apt-get -y install rpm

# Install badblocks (if necessary). This is good for checking the integrity of flash memory.
sudo apt-get -y install badblocks

# Install Alien in order to convert RPM files into DEB files
# https://askubuntu.com/questions/2988/how-do-i-install-and-manage-rpms
sudo apt-get -y install alien
# sudo alien my_package.rpm
# sudo dpkg -i my_package.deb

# Uninstall packages that have become redundant.
sudo apt-get -y autoremove

