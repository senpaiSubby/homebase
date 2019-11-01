#! /bin/bash

sudo rm -rf /etc/pacman.d/gnupg
sudo pacman-key --init
sudo pacman-key --populate archlinux
########################################################
# Locale #
########################################################
sudo localedef -f UTF-8 -i en_US en_US.UTF-8

########################################################
# Time #
########################################################
sudo pacman -S ntp --noconfirm
sudo systemctl enable ntpd.service
sudo systemctl enable ntpdate.service
sudo timedatectl set-ntp true
sudo timedatectl set-timezone America/Los_Angeles

########################################################
# YAY AUR #
########################################################
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -csi

########################################################
# Network Tools #
########################################################
yay -S wireless_tools net-tools iw wpa_supplicant dialog \
tor torsocks wget wicd-patched

########################################################
# Base Desktop Enviroment #
########################################################
yay -S pcmanfm polybar bspwm sxhkd wmname ffmpegthumbnailer \
urxvt-perls xdotool wmctrl i3lock ttf-ionicons qutebrowser \
exa sxiv feh w3m lxappearance rofi compton-tryone-git xcalib \
ttf-material-design-icons arch-wiki-man jrnl \
deluge python-pywal oomox-git \
brightnessctl unclutter-xfixes-git \
xinit-xsession cmus mpv gifsicle scrot grsync ranger-git zip \
unzip udiskie udisks2 ntfs-3g chromium pepper-flash xdo \
trash-cli zathura zathura-pdf-poppler zathura-cb git \
jq python-xdg screen xdg-user-dirs firefox-developer-edition \
os-prober dunst neovim-git htop java-openjfx sshfs python-pip \
npm htop gparted p7zip python-pyside razercfg-git lxqt-policykit

# Unfound: cower qt5-webengine-widevine
########################################################
# Power Management #
########################################################
yay -S powertop tlp

########################################################
# Intel #
########################################################
#yay -S mesa lib32-mesa xf86-video-intel mesa-vdpau lib32-mesa-vdpau intel-ucode

########################################################
# AMD #
########################################################
yay -S mesa lib32-mesa xf86-video-intel intel-ucode mesa-vdpau lib32-mesa-vdpau opencl-amd

########################################################
# Xorg #
########################################################
yay -S xorg-xprop xorg-server xorg-xrandr xorg-xinit \
xorg-xsetroot xorg-xwininfo xorg-twm xorg-xbacklight \
xorg-xinput xorg-xclock xterm xorg-xrandr xclip

########################################################
# Audio #
########################################################
yay -S pulseaudio pulseaudio-alsa alsa-utils pulsemixer

########################################################
# Codecs #
########################################################
yay -S a52dec x264 x265 faac faad2 flac jasper lame libdca \
libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 \
xvidcore gstreamer gst-plugins-ugly gst-plugins-base \
gst-plugins-bad gst-libav

########################################################
# Extras #
########################################################
#yay -S virtualbox virtualbox-host-dkms weechat libreoffice-fresh \
youtube-dl easytag simplescreenrecorder steam bleachbit \
neofetch cava magnet2torrent-git tusk code soundconverter \
qnormalize make libconfig iotop pyrenamer filebot47 minecraft \
banshee filebot47 metamorphose2 qsyncthingtray


#######################################################
# Kernel
#######################################################

#gpg --recv-keys 79BE3E4300411886
#gpg --recv-keys 38DBBDC86092693E
#yay -S linux-ck


#####
# Increase Inotify limits
#
echo "fs.inotify.max_user_watches=204800" | sudo tee -a /etc/sysctl.d/90-override.conf
########################################################
# Nvim #
########################################################
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

########################################################
# PIP Installs #
########################################################
sudo archlinux-java set java-10-openjdk
sudo npm install -g livedown

# For nvim linting support
pip3 install --user pynvim
pip3 install --user jedi
pip3 install --user pylint

pip3 install yapf --user
pip3 install thefuck --user

sudo modprobe vboxdrv
pip3 install cmus-notify --user

########################################################
# Services #
########################################################
sudo systemctl enable razerd.service
sudo systemctl enable udisk2.service
sudo systemctl enable tlp.service
sudo systemctl enable tlp-sleep.service
sudo systemctl enable wicd.service
sudo systemctl mask lvm2-monitor.service
sudo systemctl enable fancontrol.service

########################################################
# Directories #
########################################################
mkdir -p ~/.local/share/Trash/files
mkdir ~/.rtorrent.session
#sudo mkdir /media

########################################################
# Others #
########################################################
# Open Rtorrent ports
sudo iptables -A INPUT -p tcp --destination-port 6881:6889 -j ACCEPT
sudo iptables -A OUTPUT -p tcp --source-port 6881:6889 -j ACCEPT

# Setup better discord
#betterdiscordctl install --global-asar -b /usr/lib/betterdiscord-rauenzi-git/

curl https://raw.githubusercontent.com/mina86/urxvt-tabbedex/master/install | sudo sh

########################################################
# ZSH #
########################################################
sudo pacman -S zsh

git clone --recursive https://gitlab.com/simplysublime/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

zsh -c 'setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done'

chsh -s /bin/zsh
#tk
#redshift
#shantz-xwinwrap-bzr

# ctag support for nvim
#git clone https://github.com/universal-ctags/ctags.git
#cd ctags
#./autogen.sh
#./configure
#make
#sudo make installxarchiver
#slic3r-bin
syncthing
#qsyncthingtray
#pac xfce4-panel xfce4-cpufreq-plugin xfce4-cpugraph-plugin xfce4-netload-plugin xfce4-pulseaudio-plugin
#gtk2-perl obmenu-generator
#preload
#sudo systemctl enable preload

openbox obmenu-generator gtk2-perl docky
aur compton-tryone-git
aur spotify
aur pycharm-professional
otf-fira-code-git
wicd-gtk
aur xcalib
aur ipscan
blueman
sublime-text-dev
visual-studio-code-bin
sqlitebrowser
postman-bin
syncthing-gtk
