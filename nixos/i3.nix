{config, pkgs, ...}: {
    imports = [ ./sugar-candy-sddm.nix ];

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
                    dunst
                    brightnessctl
                ];
            };
        };
    };
}
