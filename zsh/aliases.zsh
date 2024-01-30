alias incognito='firefox -private-window '
alias ls='ls --color=auto '
alias rm='rm -I '
alias pyvenv='python -m venv .venv '
alias srcvenv='source .venv/bin/activate '
alias pacinstall='sudo pacman -S '
alias pacuninstall='sudo pacman -Rns '
alias sysupdate='yay -Syu '
alias nv='nvim '
alias lsdir='du -hcs '
alias waifu2x='mkdir -p /tmp/upscaled && waifu2x-ncnn-vulkan -v -i frames/ -o /tmp/upscaled/ -m ~/Programs/waifu2x-ncnn-vulkan/models/models-upconv_7_anime_style_art_rgb -n 3 -s 2'
alias bk='popd '
alias gitcm='git commit -m'
alias gita='git add'
alias gitamend='git commit --amend'
alias gitfa='git fetch --all'
alias gitco='git checkout'
alias gitb='git branch'
alias chromito='chromium --incognito '
alias crun='RUST_BACKTRACE=1 cargo run '
alias hibernate='systemctl hibernate '
alias susspend='systemctl suspend '
alias tmux='tmux attach || tmux new -As0'
# need this for godot to run with dmenu
alias godot='godot 2> /dev/null'
alias archive='ytarchive --no-frag-files -w --add-metadata -t -o "/archives/%(channel)s/%(upload_date)s_%(title)s"'
alias runelite='bolt'
# alias wal='wal --saturate 0.4 -o $HOME/.dotfiles/scripts/change_dunst_color.sh'

function ssht () {
    /usr/bin/ssh -t "$@" "tmux attach || tmux new";
}
function identify-key () {
    xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}
