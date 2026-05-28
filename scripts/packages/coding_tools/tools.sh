#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mapfile -t ct < <(grep -vE '^\s*(#|$)' "$SCRIPT_DIR/tools.txt")

sudo pacman -S --needed --noconfirm "${ct[@]}"
