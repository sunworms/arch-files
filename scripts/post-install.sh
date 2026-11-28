#!/bin/sh
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface cursor-theme "'volantes_cursors'"

sudo systemctl disable NetworkManager-wait-online.service

chsh -s /usr/bin/fish
