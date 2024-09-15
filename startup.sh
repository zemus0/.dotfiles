#!/usr/bin/env bash
# don't need to remap with this keyboard (it have hardware key assignment)

picom -b
~/.dotfiles/scripts/path/change-wallpaper.sh -R
xrandr --output HDMI-0 --mode 3440x1440 --rate 100
electron-mail
dunst
tmux new-session -d
