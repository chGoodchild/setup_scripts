#!/bin/bash
# This script is written to set up my debian 8 system.
# Don't execute this script as root!

# Start in the home directory
cd

###############################################
# Add the keyboard shortcut CTRL + ALT + T
###############################################
# I am not done with this one yet...
# https://askubuntu.com/questions/597395/how-to-set-custom-keyboard-shortcuts-from-terminal

# create the keybinding by editing (adding to-) the list that is returned by the command:
#line=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)

# Apply the edited list by the command:
# gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "[<altered_list>]"
#gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings echo "$line"

###############################################
# Making the command line more convenient
###############################################
# I am especially interested in the aliases like ll instead of ls -l
# https://www.debinux.de/2013/10/debian-shell-nach-neuinstallation-umgaenglicher-machen/

sudo dpkg-reconfigure dash
sudo source /etc/bash.bashrc
# Make prompts colorful:
# echo 'export PS1="[\u@\[\e[32;1m\]\H \[\e[0m\]\w]\$ "' >> /etc/bash.bashrc
sudo echo "alias ls='ls --color=auto'" >> /etc/bash.bashrc
sudo echo "alias ll='ls -la --color=auto'" >> /etc/bash.bashrc
sudo echo "alias octave='octave --force-gui'" >> /etc/bash.bashrc
sudo echo "alias quartus='cd && ./quartus/quartus/bin/quartus &'" >> /etc/bash.bashrc
sudo echo "alias clean='alias clean='rm *~; rm *.class'" >> /etc/bash.bashrc
sudo echo "export EDITOR='emacs'" >> ~/.bashrc


# Make the WiFi work! - Add "non-free" sources...
# https://www.linux.com/learn/how-install-firmware-debian-enable-wireless-video-or-sound
# http://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/
sudo echo "deb http://httpredir.debian.org/debian jessie main contrib non-free" >> /etc/apt/sources.list
sudo echo "deb-src http://httpredir.debian.org/debian jessie main contrib non-free" >> /etc/apt/sources.list

sudo echo "deb http://httpredir.debian.org/debian jessie-updates main contrib non-free" >> /etc/apt/sources.list
sudo echo "deb-src http://httpredir.debian.org/debian jessie-updates main contrib non-free" >> /etc/apt/sources.list

sudo echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list
sudo echo "deb-src http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list

###############################################

# Update /etc/apt/sources.list
sudo apt-get -y update

# Upgrade the already installed packages
sudo apt-get -y upgrade

# Upgrade packages that have not yet been installed (kernel)
# sudo apt-get dist-upgrade

# Fix WiFi:
sudo apt-get -y install firmware-b43-installer
sudo apt-get -y install firmware-linux-nonfree
sudo modprobe b43
sudo apt-get -y install linux-image-$(uname -r|sed 's,[^-]*-[^-]*-,,') linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,') broadcom-sta-dkms
modprobe -r b44 b43 b43legacy ssb brcmsmac bcma
modprobe wl
# Finally this is the only thing that worked:
sudo apt-get -y install firmware-*
sudo service network-manager restart

# Sadly this is not the same as gnome-terminal in Ubuntu. I have to find something that I like.
sudo apt-get -y install gnome-terminal

# Install emacs
# http://www.seaandsailor.com/emacs-config.html
sudo apt-get -y install emacs
sudo apt-get -y install texlive auctex

# Add German language
sudo apt-get -y install kde-l10n-de
sudo apt-get -y install aspell-de
sudo emacs /etc/locale.gen &

# Install thunderbird
sudo apt-get -y install thunderbird
sudo apt-get -y install enigmail
sudo apt-get -y install enigmail-locale-de
#output<<$printf "You still have to open thunderbird and install enigmail"

# Install gpg
sudo apt-get -y install gnupg2 
sudo apt-get -y install gnupg-doc 

# Install octave
# https://askubuntu.com/questions/616827/how-to-force-octave-to-launch-in-gui-mode-from-the-dock
sudo apt-get -y install octave octave-doc octave-htmldoc

# Install svn
sudo apt-get -y install svn
sudo mkdir svn

# Install git
sudo apt-get -y install git
sudo mkdir git
cd git
git clone "https://github.com/chGoodchild/setup_scripts.git"
cd

# Install rpm
sudo apt-get -y install rpm

# Install Alien in order to convert RPM files into DEB files
# https://askubuntu.com/questions/2988/how-do-i-install-and-manage-rpms
sudo apt-get -y install alien
# sudo alien my_package.rpm
# sudo dpkg -i my_package.deb

# Install wine
sudo apt-get -y install wine

# Install virtual box
sudo apt-get -y install software-properties-common python-software-properties
sudo apt-add-repository "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib"
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-get -y update
sudo apt-get -y install virtualbox-5.0 dkms
sudo apt-get -y --force-yes install virtualbox-5.1

# Install GHDL
sudo apt-get -y install gnat-gps
sudo apt-get -y install libgnarl-6.so.1
cd ~ && cd software/ghdl/bin/ && chmod +x *
# Launch:
sudo ./ghdl &

# Install Arduino
sudo apt-get -y install arduino

# Make USB work in virtual box
# https://askubuntu.com/questions/25596/how-to-set-up-usb-for-virtualbox
sudo usermod -aG vboxusers chandran  # Add myself to the virtual box group

# Install foxit reader (windows version using wine)
# cd ~
# mkdir software
# cd software
# wget https://download.heise.de/files/mXC16oruU636pqF0FtzvVg/225117/FoxitReaderPortable_8.1.1.1015.paf.exe?expires=1493200244
# wine FoxitReaderPortable_8.1.1.1015.paf.exe

# Install dropbox - Assuming that its a 64 bit machine
# Dropbox might have a graphical install that requires user interaction, so I will install it last.
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
#~/.dropbox-dist/dropboxd &
echo "~/.dropbox-dist/dropboxd &" >> ~/.profile

# Uninstall packages that have become redundant.
sudo apt-get -y autoremove

#echo $output
