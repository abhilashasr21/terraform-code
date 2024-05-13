#!/bin/bash

# Get list of all block devices
block_devices=$(lsblk -o NAME,MOUNTPOINT -nr | awk '$2 == "" {print $1}')

if [ -z "$block_devices" ]; then
    echo "No unmounted disks found."
    exit 0
fi

echo "Unmounted disks:"
echo "$block_devices"


