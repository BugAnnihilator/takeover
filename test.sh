#!/bin/bash

# Function to create a user with a password
create_user() {
    local username=$1
    local password=$2

    # Check if the user already exists
    if id "$username" &>/dev/null; then
        echo "User $username already exists!"
    else
        # Create the user and set the password
        useradd "$username"
        echo "$username:$password" | chpasswd
        echo "User $username created successfully!"
    fi
}

# Prompt for the number of users to create
read -p "How many users do you want to create? " user_count

# Loop through the number of users
for ((i = 1; i <= user_count; i++)); do
    # Prompt for username
    read -p "Enter username for user $i: " username
    # Prompt for password (input hidden for security)
    read -s -p "Enter password for $username: " password
    echo
    # Confirm the password
    read -s -p "Confirm password for $username: " confirm_password
    echo

    # Check if passwords match
    if [ "$password" != "$confirm_password" ]; then
        echo "Passwords do not match for $username. Try again."
        ((i--))
        continue
    fi

    # Create the user
    create_user "$username" "$password"
done

echo "All users created!"