# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }: {
	imports = [ # Include the results of the hardware scan.
		./hardware-configuration.nix
		./i3.nix
		./vfio.nix
		./searx.nix
	];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nixpkgs.config.allowUnfree = true;
	hardware.enableAllFirmware = true;
	programs.nix-ld.enable = true;
	programs.virt-manager.enable = true;

	# Use the systemd-boot EFI boot loader.
	# boot.loader.systemd-boot.enable = true;
	boot.loader = {
		 efi.canTouchEfiVariables = true;
		 grub = {
				 enable = true;
				 device = "nodev";
				 efiSupport = true;
		 };
	};

	# enable hibernation
	powerManagement.enable = true;
	# enable powersaving stuff
	services.tlp.enable = true;
	# enable earlyoom
	services.earlyoom = {
		enable = true;
		extraArgs = [
			"-m 10"
			"-r 3600"
			"-n"
			"--avoid '(^|/)(init|systemd|Xorg|sshd|qemu-system-x86_64)$'"
		];
	};


	networking.hostName = "nixos"; # Define your hostname.
	# Pick only one of the below networking options.
	# networking.wireless.enable = true;	# Enables wireless support via wpa_supplicant.
	networking.networkmanager.enable = true;	# Easiest to use and most distros use this by default.

	# Set your time zone.
	time.timeZone = "America/New_York";
	services.ntp.enable = true;

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	fonts = {
			packages = with pkgs; [
					(nerdfonts.override {fonts = [ "AurulentSansMono" ];})
			];
			fontconfig.defaultFonts = {
				monospace = ["AurulentSansM Nerd Font" "DejaVu Sans Mono"];
			};
	};

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";
	console = {
		useXkbConfig = true; # use xkb.options in tty.
	};


	# Configure keymap in X11
	services.xserver.xkb.layout = "us";
	#services.xserver.xkb.options = "eurosign:e,caps:escape";
	# Keymapping keys
	services.keyd = {
		enable = true;
		keyboards = {
			default = {
				ids = ["*"];
				settings = {
					main = {
						capslock = "middlemouse";
					};
				};
				extraConfig = ''
				[control]
				capslock = leftmouse
				[alt]
				capslock = rightmouse
				'';
			};
		};
	};

	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Enable sound.
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	# Enable touchpad support (enabled default in most desktopManager).
	# services.xserver.libinput.enable = true;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	# users.mutableUsers = true;
	users.users.zem = {
		initialPassword = "1234";
		isNormalUser = true;
		extraGroups = [ "wheel" "kvm" "libvirtd" ]; # Enable ‘sudo’ for the user.
		home = "/home/zem";
		shell = pkgs.zsh;
		ignoreShellProgramCheck = true;
	};

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		alsa-utils
		pulseaudio
		psmisc
		pciutils
		pwvucontrol
		git
		neovim 
		wget
		gnumake
		moreutils
		glibc
		glibcInfo
	];

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	programs.mtr.enable = true;
	programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
	};

	services.udisks2.enable = true;
	# List services that you want to enable:

	# Enable the OpenSSH daemon.
	# services.openssh.enable = true;

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	# Copy the NixOS configuration file and link it from the resulting system
	# (/run/current-system/configuration.nix). This is useful in case you
	# accidentally delete configuration.nix.
	system.copySystemConfiguration = true;

	# This option defines the first version of NixOS you have installed on this particular machine,
	# and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
	#
	# Most users should NEVER change this value after the initial install, for any reason,
	# even if you've upgraded your system to a new NixOS release.
	#
	# This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
	# so changing it will NOT upgrade your system.
	#
	# This value being lower than the current NixOS release does NOT mean your system is
	# out of date, out of support, or vulnerable.
	#
	# Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
	# and migrated your data accordingly.
	#
	# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
	system.stateVersion = "23.11"; # Did you read the comment?
}
