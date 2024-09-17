#!/bin/bash

# Make the Script Executable
#chmod +x add_sudo_user.sh

# Run the Script
#sudo ./add_sudo_user.sh username

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
  # Add the user to the sudo group
  usermod -aG sudo "$USERNAME"
  echo "User $USERNAME has been added to the sudo group."
else
  echo "User $USERNAME does not exist."
  exit 1
fi
