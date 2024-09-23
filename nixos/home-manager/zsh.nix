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
			historySubstringSearch.enable = true;
			syntaxHighlighting.enable = true;
			antidote = {
				enable = true;
				plugins = [
					"romkatv/powerlevel10k"
					"jeffreytse/zsh-vi-mode"
					"oz/safe-paste"
				];
			};
			initExtra = lib.strings.concatStrings[
				zshrc
				"\nsource ~/.dotfiles/zsh/p10k.zsh"
			];
		};
		initExtraBeforeCompInit = "zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'";
		initExtra = lib.strings.concatStrings[
			zshrc
			"\nsource ~/.dotfiles/zsh/p10k.zsh"
		];
	};
	home.packages = with pkgs;[
		fzf
	];
}
