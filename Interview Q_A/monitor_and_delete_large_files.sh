# Create a script that monitors a specified directory and automatically deletes any files larger than 100 MB.
### Prerequisites:
#### 1. inotify-tools: Install inotify-tools to monitor the directory for changes.
####   - On Ubuntu/Debian:  sudo apt-get install inotify-tools
####   - On CentOS/RHEL: sudo yum install inotify-tools

#!/bin/bash

# Directory to monitor
DIRECTORY="/path/to/directory" # Replace with the path to the directory you want to monitor

# Maximum file size (in bytes), 100 MB
MAX_SIZE=104857600 # 100 MB in bytes

# Log file for tracking actions
LOG_FILE="/var/log/file_cleanup.log"

# Function to check and delete large files
check_and_delete_large_files() {
    for file in "$DIRECTORY"/*; do
        if [ -f "$file" ]; then                   # Check if it's a regular file
            file_size=$(stat --format=%s "$file") # Get file size in bytes

            if [ "$file_size" -gt "$MAX_SIZE" ]; then # If file size is greater than 100 MB
                echo "$(date +'%Y-%m-%d %H:%M:%S'): Deleting file '$file' (Size: $file_size bytes)" >>"$LOG_FILE"
                rm "$file" # Delete the file
            fi
        fi
    done
}

# Monitor the directory for any file creation, modification, or movement
inotifywait -m -r -e create -e moved_to -e modify "$DIRECTORY" | while read path action file; do
    # Whenever a file is created, modified, or moved into the directory, check for large files
    check_and_delete_large_files
done

### Explanation:
#### 1. Directory to Monitor: The DIRECTORY variable specifies the directory that will be monitored. Replace /path/to/directory with the actual directory path you want to monitor.
#### 2. Maximum File Size: The MAX_SIZE variable is set to 100 MB in bytes (104857600 bytes). If a file exceeds this size, it will be deleted.
#### 3. Logging: The LOG_FILE variable defines the log file location (/var/log/file_cleanup.log). It logs information whenever a file is deleted.
#### 4. check_and_delete_large_files Function: This function checks all files in the specified directory. If any file is larger than the specified size (100 MB), it deletes the file and logs the action.
#### 5. inotifywait: The inotifywait command is used to monitor the directory for changes (create, moved_to, modify events). When a change is detected, the script checks the directory for large files and deletes them if necessary.
#### 6. File Size Check: The stat command is used to retrieve the file size (%s gives the size in bytes). If the file size exceeds 100 MB, it gets deleted.
