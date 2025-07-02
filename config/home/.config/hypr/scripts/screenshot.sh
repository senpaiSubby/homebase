#!/bin/bash

# Simple screenshot menu using wofi for Hyprland
# Dependencies: wofi, grim, slurp, swappy, jq, libnotify

# Create screenshots directory
mkdir -p "$HOME/Pictures/Screenshots"

OPTIONS="📱 Fullscreen\n🖱️ Selection\n🪟 Window\n📝 Fullscreen + Edit\n✏️ Selection + Edit\n🖼️ Window + Edit"

SELECTED=$(echo -e $OPTIONS | wofi --dmenu --width 280 --height 300 --cache-file /dev/null --prompt "Screenshot" --style ~/.config/wofi/style.css)

# Generate filename with timestamp
FILENAME="screenshot_$(date +%Y%m%d_%H%M%S).png"
FILEPATH="$HOME/Pictures/Screenshots/$FILENAME"

case $SELECTED in
"📱 Fullscreen")
  grim "$FILEPATH"
  notify-send "Screenshot" "Fullscreen saved to $FILENAME" -i "$FILEPATH"
  ;;
"🖱️ Selection")
  grim -g "$(slurp)" "$FILEPATH"
  if [ $? -eq 0 ]; then
    notify-send "Screenshot" "Selection saved to $FILENAME" -i "$FILEPATH"
  fi
  ;;
"🪟 Window")
  WINDOW_INFO=$(hyprctl activewindow -j)
  if [ "$(echo "$WINDOW_INFO" | jq -r '.address')" = "0x0" ]; then
    notify-send "Screenshot" "No active window found" -u critical
    exit 1
  fi

  X=$(echo "$WINDOW_INFO" | jq -r '.at[0]')
  Y=$(echo "$WINDOW_INFO" | jq -r '.at[1]')
  W=$(echo "$WINDOW_INFO" | jq -r '.size[0]')
  H=$(echo "$WINDOW_INFO" | jq -r '.size[1]')

  grim -g "${X},${Y} ${W}x${H}" "$FILEPATH"
  notify-send "Screenshot" "Window saved to $FILENAME" -i "$FILEPATH"
  ;;
"📝 Fullscreen + Edit")
  grim - | swappy -f -
  ;;
"✏️ Selection + Edit")
  grim -g "$(slurp)" - | swappy -f -
  ;;
"🖼️ Window + Edit")
  WINDOW_INFO=$(hyprctl activewindow -j)
  if [ "$(echo "$WINDOW_INFO" | jq -r '.address')" = "0x0" ]; then
    notify-send "Screenshot" "No active window found" -u critical
    exit 1
  fi

  X=$(echo "$WINDOW_INFO" | jq -r '.at[0]')
  Y=$(echo "$WINDOW_INFO" | jq -r '.at[1]')
  W=$(echo "$WINDOW_INFO" | jq -r '.size[0]')
  H=$(echo "$WINDOW_INFO" | jq -r '.size[1]')

  grim -g "${X},${Y} ${W}x${H}" - | swappy -f -
  ;;
esac
