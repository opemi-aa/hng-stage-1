#!/bin/bash

# Log file
LOG_FILE="/var/log/users_management.log"
# Password file
PASSWORD_FILE="/var/secure/users_passwords.csv"

# Create necessary directories if they don't exist
mkdir -p /var/secure
touch "$LOG_FILE"
touch "$PASSWORD_FILE"
chmod 600 "$PASSWORD_FILE"

# Function to log actions
log_action() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" >> "$LOG_FILE"
}

# Function to generate random passwords
generate_password() {
    openssl rand -base64 12
}

# Check if the input file is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <user_file>"
    exit 1
fi

USER_FILE="$1"

# Read the input file line by line
while IFS=';' read -r username groups; do
    # Remove leading and trailing whitespace
    username=$(echo "$username" | xargs)
    groups=$(echo "$groups" | xargs)

    # Check if user already exists
    if id "$username" &>/dev/null; then
        log_action "User $username already exists."
        continue
    fi

    # Create the user and personal group
    useradd -m -s /bin/bash -g "$username" "$username"
    log_action "Created user $username with personal group $username."

    # Add user to additional groups
    IFS=',' read -r -a group_array <<< "$groups"
    for group in "${group_array[@]}"; do
        group=$(echo "$group" | xargs)
        if ! getent group "$group" &>/dev/null; then
            groupadd "$group"
            log_action "Created group $group."
        fi
        usermod -aG "$group" "$username"
        log_action "Added user $username to group $group."
    done

    # Generate and set a random password
    password=$(generate_password)
    echo "$username:$password" | chpasswd
    log_action "Set password for user $username."

    # Save the username and password to the secure file
    echo "$username,$password" >> "$PASSWORD_FILE"
done < "$USER_FILE"

echo "User creation process completed."

