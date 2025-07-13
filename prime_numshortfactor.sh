#!/bin/bash

read -p "Enter a number: " num

[ $(factor $num | wc -w) -eq 2 ] && 
	echo "$num is a prime number" || 
	echo "$num is not a prime number"

