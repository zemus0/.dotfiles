{ config, pkgs, ... }: {
	programs.zsh = { 
		enable = true;
		enableCompletion = false;
		syntaxHighlighting.enable = true;
		zsh-autoenv.enable = true;
		ohMyZsh = {
			enable = true;
			plugins = ["branch" "vi-mode" "safe-paste" "zsh-interactive-cd"];
			theme = "robbyrussell";
		};
	};
}
