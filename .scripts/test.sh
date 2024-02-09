#!/bin/bash
# to test if the files in the file below belong to any packages

# Assuming the file containing package names is named "packages.txt"
file="awkout.txt"

# Check if the file exists
if [ ! -f "$file" ]; then
    echo "File $file not found."
    exit 1
fi

# Loop through each package name in the file
while IFS= read -r package; do
    # Use pacman -Qo to query the owner of the package and append output to output file
    pacman -Qo "$package"
done < "$file"

