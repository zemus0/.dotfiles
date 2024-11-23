let
	gpuIDs = [
		"10de:1f08"
		"10de:10f9"
		"10de:1ada"
		"10de:1adb"
	];
in { config, lib, pkgs, ... }: {
	boot = {
		initrd.kernelModules = [
			"vfio_pci"
			"vfio"
			"vfio_iommu_type1"

			"nvidia"
			"nvidia_modeset"
			"nvidia_uvm"
			"nvidia_drm"
		];

		kernelParams = [
			# enable IOMMU
			"amd_iommu=on"
			("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs)
		];
	};

	services.xserver.videoDrivers = ["nvidia"];
	hardware.graphics = {
		enable = true;
		enable32Bit = true;
	};
	virtualisation = {
		spiceUSBRedirection.enable = true;
		libvirtd = {
			enable = true;
			hooks.qemu = {
				cpupinning = /home/zem/.dotfiles/qemu/qemu.hooks;
			};
		};
	};
	hardware.nvidia = {
		open = false;
		nvidiaSettings = true;
		# Optionally, you may need to select the appropriate driver version for your specific GPU.
		package = config.boot.kernelPackages.nvidiaPackages.stable;
	};
}
