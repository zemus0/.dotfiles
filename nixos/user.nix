{config, pkgs, ...}: {
  imports = [ ./zsh.nix ];

  users.users.zem = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
      fastfetch
    ];
  };
}
