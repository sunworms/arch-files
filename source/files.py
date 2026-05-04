import decman
from decman import File
from pathlib import Path

USER = "sunny"
HOME = f"/home/{USER}"
CONFIG = f"{HOME}/.config"

FILES = {
    f"{CONFIG}/fontconfig/fonts.conf": "../config/fonts.conf",
    f"{CONFIG}/mimeapps.list": "../config/mimeapps.list",
    f"{CONFIG}/hyfetch.json": "../config/hyfetch.json",
    f"{CONFIG}/kdeglobals": "../config/kdeglobals",
    f"{HOME}/.face": "../haruta.jpg",
}

for dest, src in FILES.items():
    decman.files[dest] = File(source_file=src, owner=USER)

SYSTEM_SRC = Path("../config/system")

for path in SYSTEM_SRC.rglob("*"):
    if path.is_file():
        relative = path.relative_to(SYSTEM_SRC)
        dest = Path("/etc") / relative
        decman.files[str(dest)] = File(source_file=str(path))

decman.files["/boot/loader/entries/linux-cachyos.conf"] = File(source_file="../config/linux-cachyos.conf")
