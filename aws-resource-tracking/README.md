# AWS Resource Tracker

## Description

This script fetches information about various AWS resources in your account, including EC2 instances, IAM users, S3 buckets, and Lambda functions.

## Author

- Chethan
- Date: 12/16/2023

## Usage

1. Make sure you have the AWS CLI and jq installed.
2. Configure the AWS CLI with your credentials using `aws configure`.
3. Run the script:

    ```bash
    ./resource-tracker.sh
    ```

## Resources Listed

### EC2 Instances

The script lists EC2 instances in your AWS account, including details such as Instance ID, Availability Zone, and Name tag.

### IAM Users

The script retrieves and lists IAM users in your AWS account.

### S3 Buckets

The script displays a list of S3 buckets in your AWS account.

### Lambda Functions

The script lists Lambda functions in the specified AWS region.

## Requirements

- AWS CLI
- jq (a lightweight and flexible command-line JSON processor)

## Note

Ensure that your AWS CLI is properly configured with the necessary permissions to access the listed resources.

