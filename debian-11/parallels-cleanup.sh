#!/bin/bash -x

sudo mkdir -p /media/tools
sudo mount -o loop /tmp/prltools.iso /media/tools
sudo /media/tools/install --install-unattended-with-deps
sudo umount /media/tools
sudo rm -f /tmp/prltools.iso

sudo apt-get clean
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY
sync