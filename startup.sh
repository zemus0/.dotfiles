#!/usr/bin/env bash
# don't need to remap with this keyboard (it have hardware key assignment)

#xbindkeys &
#xkbset m &
#xset -r 66 &
#xset -dpms;xset s off

picom -b
xrandr --output HDMI-0 --mode 3440x1440 --rate 100
~/.dotfiles/scripts/path/change-wallpaper.sh -R
electron-mail
dunst
