#!/bin/bash

fusermount -uz /root/hall/temp2
umount /root/hall/temp2
sleep 3
rm -r /root/hall/temp/*
rm -r /root/hall/temp2
sleep 3
mkdir /root/hall/temp2
sudo mount -t tmpfs -o size=110G tmpfs /root/hall/temp2
echo '110G RAM DISK Re-Mounted'
