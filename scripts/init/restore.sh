#!/bin/bash

# __       _     _           
#/ _\_   _| |__ | |__  _   _ 
#\ \| | | | '_ \| '_ \| | | |
#_\ \ |_| | |_) | |_) | |_| |
#\__/\__,_|_.__/|_.__/ \__, |
#                      |___/ 


mkdir -p ~/.local/share
cp -r ~/git/homebase/config/home/. ~/
cp -r ~/git/homebase/config/.config/ ~/
sudo cp -r ~/git/homebase/config/etc/* /etc/
echo Restore Complete
