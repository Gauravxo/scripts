#!/bin/bash

read -p "Enter a number: " num

if ((num < 2)); then
    echo "$num is not a prime number."
    exit
fi

for ((i = 2; i * i <= num; i++)); do
    ((num % i == 0)) && {
        echo "$num is not a prime number."
        exit
    }
done

echo "$num is a prime number."

