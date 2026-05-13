#!/bin/sh

plist_data=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources)
current_input_source=$(echo "$plist_data" | plutil -convert xml1 -o - - | grep -A1 'KeyboardLayout Name' | tail -n1 | cut -d '>' -f2 | cut -d '<' -f1)

case "$current_input_source" in
  "ABC" | "U.S." | "British" | "Australian")
    sketchybar --set input_source label="EN"
    ;;
  "RussianWin" | "Russian" | "Russian - PC")
    sketchybar --set input_source label="RU"
    ;;
  "Ukrainian" | "Ukrainian-PC" | "Ukrainian QWERTY")
    sketchybar --set input_source label="UA"
    ;;
  *)
    # Fallback: first 2 chars of layout name
    sketchybar --set input_source label="${current_input_source:0:2}"
    ;;
esac
