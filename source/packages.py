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

decman.aur.custom_packages |= {
    CustomPackage("iosevka-nerd", pkgbuild_directory="/home/sunny/arch-files/pkgbuilds/iosevka-nerd"),
    CustomPackage("watt-bin", pkgbuild_directory="/home/sunny/arch-files/pkgbuilds/watt"),
}
