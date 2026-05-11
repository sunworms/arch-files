import decman

decman.execution_order = [
    "files",
    "pacman",
    "aur",
    "flatpak",
    "systemd",
]

import packages
import files
import services
import symlinks
import flatpaks
