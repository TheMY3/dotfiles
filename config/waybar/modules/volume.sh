#!/bin/sh
set -eu
# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

# icons
audio_icon_high="audio-volume-high-symbolic.symbolic"
audio_icon_medium="audio-volume-medium-symbolic.symbolic"
audio_icon_low="audio-volume-low-symbolic.symbolic"
mute_icon="audio-volume-muted-symbolic.symbolic"

get_volume () {
    pamixer --get-volume
}

is_mute () {
    pamixer --get-mute | grep -q "true"
}

send_notification () {
    # Send the notification
    dunstify -i "$audio_icon" -t 1600 -h string:x-dunst-stack-tag:volume -u normal "Volume" -h int:value:"$(get_volume)"
}

if [ "$(get_volume)" -ge 70 ]; then
    audio_icon="$audio_icon_high"
elif [ "$(get_volume)" -ge 50 ]; then
    audio_icon="$audio_icon_medium"
else
    audio_icon="$audio_icon_low"
fi

case $1 in
    up)
  if [ "$(get_volume)" -lt 100 ]; then
      pactl set-sink-volume @DEFAULT_SINK@ +5%
  fi
	send_notification
	;;
    down)
	pactl set-sink-volume @DEFAULT_SINK@ -5%
	send_notification
	;;
    mute)
	pactl set-sink-mute @DEFAULT_SINK@ toggle
	if is_mute ; then
	    dunstify -i "$mute_icon" -t 1600 -h string:x-dunst-stack-tag:volume -u normal "Mute"
	else
	    send_notification
	fi
	;;
esac
