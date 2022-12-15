#/bin/sh

# This script is used to create a Terraform state bucket in GCP Bucket Storage

# Generate a random string to use as a bucket name
BUCKET_NAME="terraform-state-$(openssl rand -hex 4)"

# Create the bucket
gsutil mb -p $(gcloud config get-value project) gs://$BUCKET_NAME

# Enable versioning on the bucket
gsutil versioning set on gs://$BUCKET_NAME

