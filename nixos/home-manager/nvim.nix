{config, pkgs, ...}: {
	home.packages = with pkgs; [
		neovim
		xclip

		fzf
		ripgrep

		lua-language-server

		gcc
		python3
		nodejs
	];
}
