#!/bin/bash

echo "Please Enter Your age"
read age
if [ $age -gt 20 ] && [ $age -lt 30 ]
then
	echo "you are very young bro"
else
	echo "you are old"
fi
