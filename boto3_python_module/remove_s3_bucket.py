import boto3
import argparse

def delete_s3_bucket(bucket_name):
    s3_client = boto3.client('s3')
    
    # Empty the bucket
    bucket_objects = s3_client.list_objects_v2(Bucket=bucket_name)
    if 'Contents' in bucket_objects:
        for obj in bucket_objects['Contents']:
            s3_client.delete_object(Bucket=bucket_name, Key=obj['Key'])

    # Delete the bucket
    s3_client.delete_bucket(Bucket=bucket_name)
    print(f"Bucket '{bucket_name}' deleted successfully.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Delete an S3 bucket.")
    parser.add_argument("bucket_name", help="The name of the S3 bucket to delete.")
    args = parser.parse_args()

    delete_s3_bucket(args.bucket_name)