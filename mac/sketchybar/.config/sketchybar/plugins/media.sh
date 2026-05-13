#!/bin/bash

source "$CONFIG_DIR/colors.sh"

NOWPLAYING="/opt/homebrew/bin/nowplaying-cli"

update() {
  TITLE=$("$NOWPLAYING" get title 2>/dev/null)
  ARTIST=$("$NOWPLAYING" get artist 2>/dev/null)
  RATE=$("$NOWPLAYING" get playbackRate 2>/dev/null)

  if [ -z "$TITLE" ] || [ "$TITLE" = "null" ]; then
    sketchybar --set media drawing=off
  else
    if [ -n "$ARTIST" ] && [ "$ARTIST" != "null" ]; then
      FULL="$TITLE — $ARTIST"
    else
      FULL="$TITLE"
    fi

    if [ "$RATE" = "1" ]; then
      ICON_COLOR=$GREEN
    else
      ICON_COLOR=$GREY
    fi

    sketchybar --set media drawing=on icon.color=$ICON_COLOR \
                                      label.color=$ICON_COLOR \
                                      label="$FULL" \
               --set media.full label="$FULL"
  fi
}

case "$SENDER" in
  "mouse.clicked")
    case "$BUTTON" in
      "right")  "$NOWPLAYING" next ;;
      "middle") "$NOWPLAYING" previous ;;
      *)        "$NOWPLAYING" togglePlayPause ;;
    esac
    update
    ;;
  "mouse.entered")
    sketchybar --set media popup.drawing=on
    ;;
  "mouse.exited")
    sketchybar --set media popup.drawing=off
    ;;
  *) update ;;
esac
