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

dpkg-reconfigure dash
source /etc/bash.bashrc
# Make prompts colorful:
# echo 'export PS1="[\u@\[\e[32;1m\]\H \[\e[0m\]\w]\$ "' >> /etc/bash.bashrc
echo "alias ls='ls --color=auto'" >> /etc/bash.bashrc
echo "alias ll='ls -la --color=auto'" >> /etc/bash.bashrc
echo "alias octave='octave --force-gui'" >> /etc/bash.bashrc


###############################################

# Update /etc/apt/sources.lis
sudo apt-get -y update

# Upgrade the already installed packages
sudo apt-get -y upgrade

# Upgrade packages that have not yet been installed (kernel)
# sudo apt-get dist-upgrade

# Sadly this is not the same as gnome-terminal in Ubuntu. I have to find something that I like.
sudo apt-get -y install gnome-terminal

# Install emacs
sudo apt-get -y install emacs

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
mkdir svn

# Install git
sudo apt-get -y install git
#mkdir git
#cd git
#chown git chandran
#git clone "https://github.com/chGoodchild/setup_scripts.git"
#cd

# Install dropbox - Assuming that its a 64 bit machine
# Dropbox might have a graphical install that requires user interaction, so I will install it last.
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
~/.dropbox-dist/dropboxd

# Uninstall packages that have become redundant.
sudo apt-get -y autoremove

#echo $output
