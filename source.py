import decman
from decman import File, Directory
from pathlib import Path

pkg_dir = Path("packages")

for pkg_file in pkg_dir.glob("*.txt"):
    pkgs = pkg_file.read_text().splitlines()

    if pkg_file.name == "aur.txt":
        decman.aur.packages |= set(pkgs)
    else:
        decman.pacman.packages |= set(pkgs)

decman.directories["/home/sunny/.config/DankMaterialShell"] = Directory(source_directory="./config/DankMaterialShell", owner="sunny")
decman.directories["/home/sunny/.config/fish"] = Directory(source_directory="./config/fish", owner="sunny")
decman.directories["/home/sunny/.config/foot"] = Directory(source_directory="./config/foot", owner="sunny")
decman.directories["/home/sunny/.config/git"] = Directory(source_directory="./config/git", owner="sunny")
decman.directories["/home/sunny/.config/kanata"] = Directory(source_directory="./config/kanata", owner="sunny")
decman.directories["/home/sunny/.config/matugen"] = Directory(source_directory="./config/matugen", owner="sunny")
decman.directories["/home/sunny/.config/niri"] = Directory(source_directory="./config/niri", owner="sunny")
decman.directories["/home/sunny/.config/nvim"] = Directory(source_directory="./config/nvim", owner="sunny")

decman.files["/home/sunny/.config/spicetify/config-xpui.ini"] = File(source_file="./config/spicetify-config-xpui.ini", owner="sunny")
decman.files["/home/sunny/.config/mimeapps.list"] = File(source_file="./config/mimeapps.list", owner="sunny")
decman.files["/home/sunny/.config/hyfetch.json"] = File(source_file="./config/hyfetch.json", owner="sunny")
decman.files["/home/sunny/.face"] = File(source_file="./haruta.jpg", owner="sunny")

decman.files["/etc/pacman.conf"] = File(source_file="./config/system/pacman.conf")
decman.files["/etc/makepkg.conf"] = File(source_file="./config/system/makepkg.conf")

decman.symlinks["/home/sunny/.config/systemd/user/niri.service.wants/dms.service"] = "/usr/lib/systemd/user/dms.service"

systemd_services = Path("enabled_services.txt").read_text().splitlines()
decman.systemd.enabled_units |= set(systemd_services)
