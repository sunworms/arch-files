import decman
from pathlib import Path

pkg_dir = Path("../packages")

for pkg_file in pkg_dir.glob("*.txt"):
    pkgs = pkg_file.read_text().splitlines()

    if pkg_file.name == "aur.txt":
        decman.aur.packages |= set(pkgs)
    else:
        decman.pacman.packages |= set(pkgs)
