import decman
from decman import Directory

USER = "sunny"
HOME = f"/home/{USER}"
CONFIG = f"{HOME}/.config"

CONFIG_DIRS = [
    "DankMaterialShell",
    "fish",
    "foot",
    "git",
    "kanata",
    "matugen",
    "niri",
    "nvim",
]

for d in CONFIG_DIRS:
    decman.directories[f"{CONFIG}/{d}"] = Directory(
        source_directory=f"../config/{d}",
        owner=USER,
    )

decman.directories[f"{HOME}/.local/share/applications"] = Directory(
    source_directory="../config/desktop-files",
    owner=USER,
)
