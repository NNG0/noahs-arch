#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mapfile -t pkgs < <(grep -vE '^\s*(#|$)' "$SCRIPT_DIR/base.txt")
mapfile -t tt < <(grep -vE '^\s*(#|$)' "$SCRIPT_DIR/terminal_tools.txt")
mapfile -t tuis < <(grep -vE '^\s*(#|$)' "$SCRIPT_DIR/tuis.txt")
mapfile -t aur_pkgs < <(grep -vE '^\s*(#|$)' "$SCRIPT_DIR/base-aur.txt")

sudo pacman -S --needed --noconfirm "${pkgs[@]}" "${tt[@]}" "${tuis[@]}"
yay -S --needed --noconfirm "${aur_pkgs[@]}"
