#!/bin/bash

# Check if an argument was provided
if [ -z "$1" ]; then
    echo "Error: Please provide a username."
    echo "Usage: ./create_user.sh <username>"
    exit 1
fi

NEW_USER=$1

# Check if the user already exists by searching the /etc/passwd file
if grep -q "^${NEW_USER}:" /etc/passwd; then
    echo "User $NEW_USER already exists!"
else
    # Create the user with a home directory (-m) and bash shell (-s)
    sudo useradd -m -s /bin/bash "$NEW_USER"
    
    if [ $? -eq 0 ]; then
        echo "Successfully created user: $NEW_USER"
    else
        echo "Failed to create user."
    fi
fi