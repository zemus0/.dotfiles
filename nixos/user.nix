{config, pkgs, ...}: {
  imports = [ ./zsh.nix ];

  users.users.me = {
    initialPassword = "1234";
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
      fastfetch
      git
      vesktop
      keepassxc
      tmux
    ];
  };
}
