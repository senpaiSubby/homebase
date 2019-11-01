#[ -f ~/.config/compiz-1/autostart  ] && . ~/.config/compiz-1/autostart
#sh ~/.config/openbox/autostart &
xinput set-button-map 11 1 2 3 5 4 6 7
xinput set-button-map 11 1 2 3 4 5 6 7

#xrandr --output eDP1 --off
xrandr --output HDMI1 --mode 1920x1080 --rate 60
xrandr --output eDP1 --mode 1920x1080 --left-of HDMI1
/usr/bin/xcalib -d :0 ~/git/homebase/config/MonitorProfiles/laptop.icm

#exec openbox
#exec compiz
exec bspwm 

