#!/bin/bash

# Check if the script is executed with root privileges
if [[ ${UID} -ne 0 ]] 
then 
        echo "Please execute the script using root user"
        exit 1
fi 

# Prompt to enter the name of the user to add
read -p "Enter the name of the user to be added: " USERADD

# Prompt to enter the original name of the user
read -p "Enter the original name of the user: " USERNAME

# Prompt to set the password for the user
read -p "Set the password for the user: " PASSWORD

# Add user with specified username and create home directory
useradd -c "$USERADD" -m $USERADD 

# Check if user addition was successful
if [[ "${?}" -ne 0 ]]
then 
        echo "User not added"
        exit 1
fi

# Set the password for the newly added user
echo $PASSWORD | passwd --stdin $USERADD

# Check if setting password was successful
if [[ "${?}" -ne 0 ]]
then 
        echo "Password not added"
        exit 1
fi

# Force user to change password after first login
passwd -e $USERADD

