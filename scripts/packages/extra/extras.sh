#!/bin/bash
mapfile -t xpkgs < <(grep -vE '^\s*(#|$)' extras.txt)
mapfile -t aur_xpkgs < < (grep -vE '^\s*(#|$)' aur-extras.txt)

sudo pacman -S --needed --noconfirm "${xpkgs[@]}"
yay -S --needed --noconfirm "${aur_xpkgs[@]}"
