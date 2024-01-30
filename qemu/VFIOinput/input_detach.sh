#!/bin/sh
source /home/$USER/.VFIOinput/vm_name.sh
virsh --connect=qemu:///system detach-device $VM_NAME /home/$USER/.VFIOinput/keyboard.xml
virsh --connect=qemu:///system detach-device $VM_NAME /home/$USER/.VFIOinput/mouse.xml
