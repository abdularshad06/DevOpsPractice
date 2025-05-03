#!/bin/bash

# Variables
INSTANCE_NAME="DevOpsPracticeInstance"
AMI_ID="ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (Free Tier Eligible)
INSTANCE_TYPE="t2.micro"       # Free tier eligible instance type
KEY_NAME="First_Key"         # Replace with your key pair name
SECURITY_GROUP="launch-wizard-1" # Replace with your security group name
REGION="us-east-1"             # Replace with your preferred region

# Create EC2 instance
echo "Creating EC2 instance..."
INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --count 1 \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-groups $SECURITY_GROUP \
    --region $REGION \
    --query 'Instances[0].InstanceId' \
    --output text)

if [ $? -eq 0 ]; then
    echo "EC2 instance created successfully. Instance ID: $INSTANCE_ID"
else
    echo "Failed to create EC2 instance."
    exit 1
fi

# Add a name tag to the instance
echo "Adding Name tag to the instance..."
aws ec2 create-tags \
    --resources $INSTANCE_ID \
    --tags Key=Name,Value=$INSTANCE_NAME \
    --region $REGION

if [ $? -eq 0 ]; then
    echo "Name tag added successfully."
else
    echo "Failed to add Name tag."
    exit 1
fi

echo "EC2 instance setup complete."