#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONF="$HOME/.config/noahs-arch/noahs-arch.conf"

confirm() {
    read -rp "$1 [y/N] " answer
    [[ "$answer" =~ ^[Yy]$ ]]
}

step () {
    echo
    echo "==> $1"
}

step "Ensuring scripts are executable..."
chmod +x "$SCRIPT_DIR/scripts/executables.sh"
"$SCRIPT_DIR/scripts/executables.sh"

step "Initializing configuration symlinks..."
"$SCRIPT_DIR/scripts/link-configs.sh"

if [[ -f "$CONF" ]]; then
    source "$CONF"
else
    echo "Warning: Config file not found at $CONF even after running link-configs.sh"
fi

# Fallback initialization
EXTRAS=${EXTRAS:-false}
CODING=${CODING:-false}
NVIM=${NVIM:-false}
STEAM=${STEAM:-false}

step "Choose package modules to install..."

if confirm "Install extra packages? [Current: $EXTRAS]"; then
    EXTRAS=true
else
    EXTRAS=false
fi

if confirm "Install coding tools? [Current: $CODING]"; then
    CODING=true
    if confirm "Install nvim config? [Current: $NVIM]"; then
        NVIM=true
    else
        NVIM=false
    fi
else
    CODING=false
    NVIM=false
fi

if confirm "Install steam? [Current: $STEAM]"; then
    STEAM=true
else
    STEAM=false
fi

REAL_CONF=$(readlink -f "$CONF")

declare -A updates=(
    ["EXTRAS"]="$EXTRAS"
    ["CODING"]="$CODING"
    ["NVIM"]="$NVIM"
    ["STEAM"]="$STEAM"
)

for key in "${!updates[@]}"; do
    value="${updates[$key]}"
    if grep -q "^$key=" "$REAL_CONF"; then
        sed -i "s|^$key=.*|$key=$value|" "$REAL_CONF"
    else
        echo "$key=$value" >> "$REAL_CONF"
    fi
done

if $STEAM; then
    step "Enabling multilib repository"
    sudo sed -i '/^\#\[multilib\]/,/^\#Include = \/etc\/pacman.d\/mirrorlist/ {s/^#//}' /etc/pacman.conf
fi

# Install and build yay
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

    if $NVIM && [ ! -d "$HOME/.config/nvim" ]; then
        step "Installing neovim config..."
        git clone https://github.com/NNG0/noahs-nvim "$HOME/.config/nvim"
    fi
fi

if $STEAM; then
    sudo pacman -S steam --needed --noconfirm
fi

step "Setup..."
mkdir -p ~/Pictures/Screenshots


"$SCRIPT_DIR/scripts/first-run/"*

step "Cleanup..."
noahs-arch-maintance

step "Setup complete."
