#!/bin/sh
gsettings set org.gnome.desktop.interface font-name 'Sans 11'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface cursor-theme "'volantes_cursors'"
gsettings set org.gnome.desktop.interface icon-theme "'breeze'"
gsettings set org.gnome.desktop.interface gtk-theme "'catppuccin-mocha-lavender-standard+default'"

sudo systemctl disable NetworkManager-wait-online.service

chsh -s /usr/bin/fish
