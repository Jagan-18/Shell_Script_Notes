## Write a shell script that renames all.txt files in a directory by appending the current date to the filename.
#!/bin/bash

# Get the current date in the format YYYY-MM-DD
current_date=$(date +'%Y-%m-%d')

# Loop through all all.txt files in the current directory
for file in all.txt; do
    if [ -f "$file" ]; then
        # Create the new filename by appending the date to the original filename
        new_filename="${file%.txt}-$current_date.txt"

        # Rename the file
        mv "$file" "$new_filename"
        echo "Renamed $file to $new_filename"
    fi
done

## How this script works:
#### 1. Current Date: The date command is used to get the current date in the format YYYY-MM-DD.
#### 2. Loop Through Files: The for loop iterates through all all.txt files in the current directory.
#### 3. Renaming Logic: If the file exists (-f), it appends the current date to the filename.
#### 4. Renaming: The mv command is used to rename the file.
## Example: If you have a file all.txt and run the script on November 16, 2024, it will rename the file to all-2024-11-16.txt.

#___________________________________________________________________#

for file in all.txt; do mv "$file" "${file%.txt}-$(date +'%Y-%m-%d').txt"; done

## Explanation:
#### 1. for file in all.txt; do: This loops through the all.txt file(s) in the current directory.
#### 2. mv "$file" "${file%.txt}-$(date +'%Y-%m-%d').txt": This renames the file by:
####     - Removing the .txt extension using ${file%.txt}.
####     - Appending the current date (formatted as YYYY-MM-DD) using $(date +'%Y-%m-%d').
####     - Adding the .txt extension back.
####     - done: End of the loop.
## Example: If you have a file all.txt and run this command on November 16, 2024, it will rename the file to all-2024-11-16.txt.
