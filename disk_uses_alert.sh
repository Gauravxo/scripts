#!/bin/sh
# Purpose: Monitor Linux disk space and send an email alert to $ADMIN
ALERT=90 
#ADMIN="your email here" 
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read -r output;
do
  echo "$output"
  uses=$(echo "$output" | awk '{ print $1}' | cut -d'%' -f1 )
  partition=$(echo "$output" | awk '{ print $2 }' )
  if [ $uses -ge $ALERT ]; then
    echo "Running out of space \"$partition ($uses%)\" on $(hostname) as on $(date)" |lolcat  #|
    #mail -s "Alert: Almost out of disk space $uses%" "$ADMIN"
  fi
done
