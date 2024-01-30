#!/bin/bash

subvolmn=$(ls /mnt/defvol/_snapshots/)
subvol=$(ls /mnt/defvol/_snapshots/ | wc -l)

if [[ -z $1 ]]; then
	echo "Need arguments"
	exit
else
	((index=$1))
fi

((i=$subvol))

echo "Deleting old snapshots"

for snap in $subvolmn; do
	if (( $i == $index )); then
		break
	fi
	btrfs subvolume delete "/mnt/defvol/_snapshots/$snap"
    ((i=$i-1))
done
echo 'Sync manually ...'

