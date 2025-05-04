import boto3
import argparse

def create_s3_bucket(bucket_name, region=None):
    try:
        s3_client = boto3.client('s3', region_name=region)
        
        # Handle region-specific bucket creation
        if region and region != 'us-east-1':
            response = s3_client.create_bucket(
                Bucket=bucket_name,
                CreateBucketConfiguration={'LocationConstraint': region}
            )
        else:
            response = s3_client.create_bucket(Bucket=bucket_name)  # No LocationConstraint for us-east-1
        
        print(f"Bucket '{bucket_name}' created successfully.")
    except Exception as e:
        print(f"Error creating bucket: {e}")

if __name__ == "__main__":
    # Set up argument parser
    parser = argparse.ArgumentParser(description="Create an S3 bucket.")
    parser.add_argument("--bucket-name", type=str, required=True, help="Name of the S3 bucket to create.")
    parser.add_argument("--region", type=str, help="AWS region for the S3 bucket (optional).")

    # Parse command-line arguments
    args = parser.parse_args()

    # Default region is 'us-east-1' if not provided
    region = args.region if args.region else 'us-east-1'

    # Create the bucket
    create_s3_bucket(args.bucket_name, region)


# Example usage from command line:
# To run the provided code, follow these steps:

#         1. **Install Dependencies**:
#             Ensure you have Python installed and the `boto3` library installed. You can install `boto3` using pip:
#             ```bash
#             pip install boto3
#             ```

#         2. **Set Up AWS Credentials**:
#             Configure your AWS credentials using the AWS CLI or by setting up the `~/.aws/credentials` file. For example:
#             ```bash
#             aws configure
#             ```
#             Provide your AWS Access Key, Secret Key, and default region.

#         3. **Run the Script**:
#             Use the command line to execute the script. You can provide the bucket name and region as arguments:
#             ```bash
#             python create_s3_bucket.py --bucket-name <your-bucket-name> --region <your-region>
#             ```
#             Example:
#             ```bash
#             python create_s3_bucket.py --bucket-name my-new-bucket --region us-east-1
#             ```

#         4. **Default Region**:
#             If you don't provide the `--region` argument, the script will default to `us-east-1`:
#             ```bash
#             python create_s3_bucket.py --bucket-name my-new-bucket
#             ```

#         Make sure the bucket name is unique globally, as S3 bucket names must be unique across all AWS accounts.
#         If the bucket name already exists, you will receive an error message indicating that the bucket name is not available.
#         Note: The script will create the bucket in the specified region or in the default region if none is provided.

#         You can also list, delete, and remove the bucket using the AWS CLI commands:
# python create_s3_bucket.py --bucket-name devopsarshad2025
# aws s3 ls
# aws s3 rm s3://devopsarshad2025 --recursive
# aws s3 rb s3://devopsarshad2025 --force