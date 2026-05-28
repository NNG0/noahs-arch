#!/bin/bash

sudo ufw default deny incoming
sudo ufw default allow outgoing

# allow syncthing
sudo ufw allow 53317/udp
sudo ufw allow 53317/tcp

# allow ssh in
sudo ufw allow 22/tcp

# turn on
sudo ufw --force enable

# start on boot
sudo systemctl enable ufw
