#!/bin/sh
set -eu
# You can call this script like this:
# $./brightness.sh up
# $./brightness.sh down

# icon
#brightness_icon_high="display-brightness-high-symbolic"
#brightness_icon_medium="display-brightness-medium-symbolic"
#brightness_icon_low="display-brightness-low-symbolic"

get_brightness () {
    light | grep -oE '^[0-9]+'
}
send_notification () {
	# Send the notification
    dunstify -i "$brightnessicon" -t 1600 -h string:x-dunst-stack-tag:brightness -u normal "Brightness" -h int:value:"$(get_brightness)"
}

brightnessicon="display-brightness-symbolic.symbolic"
#if [ "$(get_brightness)" -ge 70 ]; then
#    brightnessicon="$brightness_icon_high"
#elif [ "$(get_brightness)" -ge 50 ]; then
#    brightnessicon="$brightness_icon_medium"
#else
#    brightnessicon="$brightness_icon_low"
#fi

case $1 in
    up)
        light -A 10 > /dev/null
        send_notification
        ;;
    down)
        light -U 10 > /dev/null
        send_notification
        ;;
esac
