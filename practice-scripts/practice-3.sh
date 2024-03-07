#!/bin/bash

# This Bash script is designed to manage user accounts on a Unix-like system, particularly focusing on disabling or deleting user accounts and optionally archiving their home directories.

ARCHIVE_DIR='/archive'

# Display the usage and exit.
usage() {
    echo "USAGE: ${0} [-dra] [user] [usern] ...." >&2
    echo "disable the local user"
    echo " -d delete the user instead of disabling" >&2
    echo " -r remove the home dir associated with the user" >&2
    echo " -a archive the home dir associated with the user" >&2
    exit 1
}

# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]; then
    echo "Please execute the script with superuser privileges" >&2
    exit 1
fi

# Parse the options.
while getopts dra OPTION; do
    case ${OPTION} in
    d)
        DELETE_USER='true'
        ;;
    r)
        REMOVE_USER='-r'
        ;;
    a)
        ARCHIVE='true'
        ;;
    ?)
        usage
        ;;
    esac
done

# Remove the options while leaving the remaining arguments.
shift "$((OPTIND - 1))"

# If the user doesn't supply at least one argument, give them help.
if [[ "${#}" -lt 1 ]]; then
    usage
fi

# Loop through all the usernames supplied as arguments.
for USERNAME in "${@}"; do
    echo "processing the user ${USERNAME}"

    # Make sure the UID of the account is at least 1000.
    USERID=$(id -u "${USERNAME}")
    if [[ ${USERID} -lt 1000 ]]; then
        echo "refusing to remove the ${USERNAME} with id ${USERID}" >&2
        exit 1
    fi

    # Create an archive if requested to do so.
    if [[ ${ARCHIVE} = 'true' ]]; then
        # Make sure the ARCHIVE_DIR directory exists.
        if [[ ! -d ${ARCHIVE_DIR} ]]; then
            echo "Creating the archive dir"
            mkdir -p "${ARCHIVE_DIR}"
            if [[ "${?}" -ne 0 ]]; then
                echo "archive dir not created ${ARCHIVE_DIR}" >&2
                exit 1
            fi
        fi
        # Archive the user's home directory and move it into the ARCHIVE_DIR
        HOME_DIR="/home/${USERNAME}"
        ARCHIVE_FILE="${ARCHIVE_DIR}/${USERNAME}.tgz"
        if [[ -d "${HOME_DIR}" ]]; then
            echo "Archiving the ${HOME_DIR} to ${ARCHIVE_FILE}"
            tar -zcf "${ARCHIVE_FILE}" "${HOME_DIR}" &>/dev/null
            if [[ "${?}" -ne 0 ]]; then
                echo "could not create ${ARCHIVE_FILE}" >&2
                exit 1
            fi
        else
            echo "${HOME_DIR} is not present" >&2
            exit 1
        fi
    fi

    # Delete the user.
    if [[ "${DELETE_USER}" = 'true' ]]; then
        userdel ${REMOVE_USER} "${USERNAME}"

        # Check to see if the userdel command succeeded.
        # We don't want to tell the user that an account was deleted when it hasn't been.
        if [[ "${?}" -ne 0 ]]; then
            echo "${USERNAME} is not deleted" >&2
            exit 1
        fi
        echo "${USERNAME} is deleted"
    else
        chage -E 0 "${USERNAME}"
        # Check to see if the chage command succeeded.
        if [[ "${?}" -ne 0 ]]; then
            echo "${USERNAME} is not disabled" >&2
            exit 1
        fi
        echo "${USERNAME} is disabled"
    fi
done

exit 0


