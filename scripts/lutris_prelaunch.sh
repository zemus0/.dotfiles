#!/usr/bin/env bash

function run()
{
    worked=0

    pids="$(pgrep -f "$PWD")"
    while [ $worked == 0 ]; do
        if [[ -z "$pids" ]]; then
            pids="$(xdotool search --class "$GAME_NAME" getwindowpid $@)"
        fi
        for pid in ${pids[@]}
        do
            if [ "$(ps e -ww -p $pid | grep GAME_NAME)" != '' ]; then
                winid="`wmctrl -lp | awk -vpid=$pid '$3==pid {print $1; exit}'`"
                [[ -z "$winid" ]] || worked=1
            fi
        done
    done
    i3-msg floating enable > /dev/null;
}

export -f run
timeout 5s bash -c run
