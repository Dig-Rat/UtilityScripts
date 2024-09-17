#!/bin/bash

# sudo ./remove_sudo_user.sh username

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or use sudo."
  exit 1
fi

# Check if a username is provided as a parameter
if [ -z "$1" ]; then
  echo "Usage: $0 username"
  exit 1
fi

# Assign the first parameter to the USERNAME variable
USERNAME=$1

# Check if the user exists
if id "$USERNAME" &>/dev/null; then
  # Remove the user from the sudo group
  deluser "$USERNAME" sudo
  echo "User $USERNAME has been removed from the sudo group."
else
  echo "User $USERNAME does not exist."
  exit 1
fi
