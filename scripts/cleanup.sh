#!/bin/bash
set -euo pipefail

echo "Starting system cleanup..."

# Clean package cache
echo "Cleaning package cache..."
if command -v apt-get &> /dev/null; then
    sudo apt-get clean
    sudo apt-get autoremove -y
elif command -v dnf &> /dev/null; then
    sudo dnf clean all
    sudo dnf autoremove -y
elif command -v yum &> /dev/null; then
    sudo yum clean all
    sudo yum autoremove -y
fi

# Clean log files
echo "Cleaning log files..."
sudo find /var/log -type f -name "*.log" -exec truncate -s 0 {} \;
sudo find /var/log -type f -name "*.gz" -delete

# Defrag filesystem if e4defrag is available
echo "Defragmenting filesystem..."
if command -v e4defrag &> /dev/null; then
    sudo e4defrag / || true
fi

# Zero free space
echo "Zeroing free space..."
sudo dd if=/dev/zero of=/EMPTY bs=1M status=progress || true
sudo rm -f /EMPTY
sync
