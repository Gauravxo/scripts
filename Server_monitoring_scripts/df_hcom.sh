#!/bin/bash

SERVER1="ip"
SERVER2="ip"
PASSWORD="pass"

DCPAR="/dev /run/user/0 /run/user/42 /run/user/1004 /dev/shm /run /sys/fs/cgroup /tmp /usr /boot /usr/local /home /var /var/tmp /var/log/audit /var/log "

DRPAR="/dev /run/user/0 /run/user/42 /run/user/1002 /dev/shm /run /sys/fs/cgroup /tmp /usr /boot /usr/local /home /var /var/tmp /var/log/audit /var/log / "

DF1_TMP="/tmp/df1_output.txt"
DF2_TMP="/tmp/df2_output.txt"

export SSHPASS="$PASSWORD"

echo "**********Fetching disk usage from $SERVER1..."
sshpass -e ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $SERVER1 \ "df -h --output=source,size,used,avail,pcent,target $DCPAR" > "$DF1_TMP"

echo "**********Fetching disk usage from $SERVER2..."
sshpass -e ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $SERVER2 \ "df -h --output=source,size,used,avail,pcent,target $DRPAR" > "$DF2_TMP"

echo -e "\033[33;3m**********Comparison of DC & DR Servers Partition \033[m"
echo "------------dc-----------------------------------------------dr--------------------" 

paste "$DF1_TMP" "$DF2_TMP" | pr -t -e20

rm "$DF1_TMP" "$DF2_TMP"

