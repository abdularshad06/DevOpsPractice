#!/bin/bash

# Variables
DEFAULT_INSTANCE_ID="i-xxxxxxxxxxxxxxxxx" # Replace with your default EC2 instance ID
REGION="us-east-1"                       # Replace with your preferred region

# Check if instance ID is provided via command line
if [ -n "$1" ]; then
    INSTANCE_ID="$1"
    echo "Using instance ID from command line: $INSTANCE_ID"
else
    INSTANCE_ID="$DEFAULT_INSTANCE_ID"
    echo "Using default instance ID: $INSTANCE_ID"
fi

# Validate instance ID
if [ -z "$INSTANCE_ID" ]; then
    echo "Error: Instance ID is not provided. Please provide it via command line or set the DEFAULT_INSTANCE_ID variable."
    exit 1
fi

# Terminate EC2 instance
echo "Terminating EC2 instance with ID: $INSTANCE_ID..."
aws ec2 terminate-instances \
    --instance-ids $INSTANCE_ID \
    --region $REGION

if [ $? -eq 0 ]; then
    echo "EC2 instance termination initiated successfully."
else
    echo "Failed to terminate EC2 instance."
    exit 1
fi

# Wait for the instance to terminate
echo "Waiting for the instance to terminate..."
aws ec2 wait instance-terminated \
    --instance-ids $INSTANCE_ID \
    --region $REGION

if [ $? -eq 0 ]; then
    echo "EC2 instance terminated successfully."
else
    echo "Failed to confirm EC2 instance termination."
    exit 1
fi

echo "EC2 instance termination process completed."

# TO check the status of the instance. Hit Below command on terminal.
# $ aws ec2 describe-instances --query "Reservations[].Instances[].[InstanceId, InstanceType, State.Name, PrivateIpAddress, PublicIpAddress]" --output table