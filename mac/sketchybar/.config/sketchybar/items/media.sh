#!/bin/sh

sketchybar --add event spotify_change "com.spotify.client.PlaybackStateChanged"

sketchybar --add item media right \
           --set media \
             icon=􀑪 \
             icon.color=$GREEN \
             label.max_chars=20 \
             scroll_texts=off \
             update_freq=1 \
             updates=on \
             script="$PLUGIN_DIR/media.sh" \
             popup.align=right \
           --add item media.full popup.media \
           --set media.full \
             icon.drawing=off \
             background.drawing=off \
             label.font="SF Pro:Semibold:13.0" \
           --subscribe media mouse.clicked mouse.entered mouse.exited spotify_change
