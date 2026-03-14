import decman
from decman import File

USER = "sunny"
HOME = f"/home/{USER}"
CONFIG = f"{HOME}/.config"

FILES = {
    f"{CONFIG}/fontconfig/fonts.conf": "../config/fonts.conf",
    f"{CONFIG}/spicetify/config-xpui.ini": "../config/spicetify-config-xpui.ini",
    f"{CONFIG}/mimeapps.list": "../config/mimeapps.list",
    f"{CONFIG}/hyfetch.json": "../config/hyfetch.json",
    f"{HOME}/.face": "../haruta.jpg",
}

for dest, src in FILES.items():
    decman.files[dest] = File(source_file=src, owner=USER)

SYSTEM_FILES = {
    "/etc/pacman.conf": "../config/system/pacman.conf",
    "/etc/makepkg.conf": "../config/system/makepkg.conf",
    "/etc/chromium/policies/managed/default.json": "../config/system/chromium.json",
    "/etc/timeshift/timeshift.json": "../config/system/timeshift.json",
}

for dest, src in SYSTEM_FILES.items():
    decman.files[dest] = File(source_file=src)
