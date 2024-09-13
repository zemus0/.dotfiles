let
	zshrc = builtins.readFile ~/.dotfiles/zsh/zshrc; 
in
{ config, pkgs, lib, ... }: {
	programs.zsh = {
		enable = true;
		defaultKeymap = "viins";
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
				"joshskidmore/zsh-fzf-history-search"
				"Aloxaf/fzf-tab"
			];
		};
		initExtraBeforeCompInit = "zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'";
		initExtra = lib.strings.concatStrings[
			zshrc
			"\nsource ~/.dotfiles/zsh/p10k.zsh"
			"\n"
			''export NIX_LD=$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD ')''
		];
	};
	home.packages = with pkgs;[
		fzf
	];
}
