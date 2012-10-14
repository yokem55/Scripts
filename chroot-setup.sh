#!/bin/bash

# Our old Pentium-M Laptop is too slow to compile its own updates. This script
# mounts the laptop's root filesystem onto my workstation via nfs, bind mounts 
# local filesystems to do the compiling locally, and chroot's into it.

#Mount laptop filesystem
mount kidslaptop:/ /mnt/oldlaptop
mount kidslaptop:/boot /mnt/oldlaptop/boot
echo "Mounted Laptop Filesystems"

#Bind mount local system filesystems
mount -t proc none /mnt/oldlaptop/proc
mount -o bind /dev /mnt/oldlaptop/dev
mount -o bind /dev/pts /mnt/oldlaptop/dev/pts
mount -o bind /usr/src /mnt/oldlaptop/usr/src
#mount -o bind /home/joe/oldlaptopkernel/ /mnt/oldlaptop/root/kernel-build

echo "Mounted Local Filesytems into laptop root"

#Mount Paludis/portage related filesystems
mount -o bind /usr/portage /mnt/oldlaptop/usr/portage
mount -o bind /var/paludis/distfiles /mnt/oldlaptop/var/paludis/distfiles
mount -o bind /var/tmp/paludis /mnt/oldlaptop/var/tmp/paludis

echo "Mounted Paludis filesystems into laptop root"

cp /etc/resolv.conf /mnt/oldlaptop/etc/resolv.conf
echo "Copied resolv.conf"

linux32 chroot /mnt/oldlaptop /bin/bash
