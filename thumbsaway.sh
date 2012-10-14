#!/bin/sh

#remove thumbnails older than one year
find /home/joe/.thumbnails/ -mtime +365 -exec rm -f {} \;
