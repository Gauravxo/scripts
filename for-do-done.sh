#!/bin/bash
FILE="/home/xploit/Desktop/file.txt"
for name in $(cat $FILE)
do
	echo "Name is $name"
done
