#!/bin/sh

# use "natural" scrolling
xinput set-button-map 10 1 2 3 5 4 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24

# remap capslock to ctrl
setxkbmap -option ctrl:nocaps

# start user-level systemd
systemd --user &

# initialize X resources
[ -f "$HOME/.Xresources" ] && xrdb -merge "$HOME/.Xresources"

# launch window manager
exec awesome
