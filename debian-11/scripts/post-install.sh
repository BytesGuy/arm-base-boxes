#!/bin/bash

# Install apt package sources
# https://wiki.debian.org/SourcesList
sudo tee /etc/apt/sources.list > /dev/null <<'EOF'
deb http://deb.debian.org/debian bullseye main
deb-src http://deb.debian.org/debian bullseye main

deb http://deb.debian.org/debian-security/ bullseye-security main
deb-src http://deb.debian.org/debian-security/ bullseye-security main

deb http://deb.debian.org/debian bullseye-updates main
deb-src http://deb.debian.org/debian bullseye-updates main
EOF
# Ensure system is up to date
sudo apt-get update && sudo apt-get upgrade -y
# Download open-vm-tools
wget -O open-vm-tools.tgz https://packages.vmware.com/tools/open-vm-tools/ovt-arm-tech-preview/Debian-10/open-vm-tools-11.2.5-2debian10.tgz
tar -xf open-vm-tools.tgz
# Install open-vm-tools
sudo dpkg -i ./open-vm-tools_11.2.5-2debian10_arm64.deb && rm -f open-vm-tools*
sudo apt-get install -f -y && sudo apt-get clean
# Setup HGFS for VMware Tools Shared Folders Linux mounts
# https://kb.vmware.com/s/article/60262
sudo mkdir -pv /mnt/hgfs/
sudo /usr/bin/vmhgfs-fuse .host:/ /mnt/hgfs -o subtype=vmhgfs-fuse,allow_other
# Configure vagrant SSH key based authentication
mkdir -pv /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
wget -O /home/vagrant/.ssh/authorized_keys https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant.pub
chmod 644 /home/vagrant/.ssh/authorized_keys
# Shrink the disk
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY
sync
sudo vmware-toolbox-cmd disk shrink /
