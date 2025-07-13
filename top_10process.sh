
#!/bin/bash

echo "Here are your top 10 processes by CPU usage:"
ps -aux --sort=-%cpu | head -10 | awk '{print $1,$2,$3,$4,$8,$9,$10,$11}' | column -t | nl 

awk '{if ($4 > 0.3) print "$9" is consuming high CPU and cmd is "$9"}' 


	
 #ps -aux --sort=-%cpu | awk 'NR>1 { if ($3 > 0.2) print "ALERT: Process with PID " $2 " is consuming high CPU: " $3 "%"; }'	

