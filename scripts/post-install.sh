#!/bin/sh
gsettings set org.gnome.desktop.interface font-name 'Iosevka Aile Lean 11'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface cursor-theme "'volantes_cursors'"
gsettings set org.gnome.desktop.interface icon-theme "'Adwaita'"
gsettings set org.gnome.desktop.interface gtk-theme "'adw-gtk3'"

sudo systemctl disable getty@tty1.service
sudo systemctl disable NetworkManager-wait-online.service

chsh -s /usr/bin/fish
