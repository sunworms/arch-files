import decman
from decman import Directory

USER = "sunny"
HOME = f"/home/{USER}"
CONFIG = f"{HOME}/.config"

CONFIG_DIRS = [
    "DankMaterialShell",
    "matugen",
    "fish",
    "kitty",
    "git",
    "kanata",
    "niri",
    "helix",
]

for d in CONFIG_DIRS:
    decman.directories[f"{CONFIG}/{d}"] = Directory(
        source_directory=f"../config/{d}",
        owner=USER,
    )
