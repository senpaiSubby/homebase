#!/bin/bash

CONFIG_DIR='/srv/github/homebase/config'

mkdir -p /srv/github/homebase/config/home/.local/share

########## home ##########

cp -r ~/.themes /srv/github/homebase/config/home/
cp -r ~/.icons /srv/github/homebase/config/home/

cp -r ~/.local/share/fonts /srv/github/homebase/config/home/.local/share/
cp -r ~/.vimrc /srv/github/homebase/config/home/
cp -r ~/.xinitrc /srv/github/homebase/config/home/
cp -r ~/.Xresources /srv/github/homebase/config/home/
cp -r ~/.vim /srv/github/homebase/config/home/
cp -r ~/.Xmodmap /srv/github/homebase/config/home/

########## .config ##########

cp -r ~/.config/mpv /srv/github/homebase/config/home/.config/
cp -r ~/.config/cava /srv/github/homebase/config/home/.config/
cp -r ~/.config/neofetch /srv/github/homebase/config/home/.config/
cp -r ~/.config/polybar /srv/github/homebase/config/home/.config/
cp -r ~/.config/ranger /srv/github/homebase/config/home/.config/
cp -r ~/.config/nvim /srv/github/homebase/config/home/.config/
cp -r ~/.config/dunst /srv/github/homebase/config/home/.config/
cp -r ~/.config/user-dirs.dirs /srv/github/homebase/config/home/.config/
cp -r ~/.config/htop /srv/github/homebase/config/home/.config/
cp -r ~/.config/cmus/ /srv/github/homebase/config/home/.config/
cp -r ~/.config/qutebrowser/ /srv/github/homebase/config/home/.config/
cp -r ~/.config/zathura/ /srv/github/homebase/config/home/.config/
cp -r ~/.config/yay/ /srv/github/homebase/config/home/.config/
cp -r ~/.config/redshift.conf /srv/github/homebase/config/home/.config/
cp -r ~/.config/mimeapps.list /srv/github/homebase/config/home/.config/
cp -r ~/.config/compton/ /srv/github/homebase/config/home/.config/
cp -r ~/.config/bspwm/ /srv/github/homebase/config/home/.config/
cp -r ~/.config/sxhkd/ /srv/github/homebase/config/home/.config/
cp -r ~/.config/rofi/ /srv/github/homebase/config/home/.config/
cp -r ~/.config/oomox/ /srv/github/homebase/config/home/.config/
cp -r ~/.config/deluge/ /srv/github/homebase/config/home/.config/
cp -r ~/.config/libinput-gestures.conf /srv/github/homebase/config/home/.config/

########## /etc ##########
cp /etc/locale.gen /srv/github/homebase/config/etc/
cp /etc/locale.conf /srv/github/homebase/config/etc/

echo Backup Complete
