#!/bin/bash

# Simple power menu using wofi for Hyprland
# Dependencies: wofi, swaylock, systemd

OPTIONS="󰌾 Lock\n󰒲 Suspend\n󰍃 Logout\n󰑙 Reboot\n⏻ Shutdown"

SELECTED=$(echo -e $OPTIONS | wofi --dmenu --width 250 --height 260 --cache-file /dev/null --prompt "Power Menu" --style ~/.config/wofi/style.css)

case $SELECTED in
"󰌾 Lock")
  swaylock \
    --screenshots \
    --clock \
    --indicator \
    --indicator-radius 100 \
    --indicator-thickness 7 \
    --effect-blur 7x5 \
    --effect-vignette 0.5:0.5 \
    --ring-color 89b4faff \
    --key-hl-color f38ba8ff \
    --line-color 00000000 \
    --inside-color 1e1e2e88 \
    --separator-color 00000000 \
    --text-color cdd6f4ff \
    --text-ver-color cdd6f4ff \
    --text-wrong-color f38ba8ff \
    --text-clear-color f9e2afff \
    --inside-ver-color 89b4fa88 \
    --inside-wrong-color f38ba888 \
    --inside-clear-color f9e2af88 \
    --ring-ver-color 89b4faff \
    --ring-wrong-color f38ba8ff \
    --ring-clear-color f9e2afff \
    --fade-in 0.2 \
    -f
  ;;
"󰒲 Suspend")
  systemctl suspend
  ;;
"󰍃 Logout")
  hyprctl dispatch exit
  ;;
"󰑙 Reboot")
  systemctl reboot
  ;;
"⏻ Shutdown")
  systemctl poweroff
  ;;
esac
