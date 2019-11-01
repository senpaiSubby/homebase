#!/bin/bash

mkdir -p ~/.local/share
cp -r ~/git/homebase/config/home/. ~/
cp -r ~/git/homebase/config/.config/ ~/
sudo cp -r ~/git/homebase/config/etc/* /etc/
sudo cp -r ~/git/homebase/config/var/spool/cron/sublime /var/spool/cron
sudo cp -r ~/git/homebase/config/etc/default/tlp /etc/default/
sudo chown -R sublime:users /var/spool/cron/sublime
echo Restore Complete
notify-send "Restore Complete"
