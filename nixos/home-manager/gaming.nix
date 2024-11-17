{ config, pkgs, ... }: {
	nixpkgs.config.allowUnfree = true;
	
	home.packages = with pkgs; [
		steam
		(lutris.override {
			extraLibraries =  pkgs: [
				# List library dependencies here
			];
		})
	];
}
