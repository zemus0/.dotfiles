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
            wal -R -n
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

wal --backend wal --cols16 --saturate 0.4 -i $wallpaper_png -n

# using /mmhobi7/xwinwrap/
if [ "$is_vidya" = true ] ; then
    video_resolution=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "$input")
    launch_cmd="xwinwrap -ov -ni -nf -st -sp -b -un -g $video_resolution+$xoffset-$yoffset -- mpv -wid WID \"$input\" --no-config --no-osc --no-osd-bar --no-audio --loop-file --hwdec=auto-safe --panscan=1.0 --no-input-default-bindings"
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
pywalfox update
pywal-discord -t custom

# CHANGE DUNST
#        -lf/nf/cf color
#            Defines the foreground color for low, normal and critical notifications respectively.
# 
#        -lb/nb/cb color
#            Defines the background color for low, normal and critical notifications respectively.
# 
#        -lfr/nfr/cfr color
#            Defines the frame color for low, normal and critical notifications respectively.

[ -f "$HOME/.cache/wal/colors.sh" ] && . "$HOME/.cache/wal/colors.sh"

lf=$color0
lb=$color7
lfr=$color4
nf=$color0
nb=$color3
nfr=$color12
# cf=$color7
# cb=$color4
# cfr=$color4


pidof dunst && killall dunst

sed -i "/\[urgency_low\]/,/^\[/ s/background =.*/background = \"$lb\"/" "$HOME/.dotfiles/config/dunst/dunstrc"
sed -i "/\[urgency_low\]/,/^\[/ s/foreground =.*/foreground = \"$lf\"/" "$HOME/.dotfiles/config/dunst/dunstrc"
sed -i "/\[urgency_low\]/,/^\[/ s/frame_color =.*/frame_color = \"$lfr\"/" "$HOME/.dotfiles/config/dunst/dunstrc"

sed -i "/\[urgency_normal\]/,/^\[/ s/background =.*/background = \"$nb\"/" "$HOME/.dotfiles/config/dunst/dunstrc"
sed -i "/\[urgency_normal\]/,/^\[/ s/foreground =.*/foreground = \"$nf\"/" "$HOME/.dotfiles/config/dunst/dunstrc"
sed -i "/\[urgency_normal\]/,/^\[/ s/frame_color =.*/frame_color = \"$nfr\"/" "$HOME/.dotfiles/config/dunst/dunstrc"

# sed -i "/\[urgency_critical\]/,/^\[/ s/background =.*/background = \"$cb\"/" "$HOME/.dotfiles/config/dunstrc"
# sed -i "/\[urgency_critical\]/,/^\[/ s/foreground =.*/foreground = \"$cf\"/" "$HOME/.dotfiles/config/dunstrc"

dunst &
