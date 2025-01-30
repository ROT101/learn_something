```bash
#test connectivity 
ping localhost

# Securely connect to a remote server
ssh bandit0@bandit.labs.overthewire.org -p 2220 #password is "bandits0" cntrl + c to exit

#listen for incoming connections 
netcat -l -p 12345 

#sending data to receiver
netcat localhost 12345 

# Download a file from the internet
wget https://thevirtualmonkey.files.wordpress.com/2014/02/tcp_ip.jpg

# Display network statistics
netstat -an
```
-----------------------------------------------
[exercise](https://github.com/ROT101/learn_something/blob/main/linux%20basics/networking/3_networking_exercise.md)
