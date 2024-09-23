let
	zshrc = builtins.readFile ~/.dotfiles/zsh/zshrc; 
in
{ config, pkgs, lib, ... }: {
	programs = {
		direnv = {
			enable = true;
			enableZshIntegration = true;
			nix-direnv.enable = true;
		};

		zsh = {
			enable = true;
			autocd = true;
			history = {
				append = true;
				extended = true;
				save = 100000;
				ignoreDups = true;
				expireDuplicatesFirst = true;
			};

			syntaxHighlighting.enable = true;
			oh-my-zsh = {
				enable = true;
				plugins = [
					"branch"
					"vi-mode"
					"safe-paste"
					"zsh-interactive-cd"
				];
				theme = "robbyrussell";
			};

			initExtra = lib.strings.concatStrings[
				zshrc
				# "\nsource ~/.dotfiles/zsh/p10k.zsh"
			];
		};
	};

	home.packages = with pkgs;[
		fzf
	];
}
