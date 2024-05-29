# Essentials
AddPackage base # Minimal package set to define a basic Arch Linux installation
AddPackage base-devel # Basic tools to build Arch Linux packages
AddPackage efibootmgr # Linux user-space application to modify the EFI Boot Manager
AddPackage grub # GNU GRand Unified Bootloader (2)
AddPackage linux # The Linux kernel and modules
AddPackage linux-firmware # Firmware files for Linux
AddPackage openssh # SSH protocol implementation for remote login, command execution and file transfer
AddPackage sudo # Give certain users the ability to run some commands as root
AddPackage git # the fast distributed version control system
CopyFile /etc/locale.gen
AddPackage earlyoom # Early OOM Daemon for Linux
SystemdEnable earlyoom /usr/lib/systemd/system/earlyoom.service
SystemdEnable util-linux /usr/lib/systemd/system/fstrim.timer

# Networking
AddPackage ntp # Network Time Protocol reference implementation
AddPackage networkmanager # Network connection manager and user applications
SystemdEnable networkmanager /usr/lib/systemd/system/NetworkManager.service

# Hardware specific
AddPackage amd-ucode # Microcode update image for AMD CPUs
AddPackage xf86-video-amdgpu # X.org amdgpu video driver
AddPackage vulkan-radeon # Open-source Vulkan driver for AMD GPUs

if [ "$(cat /etc/hostname)" == "Laptop" ]; then
    # Encrypted drives
    AddPackage lvm2 # Logical Volume Manager 2 utilities
fi
