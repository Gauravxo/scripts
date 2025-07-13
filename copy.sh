#!/bin/bash

echo "############# This script will find and copy all your pending PDF files from the src to dst ######################"

input="/home/xploit/Documents/output.txt"
output_dir="/home/lvl"

while IFS= read -r pdf_ext; do
    pdf_name=$(basename "$pdf_ext" .pdf)
    pending=$(find /home/xploit/output -name "${pdf_name}.pdf")

    if [ -n "$pending" ]; then
        cp "$pending" "$output_dir"
        echo "Copied $pdf_name.pdf to $output_dir"
    else
        echo "File $pdf_name.pdf not found in /home/xploit/Documents/output"
    fi
done < "$input"
echo "*************** All files have been copied successfully ******************************"
