```bash
#!/bin/env bash
# Create a new user called "new_user"
useradd new_user

# add a new group called "developers"
groupadd developers 

# Add the new user to a group called "developers"
usermod -aG developers new_user

# Change the ownership of a file to the new user
chown new_user:developers example.txt

# Change the permissions of the file to allow read and write access for the owner and group
chmod 660 example.txt
```
---------------------------------------------------------
[exercise](https://github.com/ROT101/learn_something/blob/main/linux%20basics/manage_and_permissions/3_manage_and_permissions_exercise.md)
