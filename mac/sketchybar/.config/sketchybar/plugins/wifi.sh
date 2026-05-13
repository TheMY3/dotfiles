#!/bin/sh

source "$CONFIG_DIR/colors.sh"

SSID=$(networksetup -getairportnetwork en0 2>/dev/null | sed 's/Current Wi-Fi Network: //')

if [ -z "$SSID" ] || [ "$SSID" = "You are not associated with an AirPort network." ]; then
  sketchybar --set wifi label="Off" icon.color=$RED
else
  sketchybar --set wifi label="$SSID" icon.color=$BLUE
fi
