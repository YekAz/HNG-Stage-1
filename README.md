## Introduction:

User management is a critical aspect of system administration in Linux. Whether managing a small team or a large organization, administrators often face repetitive tasks such as creating user accounts, setting permissions, and ensuring security. Automating these tasks with bash scripting not only saves time but also reduces the risk of human error. In this article, we will explore how to automate user management using a bash script, providing a step-by-step guide to creating a script that reads user information from a file, creates users and groups, sets up home directories, and manages passwords securely.

## Setting Up the Environment:

Before we dive into scripting, we need to prepare our Linux environment. Ensure you have the necessary permissions to create users and groups. You can run the script with sudo to grant the required privileges.

## Creating the Script:

Let's create a bash script called create_users.sh that reads a text file containing usernames and groups, creates users, and manages their settings. The text file should have the format user;groups, where each line represents a user and their associated groups.# HNG-Stage-1

## Understanding the Script

- Initialization and Directory Setup: The script begins by setting up the log file and a secure directory for storing passwords. It ensures the directory exists and sets the appropriate permissions to keep it secure.

- Generating Random Passwords: The generate_password function uses OpenSSL to generate a random, secure password for each user.

- Logging Actions: The log_action function logs all actions with a timestamp, helping administrators track the script's activities.

- Reading the User List: The script reads a file containing usernames and associated groups. Each line in the file should follow the user;groups format.

- Creating Users: For each user, the script first checks if the user already exists. If not, it creates the user with a home directory.

- Assigning Groups: The script assigns the user to their personal group and any additional groups specified in the input file. It validates group names and logs any errors encountered during this process.

- Setting Passwords: A random password is generated for each user and set using the chpasswd command. The passwords are securely stored in the specified file with appropriate permissions.

## References
[HNG INTERNSHIP](https://hng.tech/internship)
[HNG TECH PREMIUM](https://hng.tech/premium)
[HNG HIRE](https://hng.tech/hire)
