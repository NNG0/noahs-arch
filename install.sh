#!/bin/bash

# update system
sudo pacman -Syu

# install and build yay
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

source ~/repos/noahs-arch/scripts/packages/base.sh
source  ~/repos/noahs-arch/scripts/packages/apps.sh
source  ~/repos/noahs-arch/scripts/packages/tools.sh

mkdir ~/images
source  ~/repos/noahs-arch/scripts/wallpaper.sh

# run setup scripts
source  ~/repos/noahs-arch/srcipts/link-configs.sh
source  ~/repos/noahs-arch/scripts/executables.sh
source  ~/repos/noahs-arch/scripts/firewall.sh
source  ~/repos/noahs-arch/scripts/swayosd-setup.sh
