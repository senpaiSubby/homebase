#xinput set-button-map 11 1 2 3 5 4 6 7
#xinput set-button-map 11 1 2 3 4 5 6 7

/usr/bin/xcalib -d :0 ~/git/homebase/config/MonitorProfiles/laptop.icm

#exec openbox
exec bspwm 
