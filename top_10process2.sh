#!/bin/bash

# Display top 10 processes by CPU usage
echo "Here are your top 10 processes by CPU usage:"
ps -aux --sort=-%cpu | head -10 | awk '{print $1,$2,$3,$4,$8,$9,$10,$11}' | column -t | nl |tee >> date %y %m %d cpu.txt

# Check for processes consuming high CPU
#awk '{if ($3 > 0.3) print pid is: $3" "and process name is:$9}'  cpu.txt |column -t
awk '{if ($3 > 0.3) print "pid is: " $2 " and process name is: " $11}' cpu.txt | column -t

