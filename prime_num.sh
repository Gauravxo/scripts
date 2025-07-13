#!/bin/bash

# Read user input
read -p "Enter a number: " num

# Check if the number is less than 2
if [ $num -lt 2 ]; then
    echo "$num is not a prime number."
    exit
fi

# Iterate from 2 to the square root of the number
for (( i=2; i*i<=$num; i++ )); do
    if [ $((num%i)) -eq 0 ]; then
        echo "$num is not a prime number."
        exit
    fi
done

# If no factors found, it's a prime number
echo "$num is a prime number."

