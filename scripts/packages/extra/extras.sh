#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mapfile -t xpkgs < <(grep -vE '^\s*(#|$)' "$SCRIPT_DIR/extras.txt")
mapfile -t aur_xpkgs < <(grep -vE '^\s*(#|$)' "$SCRIPT_DIR/aur_extras.txt")

sudo pacman -S --needed --noconfirm "${xpkgs[@]}"
yay -S --needed --noconfirm "${aur_xpkgs[@]}"
