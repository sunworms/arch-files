import decman
from decman import File, Directory
from pathlib import Path

USER = "sunny"
HOME = f"/home/{USER}"
CONFIG = f"{HOME}/.config"

decman.directories[f"{CONFIG}"] = Directory(source_directory="../config/dot-config", owner=USER)


SYSTEM_SRC = Path("../config/system")

for path in SYSTEM_SRC.rglob("*"):
    if path.is_file():
        relative = path.relative_to(SYSTEM_SRC)
        dest = Path("/etc") / relative
        decman.files[str(dest)] = File(source_file=str(path))

decman.files["/boot/loader/entries/linux.conf"] = File(source_file="../config/linux.conf")

decman.files["/usr/share/qtermwidget6/color-schemes/Catppucin-Mocha.colorscheme"] = File(source_file="../config/themes/qterminal/Catppuccin-Mocha.colorscheme")
decman.directories["/usr/share/lxqt/themes/catppuccin-mocha"] = Directory(source_directory="../config/themes/lxqt/catppuccin-mocha")
decman.directories[f"{CONFIG}/Kvantum/catppuccin-mocha-lavender"] = Directory(source_directory="../config/themes/Kvantum/catppuccin-mocha-lavender", owner=USER)

decman.directories[f"{HOME}/.local/bin"] = Directory(
    source_directory="../scripts/bin",
    bin_files=False,
    owner=USER,
    permissions=0o775,
)

decman.symlinks["/usr/bin/xdg-terminal-exec"] = "/usr/bin/foot"
decman.symlinks[f"{CONFIG}/lxqt"] = str(Path("../config/symlinks/lxqt").resolve())
decman.symlinks[f"{CONFIG}/systemd/user/default.target.wants/clear-cache.service"] = str(Path("../config/dot-config/systemd/user/clear-cache.service").resolve())
decman.symlinks[f"{CONFIG}/systemd/user/default.target.wants/rclone-gdrive.service"] = str(Path("../config/dot-config/systemd/user/rclone-gdrive.service").resolve())
