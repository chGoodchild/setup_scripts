#!/bin/bash

echo "Please enter the path to the tar installation file: "
read path

sudo alien -d "$path"

echo "Please enter the path to the newly created deb file: "
read path
sudo dpkg -i "$path"

# Convert the RPM file to a deb file
# sudo alien -d diamond_3_9-base_x64-99-2-x86_64-linux.rpm

# Install the deb file
# sudo dpkg -i diamond-3-9-base-x64_3.9-100_amd64.deb
