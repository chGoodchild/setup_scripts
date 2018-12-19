#!/bin/sh

# Put a script containing the command in your /etc directory. Create a
# script such as "startup.sh" using your favorite text editor. Save
# the file in your /etc/init.d/ directory. Change the permissions of
# the script (to make it executable) by typing "chmod +x
# /etc/init.d/mystartup.sh".

# Source:
# https://smallbusiness.chron.com/run-command-startup-linux-27796.html q

syndaemon -i 1 -K -d
sudo powertop --auto-tune
sudo powertop
sudo tlp

# To fix the mouse problem:
# sudo modprobe -r psmouse
# sudo modprobe psmouse
