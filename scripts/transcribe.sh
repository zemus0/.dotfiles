#!/bin/bash
test whisper || source .venv/bin/activate

if [[ "$1" == "" ]]; then
    echo "Error no input file" >&2
    exit
fi

if [[ -f "$1" ]]; then
    dir="$(realpath "$(echo "$1" | rev | cut -f 2- -d '.' | rev)")"
    echo "Creating $dir"
    mkdir -p "$dir"
    whisper "$1" --language en --model small.en --output_dir "$dir"
else
    IFS=$'\n'
    for i in $(find $1 -name "*.mp3" -o -name "*.opus" -o -name "*.wav" -not -path "./.*"); do
        dir="$(realpath "$(echo "$i" | rev | cut -f 2- -d '.' | rev)")"
        echo "Creating $dir"
        mkdir -p "$dir"
        whisper "$i" --language en --model small.en --output_dir "$dir"
    done
fi
