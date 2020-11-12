#!/bin/bash

# Application Categories ------------------------------------------------------------

NETWORK="wireless_tools net-tools iw wpa_supplicant dialog \
  tor torsocks wget wicd-patched"

BASE="pcmanfm polybar bspwm sxhkd wmname ffmpegthumbnailer \
  urxvt-perls xdotool wmctrl i3lock ttf-ionicons qutebrowser \
  exa sxiv feh w3m lxappearance rofi compton-tryone-git xcalib \
  ttf-material-design-icons arch-wiki-man jrnl deluge python-pywal \
  oomox brightnessctl unclutter-xfixes xinit-xsession cmus \
  mpv gifsicle scrot grsync ranger zip unzip udiskie udisks2 \
  ntfs-3g chromium pepper-flash xdo trash-cli zathura zathura-pdf-poppler \
  zathura-cb git jq python-xdg screen xdg-user-dirs firefox-developer-edition \
  os-prober dunst neovim htop java-openjfx sshfs python-pip zsh npm htop gparted \
  p7zip python-pyside lxqt-policykit powertop tlp preload mbpfan-git piper \
  automake base-devel gitkraken arduino sshfs sqlitebrowser visual-studio-code-bin arch-install-scripts"

DRIVERS="piper b43-firmware-classic"

DISPLAY="xorg-xprop xorg-server xorg-xrandr xorg-xinit xorg-xsetroot \
  xorg-xwininfo xorg-twm xorg-xbacklight xorg-xinput xorg-xclock xterm \
  xorg-xrandr xclip mesa lib32-mesa xf86-video-intel mesa-vdpau \
  lib32-mesa-vdpau intel-ucode"

AUDIO="pulseaudio pulseaudio-alsa alsa-utils pulsemixer a52dec x264 x265 \
  faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis \
  libxv wavpack x264 xvidcore gstreamer gst-plugins-ugly gst-plugins-base \
  gst-plugins-bad gst-libav"

EXTRAS="easytag neofetch \
  make libconfig iotop \
  filebot47 metamorphose2"

# Cleanup Pacman Keys ------------------------------------------------------------

sudo rm -rf /etc/pacman.d/gnupg
sudo pacman-key --init
sudo pacman-key --populate archlinux

# Setup Locale ------------------------------------------------------------

sudo localedef -f UTF-8 -i en_US en_US.UTF-8

# Configure Time ------------------------------------------------------------

sudo pacman -S ntp --noconfirm
sudo systemctl enable ntpd.service
sudo systemctl enable ntpdate.service
sudo timedatectl set-ntp true
sudo timedatectl set-timezone America/Los_Angeles

# Setup YAY AUR Package Manager ------------------------------------------------------------
git clone https://aur.archlinux.org/yay-git.git && cd yay-git && makepkg -csi

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
sudo systemctl enable tlp.service
sudo systemctl enable tlp-sleep.service
sudo systemctl enable wicd.service
sudo systemctl mask lvm2-monitor.service
sudo systemctl enable fancontrol.service
sudo systemctl enable preload
sudo systemctl enable mbpfan.service
sudo systemctl enable piper.service

# Configure Programs ------------------------------------------------------------

# Install Rclone
curl https://rclone.org/install.sh | sudo bash

# Touchpad Gestures
sudo gpasswd -a $USER input
yay -S libinput-gestures
sudo pacman -S xdotool wmctrl
cd ~/git
git clone https://github.com/bulletmark/libinput-gestures.git
cd libinput-gestures
sudo make install

libinput-gestures-setup autostart
libinput-gestures-setup start

# Setup ST Terminal
cd ~/git
git clone https://github.com/callmekory/st
cd st && sudo make clean install

# Clone Script Git
cd ~/ && git clone https://github.com/callmekory/scripts

# Setup nodeJS Global Package Directory
mkdir ~/.npm-global && npm config set prefix '~/.npm-global'

# Setup NVIM Plugin Manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Setup JAVA
sudo archlinux-java set java-10-openjdk

# Python Linting Support
pip3 install --user pynvim jedi pylint

# Create Needed Directories ------------------------------------------------------------

mkdir -p ~/.local/share/Trash/files
mkdir ~/.rtorrent.session

# Setup ZSH Shell ------------------------------------------------------------

git clone --recursive https://github.com/callmekory/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

zsh -c 'setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done'

# Change Shell To ZSH
chsh -s /bin/zsh
