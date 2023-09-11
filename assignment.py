import os
import boto3
import logging

from boto3 import resource


logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    s3_client = boto3.client('s3')
    # Specify the S3 bucket name and prefix
    bucket_name = os.environ['S3_BUCKET']
    prefix = os.environ['S3_PREFIX']

    try:
        # List objects in the S3 bucket
        response = s3_client.list_objects_v2(Bucket=bucket_name, Prefix=prefix)

        # Iterate through the objects and log their contents
        for obj in response.get('Contents', []):
            obj_key = obj['Key']
            response = s3_client.get_object(Bucket=bucket_name, Key= obj_key)
            file_contents = response['Body'].read().decode('utf-8')
            print(f'Contents of {obj_key}:')
            print(file_contents)
            print('-' * 200)
            logger.info(f"Contents of {obj_key}: {file_contents}")

    except Exception as e:
        logger.error(f"Error: {str(e)}")
    
