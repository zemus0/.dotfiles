#!/bin/sh
source /home/$USER/.VFIOinput/vm_name.sh
virsh --connect=qemu:///system attach-device $VM_NAME /home/$USER/.VFIOinput/mouse.xml
virsh --connect=qemu:///system attach-device $VM_NAME /home/$USER/.VFIOinput/keyboard.xml
