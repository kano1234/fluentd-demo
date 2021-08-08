#!/bin/bash

BUCKET_NAME="edu-tfstate"
REGION="ap-northeast-1"

export AWS_DEFAULT_PROFILE=sandbox

aws s3api create-bucket \
  --create-bucket-configuration LocationConstraint=${REGION} \
  --bucket ${BUCKET_NAME}

#aws s3api put-bucket-versioning \
#  --bucket $BUCKET_NAME \
#  --versioning-configuration Status=Enabled
