#!/bin/bash
echo "This Script is written By Gauravxo" |lolcat
echo "Enter Your age here" |lolcat
read age
if [ $age -gt 10 ] && [ $age -le 25 ]; then
       echo "You Are a young boy" |lolcat
elif [ $age -gt 25 ]; then
echo "You are a mature persion" |lolcat
else
echo "you are a kid" |lolcat
fi

