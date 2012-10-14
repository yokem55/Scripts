#!/bin/bash
#Simple script to rip multi-disk audiobooks. Encodes with neroaac and properly
#tags the files.

echo "This the order of arguments:\
Author\
Disk Number\
Title"
disknum=$3
author=$1
title=$2

#Detect number of tracks on disk
tracks=$(udisks --show-info /dev/sr0 | grep "num audio" | grep -o '[0-9]*')

echo There are $tracks on this disk

#Test for existing audioboodk folder. If not present create folder.
if [ ! -d ~/"$author"/"$title" ]; then
    mkdir -p ~/"$author"/"$title"
    echo "Creating Audiobook Directory ~/$author/$title"
    else 
    echo "Ripping to ~/$author/$title"
fi

for i in `seq 1 $tracks`
do
	if `test $i -lt 10`
	then fn="0$i"
	else fn=$i
	fi
	filename="Disk $disknum - Track $fn.mp4"

	album="$title - Disk $3"
	echo "Ripping Track $fn of $tracks"
	cdparanoia $i -Y /dev/shm/track$fn.tmp.wav
	echo "Encoding Track $fn of $tracks"
	neroAacEnc -q .3 -if /dev/shm/track$fn.tmp.wav -of /dev/shm/track$fn.tmp.mp4
	neroAacTag -meta:title="Disk $3 - Track $fn" -meta:artist="$2" -meta:album="$album" -meta:track=$fn /dev/shm/track$fn.tmp.mp4
	mv /dev/shm/track$fn.tmp.mp4 ~/"$author"/"$title"/"$filename"
	rm /dev/shm/track$fn.tmp.wav
done
udisks --eject /dev/sr0
