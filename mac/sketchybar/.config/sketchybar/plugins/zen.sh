#!/bin/bash

# Zen mode — скрывает всё кроме часов при клике на время
# Добавь/убери элементы по вкусу

zen_on() {
  sketchybar --set apple.logo  drawing=off \
             --set front_app   drawing=off \
             --set weather     drawing=off \
             --set wifi        drawing=off \
             --set volume      drawing=off \
             --set battery     drawing=off \
             --set input_source drawing=off \
             --set calendar    icon.drawing=off
}

zen_off() {
  sketchybar --set apple.logo  drawing=on \
             --set front_app   drawing=on \
             --set weather     drawing=on \
             --set wifi        drawing=on \
             --set volume      drawing=on \
             --set battery     drawing=on \
             --set input_source drawing=on \
             --set calendar    icon.drawing=on
}

if [ "$1" = "on" ]; then
  zen_on
elif [ "$1" = "off" ]; then
  zen_off
else
  if [ "$(sketchybar --query apple.logo | jq -r ".geometry.drawing")" = "on" ]; then
    zen_on
  else
    zen_off
  fi
fi
