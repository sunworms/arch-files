#!/usr/bin/env bash
# =============================================================================
#  setup-repos.sh — Add CachyOS + Chaotic-AUR repos to an Arch-based system
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
echo "║   CachyOS Repos + Chaotic-AUR Setup Script      ║"
echo "║   For Arch Linux and Arch-based distributions   ║"
echo "╚══════════════════════════════════════════════════╝"
echo -e "${RESET}"

# =============================================================================
# SECTION 1 — CachyOS Repositories
# =============================================================================
setup_cachyos() {
    echo -e "\n${BOLD}━━━ Step 1: CachyOS Repositories ━━━${RESET}\n"

    if grep -q '\[cachyos\]' /etc/pacman.conf 2>/dev/null; then
        warn "CachyOS repos already present in /etc/pacman.conf — skipping."
        return 0
    fi

    # Work in /tmp so all sibling files (including install-repo.awk) stay together
    local WORKDIR="/tmp/cachyos-repo-setup"
    rm -rf "$WORKDIR"
    mkdir -p "$WORKDIR"

    info "Downloading CachyOS repo tarball..."
    curl -fsSL "https://mirror.cachyos.org/cachyos-repo.tar.xz" \
        -o "$WORKDIR/cachyos-repo.tar.xz" \
        || die "Failed to download CachyOS repo tarball."

    info "Extracting..."
    tar -xf "$WORKDIR/cachyos-repo.tar.xz" -C "$WORKDIR"

    # The tarball extracts to a subdirectory called cachyos-repo/
    # We MUST cd into it so install-repo.awk is found via a relative path
    local SCRIPTDIR="$WORKDIR/cachyos-repo"
    [[ -d "$SCRIPTDIR" ]] || die "Expected directory $SCRIPTDIR not found after extraction."
    [[ -f "$SCRIPTDIR/cachyos-repo.sh" ]] || die "cachyos-repo.sh not found in $SCRIPTDIR."

    info "Running official CachyOS installer (from its own directory)..."
    pushd "$SCRIPTDIR" > /dev/null
    bash cachyos-repo.sh
    popd > /dev/null

    # Verify the repos were actually added
    if grep -q '\[cachyos\]' /etc/pacman.conf 2>/dev/null; then
        success "CachyOS repositories confirmed in /etc/pacman.conf."
    else
        die "CachyOS repos were NOT added to /etc/pacman.conf. Check the installer output above."
    fi

    rm -rf "$WORKDIR"
}

# =============================================================================
# SECTION 2 — Chaotic-AUR Repository
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
# SECTION 3 — Final sync
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
setup_cachyos
setup_chaotic_aur
sync_databases

echo -e "\n${GREEN}${BOLD}All done!${RESET}"
echo -e "Verify CachyOS:     ${CYAN}pacman -Sl cachyos | head${RESET}"
echo -e "Verify Chaotic-AUR: ${CYAN}pacman -Sl chaotic-aur | head${RESET}\n"
