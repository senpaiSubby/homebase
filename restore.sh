#!/bin/bash

mkdir -p ~/.local/share
cp -r ~/git/homebase/config/home/. ~/
cp -r ~/git/homebase/config/.config/ ~/
sudo cp -r ~/git/homebase/config/etc/* /etc/
echo Restore Complete
