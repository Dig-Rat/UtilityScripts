#!/bin/bash

# Set the username to the one you want to purge
USERNAME="broken_user"

# 1. Remove the user's processes
# First, list all processes owned by the user
ps -u $USERNAME

# Kill all processes associated with the user
sudo pkill -u $USERNAME

# 2. Delete the user account
# This will remove the user and their home directory
sudo userdel -r $USERNAME

# 3. If userdel fails, manually remove the user from system files
# Remove the user from /etc/passwd
# Opens the file in nano, find and delete the line corresponding to the user
sudo sed -i "/^$USERNAME:/d" /etc/passwd

# Remove the user from /etc/shadow
sudo sed -i "/^$USERNAME:/d" /etc/shadow

# Remove the user from /etc/group
sudo sed -i "/^$USERNAME:/d" /etc/group

# Remove the user from /etc/gshadow
sudo sed -i "/^$USERNAME:/d" /etc/gshadow

# 4. Manually remove the user's home directory if it still exists
# Check and remove the user's home directory
if [ -d "/home/$USERNAME" ]; then
    sudo rm -rf /home/$USERNAME
    echo "Removed home directory: /home/$USERNAME"
else
    echo "No home directory found for $USERNAME"
fi

# 5. Remove the user's mail spool
# Check and remove any mail files for the user (location may vary)
if [ -f "/var/mail/$USERNAME" ]; then
    sudo rm -f /var/mail/$USERNAME
    echo "Removed mail spool: /var/mail/$USERNAME"
else
    echo "No mail spool found for $USERNAME"
fi

# 6. Remove the user's cron jobs
# Remove any cron jobs associated with the user
CRON_FILE="/var/spool/cron/crontabs/$USERNAME"
if [ -f "$CRON_FILE" ]; then
    sudo rm -f "$CRON_FILE"
    echo "Removed cron jobs for $USERNAME"
else
    echo "No cron jobs found for $USERNAME"
fi

# 7. Find and remove any remaining files owned by the user
# Search for and delete files owned by the user across the system
sudo find / -user $USERNAME -exec rm -rf {} \;
echo "Removed all remaining files owned by $USERNAME"

# 8. Remove SSH keys, if any
# Remove SSH keys from the user's home directory, if present
if [ -d "/home/$USERNAME/.ssh" ]; then
    sudo rm -rf /home/$USERNAME/.ssh
    echo "Removed SSH keys for $USERNAME"
else
    echo "No SSH keys found for $USERNAME"
fi

# 9. Verify the user has been removed
# Check if the user still exists in the system
if getent passwd | grep -q "^$USERNAME:"; then
    echo "User $USERNAME still exists in the system!"
else
    echo "User $USERNAME has been successfully purged."
fi
