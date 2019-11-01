#!/bin/bash
mkdir -p ~/git/homebase/config/home/.local/share

########## home ##########

cp -r ~/.hushlogin ~/git/homebase/config/home/
cp -r ~/.themes ~/git/homebase/config/home/
cp -r ~/.icons ~/git/homebase/config/home/

cp -r ~/.local/share/fonts ~/git/homebase/config/home/.local/share/
cp -r ~/.gitconfig ~/git/homebase/config/home/
cp -r ~/.vimrc ~/git/homebase/config/home/
cp -r ~/.rtorrent.rc ~/git/homebase/config/home/
cp -r ~/.xinitrc ~/git/homebase/config/home/
cp -r ~/.Xresources ~/git/homebase/config/home/
cp -r ~/.vim ~/git/homebase/config/home/
cp -r ~/.jrnl_config ~/git/homebase/config/home/
cp -r ~/.Xmodmap ~/git/homebase/config/home/
cp -r ~/.mailcap ~/git/homebase/config/home/
cp -r ~/.grsync ~/git/homebase/config/home/

cp -r ~/.weechat ~/git/homebase/config/home/

########## .config ##########




cp -r ~/.config/bleachbit ~/git/homebase/config/.config/
cp -r ~/.config/btops ~/git/homebase/config/.config/
cp -r ~/.config/deluge ~/git/homebase/config/.config/
cp -r ~/.config/wal ~/git/homebase/config/.config/
cp -r ~/.config/libreoffice ~/git/homebase/config/.config/
cp -r ~/.config/thefuck ~/git/homebase/config/.config/
cp -r ~/.config/mpv ~/git/homebase/config/.config/
cp -r ~/.config/Tusk ~/git/homebase/config/.config/
cp -r ~/.config/cava ~/git/homebase/config/.config/
cp -r ~/.config/htop ~/git/homebase/config/.config/
cp -r ~/.config/neofetch ~/git/homebase/config/.config/
cp -r ~/.config/polybar ~/git/homebase/config/.config/
cp -r ~/.config/ranger ~/git/homebase/config/.config/
cp -r ~/.config/torrench ~/git/homebase/config/.config/
cp -r ~/.config/nvim ~/git/homebase/config/.config/
cp -r ~/.config/dunst ~/git/homebase/config/.config/
cp -r ~/.config/user-dirs.dirs ~/git/homebase/config/.config/
cp -r ~/.config/htop ~/git/homebase/config/.config/
cp -r ~/.config/cmus/ ~/git/homebase/config/.config/
cp -r ~/.config/qutebrowser/ ~/git/homebase/config/.config/
cp -r ~/.config/rtv/ ~/git/homebase/config/.config/
cp -r ~/.config/zathura/ ~/git/homebase/config/.config/
cp -r ~/.config/yay/ ~/git/homebase/config/.config/
cp -r ~/.config/newsboat/ ~/git/homebase/config/.config/
cp -r ~/.config/redshift.conf ~/git/homebase/config/.config/
cp -r ~/.config/mimeapps.list ~/git/homebase/config/.config/
cp -r ~/.config/compton/ ~/git/homebase/config/.config/
cp -r ~/.config/bspwm/ ~/git/homebase/config/.config/
cp -r ~/.config/sxhkd/ ~/git/homebase/config/.config/
cp -r ~/.config/rofi/ ~/git/homebase/config/.config/
cp -r ~/.config/oomox/ ~/git/homebase/config/.config/
cp -r ~/.config/gtk-3.0/ ~/git/homebase/config/.config/
cp -r ~/.config/gnormalize/ ~/git/homebase/config/.config/
cp -r ~/.config/deluge/ ~/git/homebase/config/.config/
cp -r ~/.config/compiz-1/ ~/git/homebase/config/.config/
cp -r ~/.config/deluge/ ~/git/homebase/config/.config/
cp -r ~/.config/Fritzing/ ~/git/homebase/config/.config/
cp -r ~/.config/vlc/ ~/git/homebase/config/.config/
cp -r ~/.config/xfce4/ ~/git/homebase/config/.config/
cp -r ~/.config/openbox/ ~/git/homebase/config/.config/


########## /etc ##########
cp /etc/locale.gen ~/git/homebase/config/etc/
cp /etc/locale.conf ~/git/homebase/config/etc/
cp /etc/default/tlp ~/git/homebase/config/etc/default/

#mkdir ~/git/homebase/config/etc/systemd
sudo cp -r /etc/systemd/logind.conf ~/git/homebase/config/etc/systemd/
sudo chown -R sublime:users ~/git/homebase/

echo Backup Complete

