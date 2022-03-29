#!/bin/bash
#VERY simple script to install a riced i3 Gentoo system.
#Made for personal use, but feel free to use it, however I am not in any way responsible for any damage this script may cause.
# You have been warned.


## Configure Portage
sudo mkdir -p /etc/portage/package.{use,accept_keywords}
sudo cp portage/package.use /etc/portage/package.use/generic
sudo cp portage/package.accept_keywords /etc/portage/package.accept_keywords/generic


## Move dotfiles
mv config/.bashrc ~/.bashrc
mv config/i3 ~/.i3
mv config/.emacs ~/.emacs
sudo mv config/.bashrc_root /root/.bashrc
mv config/* ~/.config/


## Emerge Layman and add necessary overlays
sudo emerge layman
sudo layman -S
sudo layman -a brave-overlay
sudo layman -a guru
sudo layman -a steam-overlay
sudo layman -a dinolay


## Emerge packages
sudo emerge i3-gaps polybar rofi emacs sddm lxappearance neofetch qt5ct audacity dolphin i3lock alacritty vlc mpv blender timeshift brave-bin gimp libreoffice thunderbird-bin seamonkey virtualbox kdeconnect steam-launcher




## Move themes, cursors and icon packs

