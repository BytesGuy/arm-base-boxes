#!/bin/bash

sudo apt clean
sudo e4defrag /
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
sync
sudo vmware-toolbox-cmd disk shrink /