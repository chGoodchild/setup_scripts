#!/bin/bash
# This script is written to set up my debian 8 system.
# Execute this script as root. To become root, type "su" in the command line.

# if: http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html
# For now just print sudo if I am already a sudoer...
# groups | grep sudo

# me=$(whoami)

# This doesn't work, because the variable is not stored in root's shell.
# su && adduser echo "$me"


# Add chandran to the sudoers group.
adduser chandran sudo
output=$echo "After being added to a new group the user must log out and then log back in again for the new group to take effect. Groups are only assigned to users at login time. A most common source of confusion is that people add themselves to a new group but then do not log out and back in again and then have problems because the group is not assigned; be sure to verify group membership.\n"

echo $output

shutdown -r now
