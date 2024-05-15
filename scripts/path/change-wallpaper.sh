#!/usr/bin/env bash
cached_command_path="$HOME/.cache/wal/apply_wallpaper.sh"
launch_cmd=""
input=""
wallpaper_png=""
xoffset="0"
yoffset="0"

args=($@)
for ((i=0; i <= ${#args[@]}; i++)); do
    case ${args[i]} in
        "-R")
            xrdb ~/.cache/wallust/colors.Xresources
            test -f $cached_command_path && exec $cached_command_path &
            exit
        ;;
        "-x")
            xoffset="${args[i+1]}"
        ;;
        "-y")
            yoffset="${args[i+1]}"
        ;;
        "-i")
            input="$(realpath "${args[i+1]}")"
            wallpaper_png="$input"
        ;;
        "-h" | "--help")
            echo "-h, --help    Send this help message"
            echo "-R            Restore last session's wallpaper and colorscheme"
            echo "-x            move the image x pixel to the left" 
            echo "-y            move the image y pixel down" 
            echo "-i            Path to wallpaper file, png or mp4"
            echo "              If this flag is absent then the last agrument"
            echo "              must be the path to a wallpaper file"
            exit
        ;;

    esac
done

if [ -z "$input" ]; then
    input="$(realpath ${args[-1]})"
    wallpaper_png="$input"
    if [ ! -f "$input" ] ;then
        echo "File does not exist" >&2
        exit
    fi
fi

is_vidya=false
if ffprobe "$input" -hide_banner -loglevel panic -select_streams v:0 -show_entries stream=codec_name | grep -q "h264" ; then
    wallpaper_png="/tmp/extracted_frame.png"
    ffmpeg -i "$input" -vf crop=in_w+$xoffset:in_h-$yoffset:$xoffset:$yoffset -vframes 1 -y "$wallpaper_png" &> /dev/null
    is_vidya=true
fi

wallust run $wallpaper_png

if [ "$is_vidya" = true ] ; then
    video_resolution=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "$input")
    launch_cmd="xwinwrap -ov -ni -nf -st -sp -b -g $video_resolution+$xoffset-$yoffset -- mpv -wid WID \"$input\" --no-config --no-osc --no-osd-bar --no-audio --loop-file --hwdec=auto-safe --panscan=1.0 --no-input-default-bindings"
else
    launch_cmd="feh --no-fehbg --bg-fill -g +$xoffset-$yoffset \"$input\""
fi

if test -f "$cached_command_path"; then
    cmd="$(cat "$cached_command_path" | tr -d '"')"
    id=$(pgrep -a xwinwrap | grep "$cmd" | cut -d' ' -f1)
    [ ! -z "$id" ] && kill $id && sleep 1
fi
echo "$launch_cmd" > "$cached_command_path"
chmod +x "$cached_command_path"
exec $cached_command_path &

cp -- $wallpaper_png /usr/share/wallpapers/wal

pidof dunst && killall dunst
cat ~/.dotfiles/config/dunst/dunstrc ~/.cache/wallust/dunst-color | dunst -conf - &
