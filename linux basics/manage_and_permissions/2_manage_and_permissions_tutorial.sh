
# Create a new user called "new_user"
useradd new_user

# Add the new user to a group called "developers"
usermod -aG developers new_user

# Create a new group called "managers"
groupadd managers

# Change the ownership of a file to the new user
chown new_user:managers example.txt

# Change the permissions of the file to allow read and write access for the owner and group
chmod 660 example.txt