#!/bin/bash

# Total steps or iterations for the progress bar
total=100

# Loop to simulate some work (e.g., a task that takes time)
for i in $(seq 1 $total)
do
    # Calculate the percentage completed
    percent=$((i * 100 / total))
    
    # Create the progress bar
    bar=$(printf "%${percent}s" | tr ' ' '#')
    
    # Print the progress bar on the same line
    printf "\rProgress: [%-100s] %d%%" "$bar" "$percent"
    
    # Sleep for 0.1 seconds to simulate work
    sleep 0.1
done

echo -e "\nTask Complete!"

