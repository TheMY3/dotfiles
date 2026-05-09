#!/bin/bash
# Screenshot: save + clipboard + notify
# Usage: screenshot-notify.sh [--area]

DIR=~/Pictures/Screenshots
mkdir -p "$DIR"
FILE="$DIR/$(date +%Y%m%d_%H%M%S).png"

if [[ "$1" == "--area" ]]; then
    grim -g "$(slurp)" - | tee "$FILE" | wl-copy
else
    grim - | tee "$FILE" | wl-copy
fi

if [[ -f "$FILE" ]]; then
    notify-send "Screenshot" "Saved: $FILE\nCopied to clipboard" -i "$FILE" -t 3000
fi
