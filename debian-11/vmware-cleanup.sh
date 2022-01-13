#!/bin/bash -x

# sudo e4defrag /

wget https://packages.vmware.com/tools/open-vm-tools/ovt-arm-tech-preview/Debian-10/open-vm-tools-11.2.5-2debian10.tgz
tar -zxf open-vm-tools-11.2.5-2debian10.tgz
sudo dpkg -i ./open-vm-tools_11.2.5-2debian10_arm64.deb
sudo apt --fix-broken install -y
sudo mkdir -p /mnt/hgfs/
sudo /usr/bin/vmhgfs-fuse .host:/ /mnt/hgfs/ -o subtype=vmhgfs-fuse,allow_other

sudo apt-get clean
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY
sync

sudo vmware-toolbox-cmd disk shrink /