#!/bin/bash

# Check if a bucket name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <bucket-name>"
    exit 1
fi

BUCKET_NAME=$1

# Create the S3 bucket
echo "Creating S3 bucket: $BUCKET_NAME"
aws s3 mb s3://$BUCKET_NAME

# Check if the bucket was created successfully
if [ $? -eq 0 ]; then
    echo "Bucket $BUCKET_NAME created successfully."
else
    echo "Failed to create bucket $BUCKET_NAME. Please check AWS CLI configuration and permissions."
fi


# script usage
# To run this script, save it as create_s3bucket.sh and give it execute permissions:
# chmod +x create_s3bucket.sh
# Then, you can run the script by passing the desired bucket name as an argument:

# Example usage:
# ./create_s3bucket.sh my-unique-bucket-name
# Example usage:
# ./create_s3bucket.sh devopsarshad202505

# Note: Make sure you have the AWS CLI installed and configured with the necessary permissions to create S3 buckets.
# Note: The bucket name must be globally unique across all AWS S3 buckets.
# Note: The bucket name must follow S3 naming conventions (e.g., lowercase letters, numbers, hyphens).
# Note: The bucket name must be between 3 and 63 characters long.
# Note: The bucket name must not be formatted as an IP address (e.g.,

# to check if the bucket is created successfully. hit belo command over the terminal.
# $ aws s3 ls

# Note: The bucket name must not contain underscores or consecutive periods.
# Note: The bucket name must not start or end with a hyphen.
# Note: The bucket name must not contain dashes adjacent to periods (e.g., my..bucket).
# Note: The bucket name must not contain periods adjacent to dashes (e.g., my-bucket..com).
# Note: The bucket name must not contain periods adjacent to periods (e.g., my..bucket..com).
# Note: The bucket name must not contain periods adjacent to underscores (e.g., my_bucket..com).
# Note: The bucket name must not contain underscores adjacent to dashes (e.g., my_bucket-bucket).
# Note: The bucket name must not contain underscores adjacent to underscores (e.g., my_bucket__bucket).

