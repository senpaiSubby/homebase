#!/bin/bash

# __       _     _           
#/ _\_   _| |__ | |__  _   _ 
#\ \| | | | '_ \| '_ \| | | |
#_\ \ |_| | |_) | |_) | |_| |
#\__/\__,_|_.__/|_.__/ \__, |
#                      |___/ 


# Application Categories ------------------------------------------------------------

NETWORK="archlinux-keyring net-tools wget netctl"

BASE="ttf-ionicons ttf-material-design-icons mpv scrot grsync ranger zip unzip udiskie udisks2 \
  ntfs-3g chromium git screen tmux \
  os-prober neovim htop sshfs python-pip zsh htop gparted \
  p7zip automake"

DRIVERS="piper"

DISPLAY="xorg"

AUDIO="pulseaudio pulseaudio-alsa alsa-utils pulsemixer a52dec x264 x265 \
  faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis \
  libxv wavpack x264 xvidcore gstreamer gst-plugins-ugly gst-plugins-base \
  gst-plugins-bad gst-libav"

EXTRAS=""

# Cleanup Pacman Keys ------------------------------------------------------------

# Setup Locale ------------------------------------------------------------

sudo localedef -f UTF-8 -i en_US en_US.UTF-8

# Configure Time ------------------------------------------------------------

sudo pacman -S ntp --noconfirm
sudo systemctl enable ntpd.service
sudo timedatectl set-ntp true
sudo timedatectl set-timezone America/Los_Angeles

# Setup YAY AUR Package Manager ------------------------------------------------------------
cd ~/git && git clone https://aur.archlinux.org/yay-git.git && cd yay-git && makepkg -csi && cd ~/git/homebase

# Install Programs ------------------------------------------------------------
yay -S $NETWORK
yay -S $BASE
yay -S $POWER
yay -S $DISPLAY
yay -S $AUDIO
yay -S $EXTRAS
yay -S $DRIVERS

# System Tweaks ------------------------------------------------------------

echo "fs.inotify.max_user_watches=204800" | sudo tee -a /etc/sysctl.d/90-override.conf

# Setup System Services ------------------------------------------------------------

sudo systemctl enable udisk2.service
sudo systemctl enable wicd.service
sudo systemctl enable piper.service

# Configure Programs ------------------------------------------------------------

# Install Rclone
curl https://rclone.org/install.sh | sudo bash


# Setup ST Terminal
#cd ~/git && git clone https://github.com/callmekory/st &&cd st && sudo make clean install

# Clone Script Git
#cd ~/ && git clone https://github.com/callmekory/scripts

# Setup nodeJS Global Package Directory
#mkdir ~/.npm-global && npm config set prefix '~/.npm-global'

# Setup NVIM Plugin Manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Setup JAVA
#sudo archlinux-java set java-10-openjdk



# Create Needed Directories ------------------------------------------------------------
#mkdir -p ~/.local/share/Trash/files
#mkdir ~/.rtorrent.session

# Setup ZSH Shell ------------------------------------------------------------
git clone --recursive https://github.com/senpaisubby/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

zsh -c 'setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done'

# Change Shell To ZSH
chsh -s /bin/zsh

echo "INSTALL COMPLETE"







xorg sddm chromium nvidia nvidia-settings discord openssh git plasma plasma-extras kde-applications wget \
sof-firmware zsh ccsm compiz emerald emerald-themes plexamp-appimage plex-desktop nano linux linux-headers \
netctl ranger archlinux-keyring