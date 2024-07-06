#!/bin/bash

# Log file and secure directory for passwords
LOG_FILE="/var/log/user_management.log"
SECURE_DIR="/var/secure"
PASSWORD_FILE="$SECURE_DIR/user_passwords.txt"

# Ensure secure directory exists and has the right permissions
mkdir -p $SECURE_DIR
chmod 700 $SECURE_DIR

# Function to generate random passwords
generate_password() {
    echo $(openssl rand -base64 12)
}

# Function to log actions
log_action() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOG_FILE
}

# Read user list file
USER_LIST=$1
if [[ ! -f $USER_LIST ]]; then
    echo "User list file not found!"
    exit 1
fi

while IFS=';' read -r user groups; do
    # Remove whitespace
    user=$(echo $user | xargs)
    groups=$(echo $groups | xargs)

    # Create user with home directory
    if id "$user" &>/dev/null; then
        log_action "User $user already exists."
    else
        useradd -m $user
        if [[ $? -eq 0 ]]; then
            log_action "Created user $user."
        else
            log_action "Failed to create user $user."
            continue
        fi
    fi

    # Create personal group and add user to it
    groupadd -f $user
    usermod -aG $user $user

    # Add user to additional groups
    if [[ ! -z $groups ]]; then
        IFS=',' read -ra ADDR <<< "$groups"
        for group in "${ADDR[@]}"; do
            group=$(echo $group | xargs)
            groupadd -f $group
            usermod -aG $group $user
            log_action "Added $user to group $group."
        done
    fi

    # Set random password for user
    password=$(generate_password)
    echo "$user:$password" | chpasswd
    echo "$user,$password" >> $PASSWORD_FILE
    log_action "Set password for user $user."

done < $USER_LIST

chmod 600 $PASSWORD_FILE
log_action "User creation process completed."

