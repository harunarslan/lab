#!/bin/bash

cd /
sudo parted /dev/nvme0n1 --script mklabel gpt mkpart xfspart xfs 0% 100%
sudo mkfs.xfs -f /dev/nvme0n1
sudo partprobe /dev/nvme0n1
sudo mount /dev/nvme0n1 /root/hall

sudo parted /dev/nvme1n1 --script mklabel gpt mkpart xfspart xfs 0% 100%
sudo mkfs.xfs -f /dev/nvme1n1
sudo partprobe /dev/nvme1n1
sudo mount /dev/nvme1n1 /root/hall

sudo parted /dev/nvme1n1 --script mklabel gpt mkpart xfspart xfs 0% 100%
sudo mkfs.xfs -f /dev/nvme2n1
sudo partprobe /dev/nvme2n1
sudo mount /dev/nvme2n1 /root/hall
