#!/bin/bash -x

# Optimize VMware disk
echo "Optimizing VMware disk..."
if command -v vmware-toolbox-cmd &> /dev/null; then
    sudo vmware-toolbox-cmd disk shrink / || echo "Warning: disk shrink failed, but continuing..."
else
    echo "Warning: vmware-toolbox-cmd not found, skipping disk optimization"
fi

echo "Cleanup completed successfully"