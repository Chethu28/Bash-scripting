# GitHub Repository Name

This repository contains a Bash script to list users with read access to a GitHub repository using the GitHub API.

## Usage

### Prerequisites

Before using the script, ensure that you have the following information:

- GitHub username (`USERNAME`)
- GitHub personal access token (`TOKEN`)
- GitHub repository owner (`Repo_Owner`)
- GitHub repository name (`Repo_Name`)

### Instructions

1. Clone the repository:

   ```
   git clone [https://github.com/yourusername/your-repo.git]
   cd your-repo
   ```
2. Set the required environment variables:
   ```
   export username=your-github-username
   export token=your-github-token
   ```
3. Execute the script:
   ```
   ./script.sh owner_name repository_name
   ```
Replace owner_name and repository_name with the actual owner and name of the GitHub repository you want to query.

##  Script Explanation
##  The Bash script (list-user.sh) consists of the following components:

- API URL: The GitHub API URL is set to https://api.github.com.
- Credentials: Provide your GitHub username and personal access token in the script.
- Repository Information: Specify the owner and name of the GitHub repository as command-line arguments.
- Functions:
   - github_api_get: Makes a GET request to the GitHub API.
   - list_user_with_read_access: Lists users with read access to the specified GitHub repository.
- Execution: The main script section initiates the process by calling the list_user_with_read_access function.





