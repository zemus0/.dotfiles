#!/usr/bin/env bash
worked=0

xdotool search --class "$GAME_NAME" set_window --class "lutris_app" && worked=1
while [ $worked == 0 ]; do
    xdotool search --class "$GAME_NAME" set_window --class "lutris_app" && worked=1
done
