#!/bin/bash
# to delete the files after running the awk command

# Assuming the file containing file names is named "files.txt"
file="awkout.txt"

# Check if the file exists
if [ ! -f "$file" ]; then
    echo "File $file not found."
    exit 1
fi

# Use xargs to read each file name from files.txt and delete them
xargs -a "$file" rm -v
