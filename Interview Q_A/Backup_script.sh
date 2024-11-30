# write a script to back up a directory(eg: /var/log/) to another location, compress it, and add a timestamp to filename
#!/bin/bash

# Directory to back up
SOURCE_DIR="/var/log"
# Destination directory where the backup will be stored
DEST_DIR="/path/to/backup/directory"
# Get current date and time in the format YYYY-MM-DD_HH-MM-SS
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
# Backup filename with timestamp
BACKUP_FILENAME="log_backup_$TIMESTAMP.tar.gz"

# Ensure destination directory exists
mkdir -p "$DEST_DIR"

# Create a compressed tarball backup of the source directory
tar -czf "$DEST_DIR/$BACKUP_FILENAME" -C "$SOURCE_DIR" .

# Check if the backup was successful
if [ $? -eq 0 ]; then
    echo "Backup successful: $DEST_DIR/$BACKUP_FILENAME"
else
    echo "Backup failed"
    exit 1
fi
### Explanation:
#### 1. SOURCE_DIR: The directory you want to back up (/var/log/ in your example).
#### 2. DEST_DIR: The directory where the backup will be stored. Replace /path/to/backup/directory with the actual path.
#### 3. TIMESTAMP: The date command generates a timestamp in the format YYYY-MM-DD_HH-MM-SS which is appended to the backup filename to ensure it’s unique.
#### 4. tar -czf: This command creates a compressed .tar.gz archive.
####       -c: Create a new archive.
####       -z: Compress the archive with gzip.
####       -f: Use the filename provided ($BACKUP_FILENAME).

####       -C: Change to the directory (/var/log) before creating the backup (so the paths inside the archive aren't absolute).
