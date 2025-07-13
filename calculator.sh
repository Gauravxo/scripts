#!/bin/bash

# Function to perform addition
addition() {
    result=$(echo "$1 + $2" | bc)
    echo "Result: $result"
}

# Function to perform subtraction
subtraction() {
    result=$(echo "$1 - $2" | bc)
    echo "Result: $result"
}

# Function to perform multiplication
multiplication() {
    result=$(echo "$1 * $2" | bc)
    echo "Result: $result"
}

# Function to perform division
division() {
    result=$(echo "scale=2; $1 / $2" | bc)
    echo "Result: $result"
}

# Main script
echo "Simple Calculator"
echo "Available operations: + - * /"

read -p "Enter first number: " num1
read -p "Enter operation: " operation
read -p "Enter second number: " num2

case $operation in
    +) addition $num1 $num2 ;;
    -) subtraction $num1 $num2 ;;
    \*) multiplication $num1 $num2 ;;
    /) division $num1 $num2 ;;
    *) echo "Invalid operation" ;;
esac

