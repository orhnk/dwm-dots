#!/bin/sh

xrdb merge ~/.Xresources
xbacklight -set 10 &
feh --bg-fill ~/Pictures/Hintergrundbilder/Unprocessed/fav/room.png &
xset r rate 200 50 &
picom &

~/.config/chadwm/scripts/bar.sh &
while type dwm >/dev/null; do dwm && continue || break; done
