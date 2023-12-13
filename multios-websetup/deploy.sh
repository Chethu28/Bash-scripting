#!/bin/bash

# Define your EC2 instance IPs
EC2_INSTANCES="172.31.40.22 172.31.46.77"

# Define the path to your private key
PRIVATE_KEY="/root/Bash-scripting/multios-websetup/keypair1111.pem"

# Define the script to be executed on the remote instances
REMOTE_SCRIPT="/root/Bash-scripting/multios-websetup/websetup.sh"

# Iterate over each EC2 instance
for host in $EC2_INSTANCES; do
   echo
   echo "#########################################################"
   echo "Connecting to $host"
   echo "Pushing Script to $host"

   if [[ $host == "172.31.40.22" ]]; then
      SCP_USER="ec2-user"
   elif [[ $host == "172.31.46.77" ]]; then
      SCP_USER="ubuntu"
   else
      echo "Unsupported OS or instance naming convention for $host"
      continue
   fi

   scp -i "$PRIVATE_KEY" -o StrictHostKeyChecking=no "$REMOTE_SCRIPT" "$SCP_USER@$host:/tmp/"

   echo "Executing Script on $host"
   ssh -i "$PRIVATE_KEY" -o StrictHostKeyChecking=no "$SCP_USER@$host" "sudo bash /tmp/$(basename $REMOTE_SCRIPT)"

   echo "Cleaning up on $host"
   ssh -i "$PRIVATE_KEY" -o StrictHostKeyChecking=no "$SCP_USER@$host" "sudo rm -rf /tmp/$(basename $REMOTE_SCRIPT)"

   echo "#########################################################"
   echo
done
