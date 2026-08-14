#!/bin/sh
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface cursor-theme "'volantes_cursors'"
gsettings set org.gnome.desktop.interface icon-theme "'Adwaita'"
gsettings set org.gnome.desktop.interface gtk-theme "'adw-gtk3'"

sudo systemctl disable getty@tty1.service

chsh -s /usr/bin/fish
