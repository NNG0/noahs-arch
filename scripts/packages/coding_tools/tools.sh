#!/bin/bash
mapfile -t ct < <(grep -vE '^\s*(#|$)' tools.txt)

sudo pacman -S --needed --noconfirm "${ct[@]}"
