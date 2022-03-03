sudo apt install -y emacs octave python3 keepass2 terminator htop ssh

# install skype
if ! [ -x "$(command -v skypeforlinux)" ]; then
    wget https://go.skype.com/skypeforlinux-64.deb
    sudo dpkg --install skypeforlinux-64.deb 
else
  echo 'Skype is already installed' >&2
fi

# install zoom
if ! [ -x "$(command -v zoom)" ]; then
    wget https://zoom.us/client/latest/zoom_amd64.deb
    sudo apt install -y libgl1-mesa-glx libegl1-mesa libxcb-xtest0
    sudo dpkg --install zoom_amd64.deb 
else
  echo 'Zoom is already installed' >&2
fi

# download dropbox
if ! [ -x "$(command -v dropbox)" ]; then
    wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb
    sudo dpkg --install download\?dl\=packages%2Fubuntu%2Fdropbox_2020.03.04_amd64.deb
else
  echo 'Dropbox is already installed' >&2
fi


# install signal - only run this once, to avoid setting the libraries multiple timese
if ! [ -x "$(command -v signal-desktop)" ]; then
    echo "signal-desktop was not found - installing it!"
    chmod u+x signal.sh
    sudo ./signal.sh
else
  echo 'Signal is already installed' >&2
fi

# Install intelij and pycharm
sudo snap install intellij-idea-community --classic
sudo snap install pycharm-community --classic

# Latex editors
sudo apt install -y gedit-latex-plugin
sudo apt install -y lyx
sudo apt install -y texstudio

# Latex packages
sudo apt install -y texlive-latex-extra

# https://code.visualstudio.com/docs/?dv=linux64_deb
sudo ./visual_studio_code.sh
