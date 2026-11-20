#!/usr/bin/env bash
# =============================================================================
#  setup-repos.sh — Add Chaotic-AUR repo to an Arch-based system
#  Tested on: Arch Linux, Manjaro, EndeavourOS
# =============================================================================

set -euo pipefail

# ── Colours ──────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

info()    { echo -e "${CYAN}[INFO]${RESET}  $*"; }
success() { echo -e "${GREEN}[OK]${RESET}    $*"; }
warn()    { echo -e "${YELLOW}[WARN]${RESET}  $*"; }
error()   { echo -e "${RED}[ERROR]${RESET} $*" >&2; }
die()     { error "$*"; exit 1; }

# ── Root check ────────────────────────────────────────────────────────────────
[[ $EUID -eq 0 ]] || die "Please run this script as root (sudo $0)"

# ── Banner ────────────────────────────────────────────────────────────────────
echo -e "${BOLD}"
echo "╔══════════════════════════════════════════════════╗"
echo "║   Chaotic-AUR Setup Script                      ║"
echo "║   For Arch Linux and Arch-based distributions   ║"
echo "╚══════════════════════════════════════════════════╝"
echo -e "${RESET}"

# =============================================================================
# Chaotic-AUR Repository
# =============================================================================
setup_chaotic_aur() {
    echo -e "\n${BOLD}━━━ Step 2: Chaotic-AUR Repository ━━━${RESET}\n"

    if grep -q '\[chaotic-aur\]' /etc/pacman.conf 2>/dev/null; then
        warn "Chaotic-AUR already present in /etc/pacman.conf — skipping."
        return 0
    fi

    info "Importing Chaotic-AUR primary key..."
    pacman-key --recv-keys 3056513887B78AEB --keyserver keyserver.ubuntu.com \
        || die "Failed to receive Chaotic-AUR key."
    pacman-key --lsign-key 3056513887B78AEB \
        || die "Failed to locally sign Chaotic-AUR key."
    success "Key imported and signed."

    info "Installing chaotic-keyring and chaotic-mirrorlist..."
    pacman -U --noconfirm \
        'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' \
        'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' \
        || die "Failed to install Chaotic-AUR keyring/mirrorlist."
    success "Keyring and mirrorlist installed."

    info "Adding [chaotic-aur] to /etc/pacman.conf..."
    cat >> /etc/pacman.conf <<'EOF'

# ── Chaotic-AUR ──────────────────────────────────────────────────────────────
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOF
    success "Chaotic-AUR block appended to /etc/pacman.conf."
}

# =============================================================================
# Final sync
# =============================================================================
sync_databases() {
    echo -e "\n${BOLD}━━━ Step 3: Syncing package databases ━━━${RESET}\n"
    info "Running pacman -Syyu ..."
    pacman -Syyu --noconfirm
    success "System is up to date."
}

# =============================================================================
# MAIN
# =============================================================================
setup_chaotic_aur
sync_databases

echo -e "\n${GREEN}${BOLD}All done!${RESET}"
echo -e "Verify Chaotic-AUR: ${CYAN}pacman -Sl chaotic-aur | head${RESET}\n"
