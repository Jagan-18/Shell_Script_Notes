## Develop a script that starts and stops EC2 instances based on a schedule (e.g., start at 8 AM and stop at 8 PM).

### Prerequisites:
#### 1. AWS CLI installed: Ensure that the AWS CLI is installed and configured with appropriate IAM permissions to start/stop EC2 instances.
#### 2. EC2 instance IDs: You need the instance IDs of the EC2 instances you want to manage.
#### 3. IAM permissions: The IAM user or role running this script must have the startInstances and stopInstances permissions.
#!/bin/bash
# Set the EC2 instance IDs (comma-separated list)
INSTANCE_IDS="i-xxxxxxxxxxxxxxxxx i-yyyyyyyyyyyyyyyyy"

# Define the start and stop times
START_TIME="08:00"
STOP_TIME="20:00"

# Get the current time in HH:MM format
CURRENT_TIME=$(date +'%H:%M')

# Log file to track actions
LOG_FILE="/var/log/ec2_schedule.log"

# AWS Region
REGION="us-east-1" # Change this to your desired AWS region

# Function to start EC2 instances
start_instances() {
    echo "$(date +'%Y-%m-%d %H:%M:%S'): Starting EC2 instances: $INSTANCE_IDS" >>"$LOG_FILE"
    aws ec2 start-instances --instance-ids $INSTANCE_IDS --region $REGION
    echo "$(date +'%Y-%m-%d %H:%M:%S'): EC2 instances started successfully." >>"$LOG_FILE"
}

# Function to stop EC2 instances
stop_instances() {
    echo "$(date +'%Y-%m-%d %H:%M:%S'): Stopping EC2 instances: $INSTANCE_IDS" >>"$LOG_FILE"
    aws ec2 stop-instances --instance-ids $INSTANCE_IDS --region $REGION
    echo "$(date +'%Y-%m-%d %H:%M:%S'): EC2 instances stopped successfully." >>"$LOG_FILE"
}

# Logic to check whether to start or stop the instances based on the current time
if [ "$CURRENT_TIME" == "$START_TIME" ]; then
    start_instances
elif [ "$CURRENT_TIME" == "$STOP_TIME" ]; then
    stop_instances
else
    echo "$(date +'%Y-%m-%d %H:%M:%S'): No action needed. Current time: $CURRENT_TIME" >>"$LOG_FILE"
fi

### Explanation:
#### 1. Instance IDs: The INSTANCE_IDS variable holds the EC2 instance IDs you want to manage. You can list multiple instance IDs separated by spaces.
#### 2. Start/Stop Times: The START_TIME and STOP_TIME variables define the schedule in HH
#### 3. format (24-hour format).
#### 4. Current Time: The script checks the current time using the date command.
#### 5. Start/Stop Functions: The start_instances and stop_instances functions use the aws ec2 start-instances and aws ec2 stop-instances AWS CLI commands to start and stop the EC2 instances, respectively.
#### 6. Logging: Actions are logged to /var/log/ec2_schedule.log with timestamps for tracking purposes.
#### 7. Region: The script specifies the AWS region in the REGION variable (e.g., us-east-1). Make sure this matches the region your instances are in.
