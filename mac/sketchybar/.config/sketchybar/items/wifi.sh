#!/bin/sh

wifi=(
  script="$PLUGIN_DIR/wifi.sh"
  update_freq=30
  icon=􀙇
  icon.color=$BLUE
)

sketchybar --add item wifi right \
           --set wifi "${wifi[@]}" \
           --subscribe wifi wifi_change system_woke
