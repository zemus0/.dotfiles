#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# https://gist.github.com/aleozlx/781dd2e79661c82aa080d99e67a703b6

# ref: https://github.com/i3/i3status/blob/master/contrib/wrapper.py
#
# To use it, ensure your ~/.i3status.conf contains this line:
#     output_format = "i3bar"
# in the 'general' section.
# Then, in your ~/.i3/config, use:
#     status_command i3status | ~/i3status/contrib/wrapper.py
# In the 'bar' section.

import sys, subprocess
import json

def gpu_info():
    while True:
        # https://gist.github.com/pyaf/31e375584cb8cd3322fe0c3029914d07
        output = subprocess.getoutput('nvidia-smi --format=csv,noheader --query-gpu=name,power.draw,pstate,utilization.gpu,temperature.gpu').strip().split("\n")
        for i, info in enumerate(output):
            info = info.split(',');
            yield (f"{info[0]}:{info[1]},{info[2]},{info[3]},{info[4]}" , i)

        yield "done"

def print_line(message):
    """ Non-buffered printing to stdout. """
    sys.stdout.write(message + '\n')
    sys.stdout.flush()

def read_line():
    """ Interrupted respecting reader for stdin. """
    # try reading a line, removing any extra whitespace
    try:
        line = sys.stdin.readline().strip()
        # i3status sends EOF, or an empty line
        if not line:
            sys.exit(3)
        return line
    # exit on ctrl-c
    except KeyboardInterrupt:
        sys.exit()

if __name__ == '__main__':
    # Skip the first line which contains the version header.
    print_line(read_line())

    # The second line contains the start of the infinite array.
    print_line(read_line())

    gpu_info_gen = gpu_info()
    while True:
        line, prefix = read_line(), ''
        # ignore comma at start of lines
        if line.startswith(','):
            line, prefix = line[1:], ','

        j = json.loads(line)
        # insert information into the start of the json, but could be anywhere
        # CHANGE THIS LINE TO INSERT SOMETHING ELSE
        # changes for multiple gpu supports
        gpu = next(gpu_info_gen)
        while gpu != "done":
            j.insert(0, {
                'full_text': gpu[0].strip() + '°C',
                'name': f"gpu{gpu[1]}",
            })
            gpu = next(gpu_info_gen)

        # and echo back new encoded json
        print_line(prefix+json.dumps(j))

