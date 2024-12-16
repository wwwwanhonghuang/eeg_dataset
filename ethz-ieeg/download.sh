#!/bin/bash

# Check if the correct number of arguments is passed
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <ID> <start_range> <end_range>"
    exit 1
fi

# Assign arguments to variables
ID=$1
START=$2
END=$3

# Base URL
BASE_URL="http://ieeg-swez.ethz.ch/long-term_dataset"

# Validate input
if [[ ! $START =~ ^[0-9]+$ || ! $END =~ ^[0-9]+$ || $START -gt $END ]]; then
    echo "Invalid range. Ensure start and end are numbers, and start is less than or equal to end."
    exit 1
fi


FILE_URL="${BASE_URL}/${ID}/${ID}_info.mat"
echo "Downloading: $FILE_URL"
wget "$FILE_URL" -q --show-progress || echo "Failed to download: $FILE_URL"

# Loop through the range and download each file
for (( i=$START; i<=$END; i++ )); do
    FILE_URL="${BASE_URL}/${ID}/${ID}_${i}h.mat"
    echo "Downloading: $FILE_URL"
    wget "$FILE_URL" -q --show-progress || echo "Failed to download: $FILE_URL"
done




echo "Download completed."

