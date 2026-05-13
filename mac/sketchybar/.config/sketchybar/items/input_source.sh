#!/bin/sh

sketchybar --add item input_source right
sketchybar --set input_source \
    label.font="$FONT:Bold:13.0" \
    label.color=0xffffffff \
    icon.drawing=off \
    script="$PLUGIN_DIR/get_input_source.sh" \
    update_freq=2


