import decman

decman.execution_order = [
    "files",
    "pacman",
    "aur",
    "flatpak",
    "systemd",
]

import files
import packages
import flatpaks
import services
