import decman
from pathlib import Path
from decman.plugins.aur import CustomPackage

pkg_dir = Path("../packages")

for pkg_file in pkg_dir.glob("*.txt"):
    pkgs = pkg_file.read_text().splitlines()

    if pkg_file.name == "aur.txt":
        decman.aur.packages |= set(pkgs)
    else:
        decman.pacman.packages |= set(pkgs)

decman.aur.ignored_packages |= {"dummy-nautilus"}

pkgbuild_root = Path("../pkgbuilds").resolve()

decman.aur.custom_packages |= {
    CustomPackage(pkg, pkgbuild_directory=pkgbuild_root / pkg)
    for pkg in ("iosevka-nerd", "watt-bin", "chromium-widevine")
}
