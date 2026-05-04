import decman
from decman import File, Directory
from pathlib import Path

USER = "sunny"
HOME = f"/home/{USER}"
CONFIG = f"{HOME}/.config"

DOT_CONFIG_SRC = Path("../config/dot-config")

for path in DOT_CONFIG_SRC.iterdir():
    dest = Path(CONFIG) / path.name
    if path.is_dir():
        decman.directories[str(dest)] = Directory(source_directory=str(path), owner=USER)
    else:
        decman.files[str(dest)] = File(source_file=str(path), owner=USER)

decman.files[f"{HOME}/.face"] = File(source_file="../haruta.jpg", owner=USER)

SYSTEM_SRC = Path("../config/system")

for path in SYSTEM_SRC.rglob("*"):
    if path.is_file():
        relative = path.relative_to(SYSTEM_SRC)
        dest = Path("/etc") / relative
        decman.files[str(dest)] = File(source_file=str(path))

decman.files["/boot/loader/entries/linux-cachyos.conf"] = File(source_file="../config/linux-cachyos.conf")
