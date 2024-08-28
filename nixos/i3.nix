{config, pkgs, ...}: {
	imports = [ ./sugar-candy-sddm.nix ];

<<<<<<< HEAD
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
					dmenu
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
