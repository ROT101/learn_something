```bash
#!/bin/env bash   
# Create a new file called "example.txt" with some content
echo "Hello World!" > example.txt

# Display the contents of the file
cat example.txt

# Search for the word "World" in the file
grep "World" example.txt

# Replace the word "World" with "Universe" in the file
sed -i 's/World/Universe/g' example.txt

# Open the file in the nano editor
nano example.txt

```

[exercise](https://github.com/ROT101/learn_something/blob/main/linux%20basics/file_and_searching/3_file_and_searching_exercise.md)
