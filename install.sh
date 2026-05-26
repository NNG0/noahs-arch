#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

confirm() {
    read -rp "$1 [y/N] " answer
    [[ "$answer" =~ ^[Yy]$ ]]
}

step () {
    echo
    echo "==> $1"
}

# update system
step "Updating system..."
sudo pacman -Syu --noconfirm

# install and build yay
if ! command -v yay &>/dev/null; then
    step "Installing yay"
    sudo pacman -S --needed --noconfirm git base-devel
    tmpdir="$(mktemp -d)"
    git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
    pushd "$tmpdir/yay"
    makepkg -si --noconfirm
    popd
    rm -rf "$tmpdir"
fi

step "Installing base packages..."
"$SCRIPT_DIR/scripts/packages/base/base.sh"

if confirm "Install extra packages?"; then
    "$SCRIPT_DIR/scripts/packages/extra/extras.sh"
fi

if confirm "Install coding tools?"; then
    "$SCRIPT_DIR/scripts/packages/coding_tools/tools.sh"
    if confirm "Install nvim config?"; then
        git clone https://github.com/NNG0/noahs-nvim "$HOME/.config/nvim"
    fi
fi


# run setup scripts
step "Setup..."
mkdir -p ~/Pictures
mkdir -p ~/Pictures/Screenshots

"$SCRIPT_DIR/scripts/wallpaper.sh"
"$SCRIPT_DIR/scripts/link-configs.sh"
"$SCRIPT_DIR/scripts/executables.sh"
"$SCRIPT_DIR/scripts/firewall.sh"
"$SCRIPT_DIR/scripts/swayosd-setup.sh"
step "Setup complete."
