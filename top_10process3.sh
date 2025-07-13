#!/bin/bash

# Display top 10 processes by CPU usage
echo "Here are your top 10 processes by CPU usage:"
ps -aux --sort=-%cpu | head -10 | awk '{print $1,$2,$3,$4,$8,$9,$10,$11}' | column -t | nl | tee -a "$(date +%Y-%m-%d)_cpu.txt"

# Check for processes consuming high CPU
awk '{if ($3 > 0.3) print pid is:$2 process name is:$11}' "$(date +%Y-%m-%d)_cpu.txt" | column -t

