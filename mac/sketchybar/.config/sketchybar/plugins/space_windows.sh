#!/usr/bin/env bash
 

source "$CONFIG_DIR/colors.sh"


reload_workspace_icon() {
  # echo reload_workspace_icon "$@" >> ~/aaaa
  apps=$(aerospace list-windows --workspace "$@" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

  icon_strip=" "
  if [ "${apps}" != "" ]; then
    while read -r app
    do
      icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
    done <<< "${apps}"
  else
    icon_strip=" —"
  fi

  sketchybar --animate sin 10 --set space.$@ label="$icon_strip"
}

if [ "$SENDER" = "aerospace_workspace_change" ]; then

  # if [ $i = "$FOCUSED_WORKSPACE" ]; then
  #   sketchybar --set space.$FOCUSED_WORKSPACE background.drawing=on
  # else
  #   sketchybar --set space.$FOCUSED_WORKSPACE background.drawing=off
  # fi
  #echo 'space_windows_change: '$AEROSPACE_FOCUSED_WORKSPACE >> ~/aaaa
  #echo space: $space >> ~/aaaa
  #space="$(echo "$INFO" | jq -r '.space')"
  #apps="$(echo "$INFO" | jq -r '.apps | keys[]')"
  # apps=$(aerospace list-windows --workspace $AEROSPACE_FOCUSED_WORKSPACE | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
  #
  # icon_strip=" "
  # if [ "${apps}" != "" ]; then
  #   while read -r app
  #   do
  #     icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
  #   done <<< "${apps}"
  # else
  #   icon_strip=" —"
  # fi

  reload_workspace_icon "$AEROSPACE_PREV_WORKSPACE"
  reload_workspace_icon "$AEROSPACE_FOCUSED_WORKSPACE"

  # Focused — всегда показываем и подсвечиваем
  sketchybar --set space.$AEROSPACE_FOCUSED_WORKSPACE drawing=on \
                         icon.highlight=true \
                         label.highlight=true \
                         background.border_color=$GREY

  # Prev — скрываем если пустой
  PREV_APPS=$(aerospace list-windows --workspace "$AEROSPACE_PREV_WORKSPACE" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$PREV_APPS" -eq 0 ]; then
    sketchybar --set space.$AEROSPACE_PREV_WORKSPACE drawing=off
  else
    sketchybar --set space.$AEROSPACE_PREV_WORKSPACE drawing=on \
                           icon.highlight=false \
                           label.highlight=false \
                           background.border_color=$BACKGROUND_2
  fi

  # if [ "$AEROSPACE_FOCUSED_WORKSPACE" -gt 3 ]; then
  #   sketchybar --animate sin 10 --set space.$AEROSPACE_FOCUSED_WORKSPACE display=1
  # fi

fi
