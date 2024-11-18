{config, pkgs, ...}: {
	virtualisation.libvirtd = {
		enable = true;
		hooks.qemu = {
			cpupinning = /home/me/.dotfiles/qemu/qemu.hooks;
		};
	};
}
