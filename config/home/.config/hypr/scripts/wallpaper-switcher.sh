#!/bin/bash

# Wallpaper cycling script for Hyprland with hyprpaper
# Place this in ~/.config/hypr/scripts/wallpaper-switcher.sh

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"

# File to store the current wallpaper index
INDEX_FILE="$HOME/.config/hypr/.current_wallpaper"

# Get the monitor name
MONITOR=$(hyprctl monitors -j | jq -r '.[0].name')

# Count total wallpapers (assuming they're named 1.jpg, 2.jpg, etc.)
TOTAL_WALLPAPERS=$(find "$WALLPAPER_DIR" -name "[0-9]*.jpg" | wc -l)

# If no wallpapers found, exit
if [ "$TOTAL_WALLPAPERS" -eq 0 ]; then
  echo "No sequentially numbered wallpapers found in $WALLPAPER_DIR"
  exit 1
fi

# Read the current index
if [ -f "$INDEX_FILE" ]; then
  CURRENT_INDEX=$(cat "$INDEX_FILE")
else
  # Start with index 1 if file doesn't exist
  CURRENT_INDEX=1
  echo "$CURRENT_INDEX" >"$INDEX_FILE"
fi

# Calculate next index with wraparound
NEXT_INDEX=$((CURRENT_INDEX + 1))
if [ "$NEXT_INDEX" -gt "$TOTAL_WALLPAPERS" ]; then
  NEXT_INDEX=1
fi

# Save the new index
echo "$NEXT_INDEX" >"$INDEX_FILE"

# Get the next wallpaper
WALLPAPER="$WALLPAPER_DIR/$NEXT_INDEX.jpg"

# Check if the wallpaper exists
if [ ! -f "$WALLPAPER" ]; then
  echo "Wallpaper $WALLPAPER not found, resetting to 1.jpg"
  NEXT_INDEX=1
  echo "$NEXT_INDEX" >"$INDEX_FILE"
  WALLPAPER="$WALLPAPER_DIR/$NEXT_INDEX.jpg"

  # If still not found, exit
  if [ ! -f "$WALLPAPER" ]; then
    echo "Wallpaper $WALLPAPER not found. Exiting."
    exit 1
  fi
fi

# Update hyprpaper.conf to preload the new wallpaper
sed -i "s|preload = .*|preload = $WALLPAPER|" "$HOME/.config/hypr/hyprpaper.conf"
sed -i "s|wallpaper = $MONITOR,.*|wallpaper = $MONITOR,$WALLPAPER|" "$HOME/.config/hypr/hyprpaper.conf"

# Reload hyprpaper (if needed)
# Alternatively, you can use the IPC socket for a smoother transition
killall hyprpaper
hyprpaper &

echo "Wallpaper changed to: $WALLPAPER (index: $NEXT_INDEX of $TOTAL_WALLPAPERS)"
