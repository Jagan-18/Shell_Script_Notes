# Create a script that checks if a particular service (e.g., httpd or nginx) is running. If not, it should restart the service and log the action.

#!/bin/bash

# Define the service to check
SERVICE="httpd" # Change this to nginx or any other service if needed

# Define the log file location
LOG_FILE="/var/log/service_check.log"

# Get the current date and time for logging
current_time=$(date +'%Y-%m-%d %H:%M:%S')

# Check if the service is running
if ! systemctl is-active --quiet "$SERVICE"; then
    # If the service is not running, restart it
    echo "$current_time: $SERVICE is not running. Restarting the service..." >>"$LOG_FILE"
    systemctl restart "$SERVICE"

    # Log the restart action
    if systemctl is-active --quiet "$SERVICE"; then
        echo "$current_time: $SERVICE restarted successfully." >>"$LOG_FILE"
    else
        echo "$current_time: Failed to restart $SERVICE." >>"$LOG_FILE"
    fi
else
    echo "$current_time: $SERVICE is running fine." >>"$LOG_FILE"
fi

###   Explanation:
#### 1. Service to Check: The service to check is defined by the SERVICE variable. You can change this to nginx, httpd, or any other service name you want to monitor.
#### 2. Log File: Logs are written to /var/log/service_check.log. You can modify this path to a different log file if necessary. Check if the Service is Running:
#### 3.The script uses systemctl is-active --quiet $SERVICE to check if the service is running. If the service is inactive, the script proceeds to restart it.
#### 4.Restarting the Service: If the service is not running, it gets restarted using systemctl restart $SERVICE.
#### 5.Logging the Action: The script logs actions (whether the service was running, restarted, or failed to restart) to the log file, along with the timestamp.

#_____________________________#

#Service Health Check script
#!/bin/bash

SERVICE="nginx"

# Check if the service is active
if systemctl is-active --quiet $SERVICE; then
    echo "$SERVICE is running"
else
    echo "$SERVICE is not running"
    systemctl start $SERVICE
fi

### EXplaning:
#### 1. SERVICE="nginx": Defines a variable SERVICE with the value "nginx" (or any service name you choose).
#### 2. if systemctl is-active --quiet $SERVICE; then: Checks if the service is running. --quiet suppresses output, returning 0 if active (success), or non-zero if inactive (failure).
#### 3. echo "$SERVICE is running": Prints the message if the service is running.
#### 4. else: If the service is not running, the script moves to this block.
#### 5. echo "$SERVICE is not running": Prints that the service isn't running.
#### 6. systemctl start $SERVICE: Attempts to start the service.

#___________________#
#!/bin/bash

SERVICE="nginx"

# Check if the service is active, and start it if not
systemctl is-active --quiet $SERVICE || {
    echo "$SERVICE is not running"
    systemctl start $SERVICE
}
