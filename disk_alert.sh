#!/bin/bash

# Get disk usage information and filter out lines with percentage greater than 25
output=$(df -h | awk 'NR>1 && $5 > 25 {print}')

if [ -n "$output" ]; then
    echo "Disk usage is above 25%"
    echo "Partition details:"
    echo "$output"
else
    echo "Disk usage is below or equal to 25%"
fi

