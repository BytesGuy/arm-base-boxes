#!/bin/bash

# Configure vagrant SSH authentication
mkdir -pv /home/vagrant/.ssh
chmod 0700 /home/vagrant/.ssh
wget -O /home/vagrant/.ssh/authorized_keys https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant.pub
chmod 0600 /home/vagrant/.ssh/authorized_keys

# Defrag and shrink the disk
sudo e4defrag /
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY
sync
sudo vmware-toolbox-cmd disk shrink /
