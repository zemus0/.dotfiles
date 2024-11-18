{config, pkgs, ...}: {
	virtualisation.libvirtd = {
		enable = true;
		hooks.qemu = {
			cpupinning = /home/zem/.dotfiles/qemu/qemu.hooks;
		};
	};
}
