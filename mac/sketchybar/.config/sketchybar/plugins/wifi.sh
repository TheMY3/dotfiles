#!/bin/sh

source "$CONFIG_DIR/colors.sh"

# macOS 15+: `networksetup -getairportnetwork` always reports "not associated",
# so read link state and SSID from ipconfig. The SSID is shown as <redacted>
# unless `sudo ipconfig setverbose 1` has been run once.
SUMMARY=$(ipconfig getsummary en0 2>/dev/null)
ACTIVE=$(echo "$SUMMARY" | awk -F ' : ' '/ LinkStatusActive /{print $2; exit}')
SSID=$(echo "$SUMMARY" | awk -F ' : ' '/ SSID /{print $2; exit}')

if [ "$ACTIVE" != "TRUE" ]; then
  sketchybar --set wifi label="Off" icon.color=$RED
elif [ -z "$SSID" ] || [ "$SSID" = "<redacted>" ]; then
  sketchybar --set wifi label="On" icon.color=$BLUE
else
  sketchybar --set wifi label="$SSID" icon.color=$BLUE
fi
