#!/bin/bash

# Simple ASUS Fan Profile Cycling Script with Font Awesome/Nerd Font Icons
# Cycles through Quiet, Balanced, and Performance profiles
# Uses swayosd to display fan profile changes with custom icons

# Check if asusctl is installed
if ! command -v asusctl &>/dev/null; then
  notify-send "ASUS Fan Control" "asusctl is not installed" -i dialog-error
  exit 1
fi

# Get current profile
CURRENT=$(asusctl profile --profile-get 2>/dev/null)
if [[ "$CURRENT" =~ Active\ profile\ is\ ([A-Za-z]+) ]]; then
  CURRENT_PROFILE="${BASH_REMATCH[1]}"
else
  CURRENT_PROFILE="Unknown"
fi

# Font Awesome / Nerd Font icons for fan profiles
# You can replace these with any icons you prefer
QUIET_ICON="󰜗"       # Snowflake icon (for cool/quiet)
BALANCED_ICON="󰈐"    # Fan icon (for balanced)
PERFORMANCE_ICON="󰈸" # Fire icon (for performance/hot)

# Cycle to next profile
case "$CURRENT_PROFILE" in
"Quiet")
  NEW_PROFILE="Balanced"
  DISPLAY_ICON="$BALANCED_ICON"
  ;;
"Balanced")
  NEW_PROFILE="Performance"
  DISPLAY_ICON="$PERFORMANCE_ICON"
  ;;
*)
  # Default to Quiet for any other profile
  NEW_PROFILE="Quiet"
  DISPLAY_ICON="$QUIET_ICON"
  ;;
esac

# Set the new profile
asusctl profile --profile-set "$NEW_PROFILE"

# Show notification using standard notify-send with the icon in the title
# Adding the icon to the title ensures it displays even if the notification system doesn't support custom icons
notify-send "$DISPLAY_ICON ASUS Fan Control" "Switched to $NEW_PROFILE profile" -i "preferences-system-power"
echo "Fan profile changed to: $NEW_PROFILE with icon $DISPLAY_ICON"
