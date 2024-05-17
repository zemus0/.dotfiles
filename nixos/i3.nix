{config, pkgs, ...}: {
    imports = [ ./sugar-candy-sddm.nix ];

    systemd.tmpfiles.rules = [
        "d /usr/share/wallpapers - root root"
        "f /usr/share/wallpapers/wal 0766 root root"
    ];

    services = { 
        displayManager.sddm = {
            enable = true;
            autoNumlock = true;
        };
        xserver = {
            enable = true;
            excludePackages = [pkgs.xterm];
            windowManager.i3 = {
                enable = true;
                extraPackages = with pkgs; [ 
                    fzf
                    alacritty
                    i3status-rust
                    picom
                    xwinwrap
                    wallust
                    ffmpeg
                    mpv
                    feh
                ];
            };
        };
    };
}
