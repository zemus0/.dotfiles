# Shell
AddPackage alacritty # A cross-platform, GPU-accelerated terminal emulator
AddPackage zsh # A very advanced and programmable command interpreter (shell) for UNIX
AddPackage zsh-syntax-highlighting # Fish shell like syntax highlighting for Zsh

# Wm
AddPackage xorg-server # Xorg X server
AddPackage xorg-xrandr # Primitive command line interface to RandR extension
AddPackage i3-wm # Improved dynamic tiling window manager
AddPackage i3status-rust # Resourcefriendly and feature-rich replacement for i3status, written in pure Rust
AddPackage fakeroot # Tool for simulating superuser privileges

AddPackage lightdm # A lightweight display manager
AddPackage lightdm-slick-greeter # A slick-looking LightDM greeter
CopyFile /etc/lightdm/lightdm.conf
CopyFile /etc/lightdm/slick-greeter.conf
CreateFileIfDoesntExist /usr/share/wallpapers/wal 666
SetFileProperty /usr/share/wallpapers mode 555
IgnorePath '/usr/share/wallpapers'
SystemdEnable lightdm /usr/lib/systemd/system/lightdm.service

AddPackage dunst # Customizable and lightweight notification-daemon
AddPackage feh # Fast and light imlib2-based image viewer
AddPackage ffmpeg # Complete solution to record, convert and stream audio and video
AddPackage picom # A lightweight compositor for X11
AddPackage --foreign xwinwrap-git # Fork of XwinWrap from takase1121 on GitHub
AddPackage --foreign wallust-git # generate colors from an image

# Audio
AddPackage pipewire # Low-latency audio/video router and processor
AddPackage pipewire-alsa # Low-latency audio/video router and processor - ALSA configuration
AddPackage pipewire-pulse # Low-latency audio/video router and processor - PulseAudio replacement
AddPackage wireplumber # Session / policy manager implementation for PipeWire
AddPackage pavucontrol # PulseAudio Volume Control

# Fonts
AddPackage ttf-anonymouspro-nerd # Patched font Anonymous Pro (Anonymice) from nerd fonts library
AddPackage otf-aurulent-nerd # Patched font Aurulent Sans Mono from nerd fonts library
AddPackage noto-fonts-cjk # Google Noto CJK fonts
AddPackage noto-fonts-emoji # Google Noto emoji fonts
