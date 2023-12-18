#!/bin/bash

# API URL for github
API_url="https://api.github.com"

#  username and the personal access token for the github
USERNAME=$username
TOKEN=$token 

# Name of the repo and owner
Repo_Owner=$1
Repo_Name=$2

# function to get the github api url
function github_api_get {
	local endpoint="$1"
	local url="$API_url/$endpoint"
       	curl -s -u "${USERNAME}:${TOKEN}" "$url"
	#echo $url
}

# function to list the users with read access
function list_user_with_read_access {
        local endpoint="repos/${Repo_Owner}/${Repo_Name}/collaborators"
	collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"
	if [[-f $collaborators]];
        then
		echo "No users with read access found for ${Repo_Owner}/${Repo_Name}"
	else
		echo "users with read access ${Repo_Owner}/${Repo_Name}:"
		echo "$collaborators"
	fi
}


echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_user_with_read_access
