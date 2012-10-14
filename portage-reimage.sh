#!/bin/sh

#Update the squashfs'd portage tree with the updates from the writable AUFS 
#branch. 
#
echo 'Making New Image'
mksquashfs /usr/portage /images/portage.sqfs.new -comp xz -no-progress -noappend -ef portage-exclude
echo 'Stopping NFS'
/etc/init.d/nfs stop
echo 'Unmounting Files System'
umount /usr/portage
umount /mnt/ro/portage
echo 'Cleaning RW FS'
rm -r /mnt/rw/portage/*
rm -r /mnt/rw/portage/.wh*
mv /images/portage.sqfs.new /images/portage.sqfs
#echo 'Writing new Image to Disk'
#dd if=/var/images/portage.sqfs.new of=/dev/system-new/portage
echo 'Mounting Filesystems Again'
mount /mnt/ro/portage
mount /usr/portage
echo 'Restarting NFS'
/etc/init.d/nfs start
echo 'Done'
