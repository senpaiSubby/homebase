#!/bin/bash

# __       _     _           
#/ _\_   _| |__ | |__  _   _ 
#\ \| | | | '_ \| '_ \| | | |
#_\ \ |_| | |_) | |_) | |_| |
#\__/\__,_|_.__/|_.__/ \__, |
#                      |___/ 

# Application Categories ------------------------------------------------------------

NETWORK="archlinux-keyring net-tools wget netctl network-manager-applet"

BASE="nfs-utils yazi pacseek mpv scrot grsync ranger zip unzip udiskie udisks2 \
  ntfs-3g git screen tmux micro blueman brightnessctl inotify-tools clipman envycontrol \
  os-prober neovim htop sshfszsh htop gparted \
  p7zip automake polkit hyprpolkitagent uwsm libnewt"

pacman -S uwsm libnewt


HYPRLAND="hyprland hyprlock hyprpaper wlogout waybar wofi hypridle"

FONTS="font-manager otf-hasklig-nerd ttf-ionicons ttf-material-design-icons nerd-fonts-git otf-font-awesome "

THEMES="qt5ct qt6ct-kde papirus-icon-theme kvantum plymouth plymouth-kcm"

DRIVERS="mesa libva-intel-driver libva-utils vulkan-intel"

DISPLAY=""

AUDIO="sof-firmware pwvucontrol pipewire pipewire-alsa pipewire-pulse wireplumber"

EXTRAS="bitwarden bambustudio-bin microsoft-edge-dev-bin code-insiders-bin obsidian \
        vencord-bin github-desktop-bin syncthingtray-qt6"

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
yay -S $AUDIO
yay -S $BASE
yay -S $DISPLAY
yay -S $DRIVERS
yay -S $EXTRAS
yay -S $FONTS
yay -S $HYPRLAND
yay -S $NETWORK
yay -S $POWER

# System Tweaks ------------------------------------------------------------

echo "fs.inotify.max_user_watches=204800" | sudo tee -a /etc/sysctl.d/90-override.conf

# Setup System Services ------------------------------------------------------------

sudo systemctl enable udisk2.service
sudo systemctl enable wicd.service
sudo systemctl enable piper.service

systemctl --user --now enable pipewire pipewire-pulse wireplumber

# Configure Programs ------------------------------------------------------------

# Setup ST Terminal
#cd ~/git && git clone https://github.com/callmekory/st &&cd st && sudo make clean install

# Clone Script Git
#cd ~/ && git clone https://github.com/callmekory/scripts

# Setup nodeJS Global Package Directory
#mkdir ~/.npm-global && npm config set prefix '~/.npm-global'

# Setup NVIM Plugin Manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Setup ZSH Shell ------------------------------------------------------------
git clone --recursive https://github.com/senpaisubby/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

zsh -c 'setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done'

# Change Shell To ZSH
chsh -s /bin/zsh



sudo chown -R subby: /mnt /srv
mkdir /mnt/media /mnt/docker /mnt/archive


echo "INSTALL COMPLETE"
oreo-cursors-bin
rose-pine-cursor rose-pine-hyprcursor
