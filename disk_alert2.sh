#!/bin/bash
echo "Analyse disk space uses"
output=$(df -h | awk 'NR>1 && $5 > 25 {print}')
if [ $output -gt 25 ] 
then
	echo "disk uses is above $output"
else
	echo "disk uses is suffucient"
fi
