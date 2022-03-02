#!/bin/bash

# sudo echo "options snd-hda-intel model=dell-headset-multi" &>> /etc/modprobe.d/alsa-base.conf
echo "options snd-hda-intel model=dell-headset-multi" | sudo tee -a /etc/modprobe.d/alsa-base.conf

restart_is_required=true
