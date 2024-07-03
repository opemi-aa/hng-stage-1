# hng-stage-1-devops-task
## Automating User Management with Bash Scripting

As a SysOps engineer, managing user accounts efficiently is crucial. This Bash script, `create_users.sh`, automates the creation of user accounts based on input from a text file. Let's delve into how it works and its key features.

### Script Overview

The script performs several tasks:

1. **Logging**: It logs all actions to `/var/log/users_management.log`, capturing every step of user creation and password assignment.
   
2. **Password Management**: Random passwords are generated securely using OpenSSL and assigned to new user accounts.

3. **User and Group Creation**: Users are added with their personal group and optionally additional groups specified in the input file.

4. **Secure Password Storage**: Usernames and their corresponding passwords are stored in `/var/secure/users_passwords.csv` with restricted access permissions (chmod 600).

### Usage

To use the script, provide a text file (`<user_file>`) containing usernames and groups formatted as `username;groups`:

```bash
sudo ./create_users.sh <user_file>
```

### Example Input File

An example input file (`users.txt`) might look like this:

```
alice;sudo,dev
bob;dev,www-data
charlie;sudo,www-data
```

### Error Handling and Logging

The script checks if a user already exists before attempting to create them. If a user exists, it logs this information and proceeds to the next user in the input file.

### Technical Details and Security

- **Logging**: Actions are logged with timestamps to `/var/log/users_management.log` to track user creation and group assignments.
  
- **Password Security**: Passwords are securely generated and stored in `/var/secure/users_passwords.csv`, ensuring only privileged users can access this sensitive information.

### Learn More about HNG Internship

To explore more about the HNG Internship program and its opportunities, visit the following links:

- [HNG Internship](https://hng.tech/internship)
- [HNG Hire](https://hng.tech/hire)

### Conclusion

This Bash script simplifies and automates user management tasks, enhancing efficiency and ensuring consistency in user account creation across systems. By integrating error handling, logging, and secure password management, it meets the demands of modern system administration practices.

