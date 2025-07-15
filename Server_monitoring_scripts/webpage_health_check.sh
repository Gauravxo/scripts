#!/bin/bash
URL="webpage url"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" $URL)
if [ $STATUS -ne 200 ]; then
	echo "webpage down !!! Code: $STATUS"
else
	echo -e "\033[33;3m ***** webpage is up and working fine*****\033[m"

fi
