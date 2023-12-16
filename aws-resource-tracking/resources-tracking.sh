#!/bin/bash 

### This script is used to get resources from my aws account
#Author="Chethan"
#Date="12/16/2023"


#Get list of ec2-instances 
echo "Listing the ec2-instances in my aws account"
echo "################################################################"
echo
aws ec2 describe-instances \
    --filters Name=tag-key,Values=Name \
    --query 'Reservations[*].Instances[*].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Name:Tags[?Key==`Name`]|[0].Value}' \
    --output table
echo "################################################################"
echo

# Get IAM users in my account
echo "Lisiting the IAM users"
echo "################################################################"
echo 
aws iam list-users --query "Users[*].UserName" --output json | jq -r '.[]'
# aws iam list-users | jq '.Users[].UserName' 
echo "###############################################################"
echo 

# Get the list of S3 Buckets
echo "List of S3 buckets"
echo "#################################################################"
echo
aws s3 ls
echo "################################################################"
echo 

# Get the list of lambda 
echo "List of lambda"
echo "################################################################"
echo
aws lambda list-functions --region us-east-1 --query "Functions[*].FunctionName" --output json | jq -r '.[]'
echo "###############################################################"
echo