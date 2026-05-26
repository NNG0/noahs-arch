#!/bin/bash
mapfile -t pkgs < <(grep -vE '^\s*(#|$)' base.txt)
mapfile -t tt < <(grep -vE '^\s*(#|$)' terminal_tools.txt)
mapfile -t tuis < < (grep -vE '^\s*(#|$)' tuis.txt)
mapfile -t aur_pkgs < < (grep -vE '^\s*(#|$)' base-aur.txt)

sudo pacman -S --needed --noconfirm "${pkgs[@]}"
sudo pacman -S --needed --noconfirm "${tt[@]}"
sudo pacman -S --needed --noconfirm "${tuis[@]}"
yay -S --needed --noconfirm "${aur_pkgs[@]}"
