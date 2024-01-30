#!/bin/bash
# https://github.com/egara/arch-btrfs-installation/blob/master/files/upgrade-system.sh 


if hash btrfs 2>/dev/null; then
	echo "Creating a read-only snapshot of the system. Please wait..."
	btrfs subvolume snapshot -r /mnt/defvol/_active/rootvol/ /mnt/defvol/_snapshots/root-$(date "+%F")
	
else
    echo "btrfs-progs not installed. Please, install it."
fi

echo "Upgrading the system. Please wait..."

pacman -Syu
