#!/bin/bash


# Make sure the script is being executed with superuser privileges.

if [[ "${UID}" -ne 0 ]]
then 
	echo "Please execute the script with the superuser privileges"
	exit 1
fi

# If the user doesn't supply at least one argument, then give them help.

if [[ "${#}" -eq 0 ]]
then 
	echo "Usage: ./practice-2.sh [option1] [option2] ....."
	exit 1
fi 
# The first parameter is the user name.

USERNAME="$1"


# The rest of the parameters are for the account comments.
shift 
COMMENTS="$2"

# Generate a password.

PASSWORD=$(date +%s%N | sha256sum | head -c12)

# Create the user with the password.

useradd -c "$COMMENTS" -m $USERNAME
# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]
then 
	echo "User not added contact the admin or check the ${1} parameter"
	exit 1
fi

# Set the password.
echo $PASSWORD | passwd --stdin $USERNAME
# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then    
	echo "User not added contact the admin or check the ${1} parameter"
	exit 1
fi
# Force password change on first login.

passwd -e $USERNAME
# Display the username, password, and the host where the user was

echo 
echo username: 
echo $USERNAME
echo 
echo password:
echo $PASSWORD
echo 
echo hostname:
echo $HOSTNAME
