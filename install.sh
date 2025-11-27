#!/bin/bash

# update system
sudo pacman -Syu

# install and build yay
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

source scripts/packages/base.sh
source scripts/packages/apps.sh
source scripts/packages/tools.sh

source scripts/wallpaper.sh

reboot

# run setup scripts
source srcipts/link-configs.sh
source scripts/executables.sh
source scripts/firewall.sh
source scripts/swayosd-setup.sh
