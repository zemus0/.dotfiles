{ config, pkgs, ... }: {
	nixpkgs.config.allowUnfree = true;
	
	home.packages = with pkgs; [
		(pkgs.callPackage ./bolt-launcher.nix {})
		wineWowPackages.staging
		winetricks
		steam
		(lutris.override {
			extraLibraries =  pkgs: [
				# List library dependencies here
			];
		})
	];
}
