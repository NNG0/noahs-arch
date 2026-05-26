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

STEAM=false
EXTRAS=false
CODING=false
NVIM=false

step "Choose options..."
if confirm "Install extra packages?"; then
    EXTRAS=true
fi

if confirm "Install coding tools?"; then
    CODING=true
    if confirm "Install nvim config?"; then
        NVIM=true
    fi
fi

if confirm "Install steam?"; then
    STEAM=true
fi

# enable repository
if $STEAM; then
    step "Enabling multilib repository"
    sudo sed -i '/^\#\[multilib\]/,/^\#Include = \/etc\/pacman.d\/mirrorlist/ {s/^#//}' /etc/pacman.conf
fi


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

# update system
step "Updating system..."
sudo pacman -Syu --noconfirm

step "Installing base packages..."
"$SCRIPT_DIR/scripts/packages/base/base.sh"

if $EXTRAS; then
    step "Installing extra packages..."
    "$SCRIPT_DIR/scripts/packages/extra/extras.sh"
fi

if $CODING; then
    step "Installing coding tools..."
    "$SCRIPT_DIR/scripts/packages/coding_tools/tools.sh"

    if $NVIM; then
        step "Installing neovim config..."
        git clone https://github.com/NNG0/noahs-nvim "$HOME/.config/nvim"
    fi
fi

if $STEAM; then
    sudo pacman -S steam --needed --noconfirm
fi

# run setup scripts
step "Setup..."
mkdir -p ~/Pictures/Screenshots

"$SCRIPT_DIR/scripts/wallpaper.sh"
"$SCRIPT_DIR/scripts/link-configs.sh"
"$SCRIPT_DIR/scripts/executables.sh"
"$SCRIPT_DIR/scripts/firewall.sh"
"$SCRIPT_DIR/scripts/swayosd-setup.sh"
step "Setup complete."
