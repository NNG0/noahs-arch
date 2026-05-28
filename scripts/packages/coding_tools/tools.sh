#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mapfile -t ct < <(grep -vE '^\s*(#|$)' "$SCRIPT_DIR/tools.txt")
mapfile -t aur_ct < <(grep -vE '^\s*(#|$)' "$SCRIPT_DIR/aur_tools.txt")

sudo pacman -S --needed --noconfirm "${ct[@]}"
yay -S --needed --noconfirm "${aur_ct[@]}"
