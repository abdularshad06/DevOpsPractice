#!/bin/bash

# Script to remove an S3 bucket using AWS CLI

# Check if bucket name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <bucket-name>"
    exit 1
fi

BUCKET_NAME=$1

# Confirm before deletion
read -p "Are you sure you want to delete the bucket '$BUCKET_NAME' and all its contents? (y/n): " CONFIRM
if [[ "$CONFIRM" != "y" ]]; then
    echo "Bucket deletion canceled."
    exit 0
fi

# Delete all objects in the bucket
echo "Deleting all objects in the bucket..."
aws s3 rm s3://$BUCKET_NAME --recursive

# Remove the bucket
aws s3 rb s3://$BUCKET_NAME

# Verify deletion
if [ $? -eq 0 ]; then
    echo "Bucket $BUCKET_NAME deleted successfully."
else
    echo "Failed to delete bucket $BUCKET_NAME. Ensure it is empty and you have necessary permissions."
fi

# to check if the bucket is created successfully. hit belo command over the terminal.
# $ aws s3 ls