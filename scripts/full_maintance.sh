



# Colors
green="\e[32m"
red="\e[31m"
reset="\e[0m"


info() { echo -e "${green}[INFO]${reset} $1"; }
error() { echo -e "${red}[ERROR]${reset} $1"; }

# Check if script is run with sudo
if [[ $EUID -ne 0 ]]; then
  error "⚠️  This script must be run with sudo privileges."
  exit 1
fi
# 1. Update system packages
update_system() {
    info "Updating AUR packages via yay..."
    yay -Syu --noconfirm
}

# 2. Clean package cache
clean_cache() {
    info "Cleaning cache..."
    paccache -r
    paccache -ruk0

    info "package cache cleaned"

    yay -Sc --noconfirm

    info "yay package cache cleaned"
}

# 3. Remove orphan packages
remove_orphans() {
    info "Removing orphaned packages..."
    orphans=$(pacman -Qdtq || true)
    if [ -n "$orphans" ]; then
    yay -Rns --noconfirm $orphans
    else
    info "No orphaned packages found."
    fi
}

check_systemd() {
    info "check systemd"
    systemctl --failed
}

check_disk_usage() {
    info "disk usage"
    dust
}

remove_journal_entries() {
    info "remove journal entries older than two weeks"
    journalctl --vacuum-time=2weeks
}

# show installed packages
installed_packages() {
    info "installed packages"
    pacman -Qqe
}

full_maintance() {
    update_system
    clean_cache
    remove_orphans
    check_systemd
    check_disk_usage
    remove_journal_entries
    installed_packages
}

full_maintance

info "yay -Rsn to remove packages"

