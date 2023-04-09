#!/bin/bash
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
