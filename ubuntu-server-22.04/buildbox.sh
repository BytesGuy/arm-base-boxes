#!/bin/bash
BOX_NAME="ubuntu-server-2204-arm64.box"

# Initalise packer and build the VM
packer init .
packer build -force .
# Copy Vagrant metadata file to artifacts directory
cp metadata.json artifacts/metadata.json && cd artifacts
# Create Vagrant box
tar -cvzf $BOX_NAME ./*
# Show the SHA256 checksum of the box
shasum -a 256 $BOX_NAME
# Clean up
rm -f *.v* *.nvram *.log *.scoreboard *.plist metadata.json
# Add the box to Vagrant
vagrant box add --force --name "ubuntu-server-2204-arm64" $BOX_NAME
