import decman
from decman import File, Directory
from pathlib import Path

USER = "sunny"
HOME = f"/home/{USER}"
CONFIG = f"{HOME}/.config"

decman.directories[f"{CONFIG}"] = Directory(source_directory="../config/dot-config", owner=USER)

decman.files[f"{HOME}/.face"] = File(source_file="../haruta.jpg", owner=USER)

SYSTEM_SRC = Path("../config/system")

for path in SYSTEM_SRC.rglob("*"):
    if path.is_file():
        relative = path.relative_to(SYSTEM_SRC)
        dest = Path("/etc") / relative
        decman.files[str(dest)] = File(source_file=str(path))

decman.files["/boot/loader/entries/linux-cachyos.conf"] = File(source_file="../config/linux-cachyos.conf")
decman.files["/opt/zen-browser-bin/distribution/policies.json"] = File(source_file="../config/zen-polices.json")

decman.directories[f"{HOME}/.local/bin"] = Directory(
    source_directory="../scripts/bin",
    bin_files=False,
    owner=USER,
    permissions=0o775,
)
