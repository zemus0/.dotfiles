{ config, pkgs, ... }: {
	imports = [
		./zsh.nix
		./nvim.nix
		./firefox.nix
		./virtmanager.nix
	];

	# Home Manager needs a bit of information about you and the paths it should
	# manage.
	home.username = "me";
	home.homeDirectory = "/home/me";

	# This value determines the Home Manager release that your configuration is
	# compatible with. This helps avoid breakage when a new Home Manager release
	# introduces backwards incompatible changes.
	#
	# You should not change this value, even if you update Home Manager. If you do
	# want to update the value, then make sure to first check the Home Manager
	# release notes.
	home.stateVersion = "24.05"; # Please read the comment before changing.

	home.packages = with pkgs;[
		# development
		tmux
		man-pages
		man-pages-posix
		sshfs

		# media
		yt-dlp
		mediainfo
		imagemagick
		zathura
		gimp
		blender

		# internet
		ungoogled-chromium
		librewolf
		vesktop
		nix-search-cli
		
		# general
		xdg-user-dirs
		fastfetch
		htop
		p7zip
		keepassxc
		xdragon
	];

	# Home Manager is pretty good at managing dotfiles. The primary way to manage
	# plain files is through 'home.file'.
	home.file = {
		# # Building this configuration will create a copy of 'dotfiles/screenrc' in
		# # the Nix store. Activating the configuration will then make '~/.screenrc' a
		# # symlink to the Nix store copy.
		# ".screenrc".source = dotfiles/screenrc;

		# # You can also set the file content immediately.
		# ".gradle/gradle.properties".text = ''
		# org.gradle.console=verbose
		# org.gradle.daemon.idletimeout=3600000
		# '';
	};

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
