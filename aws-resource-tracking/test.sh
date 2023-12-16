#!/bin/bash

# This script is used to get resources from my AWS account
# Author: Chethan
# Date: 12/16/2023

# Function to check command status and display error message
check_command_status() {
    if [ $? -ne 0 ]; then
        echo "Error executing the command. Please check AWS CLI configuration and permissions."
        exit 1
    fi
}

# Color codes for formatting
COLOR_GREEN='\033[0;32m'
COLOR_CYAN='\033[0;36m'
COLOR_RESET='\033[0m'

# Display AWS region
AWS_REGION=us-east-1
echo -e "${COLOR_CYAN}AWS Region: ${AWS_REGION}${COLOR_RESET}"

# Get list of EC2 instances 
echo -e "\n${COLOR_GREEN}Listing EC2 instances in my AWS account${COLOR_RESET}"
echo "################################################################"
aws ec2 describe-instances \
    --filters Name=tag-key,Values=Name \
    --query 'Reservations[*].Instances[*].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Name:Tags[?Key==`Name`]|[0].Value}' \
    --output table
check_command_status

# Get IAM users in my account
echo -e "\n${COLOR_GREEN}Listing IAM users${COLOR_RESET}"
echo "################################################################"
aws iam list-users --query "Users[*].UserName" --output json | jq -r '.[]'
check_command_status

# Get the list of S3 Buckets
echo -e "\n${COLOR_GREEN}List of S3 buckets${COLOR_RESET}"
echo "#################################################################"
aws s3 ls
check_command_status

# Get the list of Lambda functions
echo -e "\n${COLOR_GREEN}List of Lambda functions${COLOR_RESET}"
echo "################################################################"
aws lambda list-functions --query "Functions[*].FunctionName" --output json | jq -r '.[]'
check_command_status
echo "###############################################################"
echo