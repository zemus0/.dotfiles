let
	gpuIDs = [
		"10de:1f08"
		"10de:10f9"
		"10de:1ada"
		"10de:1adb"
	];
in { config, lib, pkgs, ... }: {
	systemd.tmpfiles.rules = [
		"f /dev/shm/looking-glass 0660 zem kvm"
	];

	nixpkgs.overlays = [ (final: prev: {
		looking-glass-client = prev.looking-glass-client.overrideAttrs(
			old: {
				pname = "looking-glass-client";

				src = pkgs.fetchFromGitHub {
					owner = "gnif";
					repo = "LookingGlass";
					rev = "B6";
					hash = "sha256-6vYbNmNJBCoU23nVculac24tHqH7F4AZVftIjL93WJU=";
					fetchSubmodules = true;
				};

				patches = [];
			});
		})
	];

	environment.systemPackages = with pkgs; [
		looking-glass-client
	];

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
