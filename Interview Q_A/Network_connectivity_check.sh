#!/bin/bash
HOST="google.com"
OUTPUT_FILE="/home/ubuntu/output.txt"

# Get current timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Check if the host is reachable
if ping -c 1 $HOST &>/dev/null; then
    echo "$TIMESTAMP - $HOST is reachable" >>$OUTPUT_FILE
else
    echo "$TIMESTAMP - $HOST is not reachable" >>$OUTPUT_FILE
fi

## Explanning;
#### 1. Variables:
####              - HOST="google.com": Defines the host to ping.
####              - OUTPUT_FILE="/home/ubuntu/output.txt": Defines the file where the output will be logged.
#### 2. Get Timestamp: TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S"): Captures the current date and time in YYYY-MM-DD HH:MM:SS format.
#### 3. Ping the Host: ping -c 1 $HOST &>/dev/null: Sends 1 ping packet to $HOST (google.com). The &>/dev/null part suppresses any output from ping.
#### 4. Conditional Check:
####                - If the ping is successful, it appends a message like "2024-11-17 14:30:00 - google.com is reachable" to the output file.
####                - If the ping fails, it logs "2024-11-17 14:30:00 - google.com is not reachable" to the same file

#_________________#
## modified to ping multiple hosts?
HOSTS=("google.com" "yahoo.com" "github.com")
for HOST in "${HOSTS[@]}"; do
    if ping -c 1 $HOST &>/dev/null; then
        echo "$HOST is reachable" >>$OUTPUT_FILE
    else
        echo "$HOST is not reachable" >>$OUTPUT_FILE
    fi
done
