#!/bin/bash
set -euo pipefail

echo "Starting system cleanup..."

# Clean package cache
echo "Cleaning package cache..."
sudo apt-get clean
sudo apt-get autoremove -y

# Remove old kernels except the current one
echo "Removing old kernels..."
sudo dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge || true

# Clean log files
echo "Cleaning log files..."
sudo find /var/log -type f -name "*.log" -exec truncate -s 0 {} \;
sudo find /var/log -type f -name "*.gz" -delete

# Defrag filesystem
echo "Defragmenting filesystem..."
sudo e4defrag / || true

# Zero free space
echo "Zeroing free space..."
sudo dd if=/dev/zero of=/EMPTY bs=1M status=progress || true
sudo rm -f /EMPTY
sync

# Optimize VMware disk
echo "Optimizing VMware disk..."
if command -v vmware-toolbox-cmd &> /dev/null; then
    sudo vmware-toolbox-cmd disk shrink / || echo "Warning: disk shrink failed, but continuing..."
else
    echo "Warning: vmware-toolbox-cmd not found, skipping disk optimization"
fi

echo "Cleanup completed successfully"