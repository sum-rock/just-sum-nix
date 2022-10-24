#!/usr/bin/env bash
DIR="$HOME/.config/polybar"
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
polybar -q main -c "$DIR"/config.ini &
# for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#   MONITOR=$m polybar --reload main &
# done
