#!/bin/bash
echo "Enter Your Favourite color"
read color
if [ $color = black ]; then
	echo "Superbbb you are a gentelman"
elif [ $color = pink ]; then 
	echo "You are a girl"
else
	echo "okay you favourite is $color"
fi
