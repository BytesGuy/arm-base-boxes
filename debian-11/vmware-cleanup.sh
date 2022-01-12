#!/bin/bash -x

# sudo e4defrag /

sudo apt-get clean
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY
sync

# sudo vmware-toolbox-cmd disk shrink /