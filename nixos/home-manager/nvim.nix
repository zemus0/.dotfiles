{config, pkgs, ...}: {
    home.packages = with pkgs; [
        neovim
        xclip

        fzf
        ripgrep

        lua-language-server
        texlive.combined.scheme-full
        zathura

        gcc
        python3
        nodejs

        unzip

        xdragon
    ];
}
