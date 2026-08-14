import decman

decman.execution_order = [
    "files",
    "pacman",
    "aur",
    "systemd",
]

import files
import packages
import services
