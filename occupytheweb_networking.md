# networking basiscs

**Objectives**

- Understand the basic components and terminology of networks
- Differentiate between types of networks: LAN, WAN, PAN, etc.
-  Comprehend the roles of MAC and IP addresses
------------------------
## 1. What is a Network?

    A network is a system that connects two or more computing devices to share resources and exchange data. Networks enable communication between devices through wired or wireless connections.

## 2. Types of Networks

    LAN (Local Area Network): Covers a small geographic area (home, office, school)

    WAN (Wide Area Network): Spans large distances (the Internet, corporate networks across locations)

    PAN (Personal Area Network): Very small network (Bluetooth devices, USB connections)

    MAN (Metropolitan Area Network): City-wide network (campus networks, city WiFi)

    WLAN (Wireless LAN): Wireless version of LAN (WiFi networks)

## 3. Hosts, Nodes, NICs

    Host: Any device connected to a network that provides or consumes services

    Node: Any device connected to a network (routers, switches, computers)

    NIC (Network Interface Card): Hardware component that connects a device to a network

## 4. MAC vs IP Address

 MAC Address:

        A Physical/hardware address Assigned by manufacturer 

        48-bit address (e.g., 00:1A:2B:3C:4D:5E)

        Used for local network communication

    IP Address:

        Logical address

        Assigned by network admin or DHCP

        32-bit (IPv4) or 128-bit (IPv6) address

        Used for routing across networks

## 5. Introduction to ARP and DHCP

    ARP (Address Resolution Protocol): Maps IP addresses to MAC addresses

    DHCP (Dynamic Host Configuration Protocol): Automatically assigns IP addresses to devices on a network
---------------
**Activities**

1. Diagram Your Home Network

Create a simple diagram showing:

    Your router/modem

    Connected devices (computers, phones, smart devices)

    Connection types (wired/wireless)

    Internet connection

2. Identify MAC and IP Addresses of Your Devices

Windows:

    Open Command Prompt

    Type ipconfig /all for IP and MAC addresses

MacOS:

    Open Terminal

    Type ifconfig for IP and MAC addresses

linux

    ifconfig && machanger -s [interface]

-------------------------------------------------
# OSI and TCP/IP Models
-------------------------------------------------
**Objectives**

- Understand the 7 layers of the OSI model.
- Learn the 4 layers of the TCP/IP model.
- Relate real-world protocols to each layer.
--------------------------------------------------

**Lessons**

## 1. The OSI Model: 7 Layers

The Open Systems Interconnection (OSI) model is a conceptual framework that standardizes network functions into 7 layers:

        Layer |	Name	   Function	                                     | Example Protocols & Devices
        _______________________________________________________________________________________________
        7	  | Application	User interface, network services	         | HTTP, FTP, SMTP, DNS 
        6	  | Presentation	Data translation, encryption	         | SSL/TLS, JPEG, MPEG
        5	  | Session	Establishes, manages, and terminates connections | NetBIOS, RPC
        4	  | Transport	End-to-end communication, error recovery	 | TCP, UDP
        3	  | Network	Logical addressing, routing	                     | IP, ICMP, Routers
        2	  | Data Link	Physical addressing (MAC), error detection	 | Ethernet, Switches, MAC
        1	  | Physical	Raw bit transmission over a medium	         | Cables, Hubs, Repeaters
        ________________________________________________________________________________________________

**Data Flow:**

    Encapsulation (Sender): Data moves down the layers (Application → Physical).

    Decapsulation (Receiver): Data moves up the layers (Physical → Application).

## 2. The TCP/IP Model

The TCP/IP model is a simplified version used in real-world networking:

        TCP/IP Layer   | OSI Equivalent                                  | Key Protocols
        ________________________________________________________________________________________
        Application	   | Layers 5-7 (Session, Presentation, Application) | HTTP, FTP, DNS, SMTP
        Transport	   | Layer 4 (Transport)	                         | TCP, UDP
        Internet	   | Layer 3 (Network)	                             | IP, ICMP, ARP
        Network Access | Layers 1-2 (Physical + Data Link)	             | Ethernet, Wi-Fi, MAC
        ___________________________________________________________________________________________

**Key Differences from OSI:**

    Combines Application, Presentation, and Session into a single Application layer.

    Merges Physical + Data Link into Network Access.

## 3. Protocols and Encapsulation

    Encapsulation: Adding headers (and sometimes trailers) at each layer.

        Example: HTTP → TCP → IP → Ethernet

    Protocol Examples:

        Application: HTTP (web), FTP (file transfer), SMTP (email)

        Transport: TCP (reliable), UDP (fast, connectionless)

        Internet: IP (routing), ICMP (ping)

        Network Access: Ethernet (LAN), Wi-Fi (wireless)

**Activities**
1. Memorize the OSI Model (Mnemonic Devices)

- From Layer 7 to Layer 1:

        "All People Seem To Need Data Processing"

        Application → Presentation → Session → Transport → Network → Data Link → Physical

- From Layer 1 to Layer 7:

        "Please Do Not Throw Sausage Pizza Away"

        Physical → Data Link → Network → Transport → Session → Presentation → Application

2. Map Common Tools to Their Respective Layers

        Tool/Protocol | OSI Layer    | TCP/IP Layer
        _____________________________________________
        HTTP, FTP     | Application  | Application
        SSL/TLS       | Presentation | Application
        NetBIOS       | Session      | Application
        TCP, UDP      | Transport    | Transport
        IP, ICMP      | Network      | Internet
        Ethernet, MAC | Data Link    | Network Access
        Cables, Hubs  | Physical     | Network Acces
        ______________________________________________

- Practical Examples:

        Ping (ICMP) → Network (OSI) / Internet (TCP/IP)

        Web Browsing (HTTP) → Application (Both)

        Switches → Data Link (OSI) / Network Access (TCP/IP)

        Routers → Network (OSI) / Internet (TCP/IP)

## IP Addressing and Routing
**Objectives**

- Learn about IPv4 addressing and its structure.

- Understand subnetting and CIDR notation.

- Explore routing basics and NAT (Network Address Translation).

**Lessons**
## 1. IPv4 Addressing Structure

    IPv4 Address: A 32-bit address written in dotted-decimal notation (e.g., 192.168.1.1).

    Parts of an IP Address:

        Network Portion: Identifies the network.

        Host Portion: Identifies the device on the network.

    Default Subnet Masks:

        Class A: 255.0.0.0 (e.g., 10.0.0.1)

        Class B: 255.255.0.0 (e.g., 172.16.0.1)

        Class C: 255.255.255.0 (e.g., 192.168.1.1)

**Special Addresses:**

    Loopback: 127.0.0.1 (tests local network stack)

    APIPA (Automatic Private IP): 169.254.x.x (when DHCP fails)

## 2. Private vs. Public IPs
        Private IPs (Non-Routable) | Public IPs (Routable on Internet)
        ______________________________________________________________
        Used inside local networks | Used globally on the Internet
        Defined in RFC 1918:	   | Assigned by ISPs
        - 10.0.0.0/8	           | Example: 203.0.113.5
        - 172.16.0.0/1             | Must be unique worldwide
        - 192.168.0.0/16           | NAT translates private → public
        ______________________________________________________________

## 3. Subnetting and CIDR

        🔹 Subnetting = Dividing a network into smaller sub-networks.
        🔹 CIDR (Classless Inter-Domain Routing) = Represents subnet masks concisely (e.g., /24 = 255.255.255.0).

**Example:**

    192.168.1.0/24 →

        Subnet Mask: 255.255.255.0

        Usable Hosts: 192.168.1.1 to 192.168.1.254 (254 hosts)

**Subnetting Exercise:**

    Given 192.168.1.0/24, divide into 4 subnets:

        New subnet mask: 255.255.255.192 (/26)

        Subnets:

            192.168.1.0/26 (Hosts: 1-62)

            192.168.1.64/26 (Hosts: 65-126)

            192.168.1.128/26 (Hosts: 129-190)

            192.168.1.192/26 (Hosts: 193-254)

**4. NAT and DHCP**

- NAT (Network Address Translation):

    Converts private IPs to a public IP for Internet access.

    Types:

        Static NAT (1 private → 1 public)

        Dynamic NAT (pool of public IPs)

        PAT (Port Address Translation) (Many private → 1 public, using ports)

- DHCP (Dynamic Host Configuration Protocol):

    Automatically assigns IP addresses to devices.

    Process (DORA):

        Discover (Client sends DHCP Discover)

        Offer (Server responds with an IP offer)

        Request (Client requests the offered IP)

        Acknowledge (Server confirms the lease)

Activities
1. Subnetting Exercises

Problem 1:

    Given 172.16.0.0/16, create 8 subnets.

        New subnet mask: 255.255.224.0 (/19)

        Subnets:

            172.16.0.0/19

            172.16.32.0/19

            172.16.64.0/19

            ... up to 172.16.224.0/19

Problem 2:

    Given 10.0.0.0/8, divide into 64 subnets.

        New subnet mask: 255.252.0.0 (/10)

2. View and Interpret Your IP Routing Table

- Windows:

        Open Command Prompt

        Type:
        sh route print

        Look for Network Destination, Netmask, Gateway, and Interface.

- Linux/Mac:

        Open Terminal

        Type:
        sh netstat -rn

    Example Output:

        Destination      Gateway          Genmask          Flags   Interface  
        192.168.1.0      0.0.0.0         255.255.255.0   U       eth0  
        0.0.0.0          192.168.1.1     0.0.0.0         UG      eth0  

            192.168.1.0/24 = Local network

            0.0.0.0 = Default route (Internet)

## Ports and Protocols
**Objectives**

    Understand how TCP and UDP work.

    Identify key ports and services (e.g., HTTP, SSH, DNS).

    Examine packet structure and the TCP handshake.

**Lessons**
## 1. TCP vs. UDP

    Feature	    | TCP  (Transmission Control Protocol)          | UDP (User Datagram Protocol)
    Connection	| Connection-oriented (3-way handshake)	        | Connectionless (no handshake)
    Reliability	| Reliable (acknowledgments, retransmissions)   | Unreliable (no retransmissions)
    Ordering	| In-order delivery	                            | No guaranteed order
    Speed	    | Slower (overhead)	                            | Faster (low latency)
    Use Cases	| Web (HTTP), Email (SMTP), File Transfer (FTP) | Video Streaming, VoIP, DNS, Gaming

**TCP Features:**

    Flow Control (prevents overwhelming the receiver)

    Error Recovery (retransmits lost packets)

**UDP Features:**

    Minimal overhead (good for real-time apps)

    No congestion control (can lose packets under heavy load)

## 2. Common Ports and Services
        Port  | Protocol	| Service	Description
        _________________________________________________
        20/21 |	TCP	FTP	    | File Transfer Protocol
        22	  | TCP	SSH	    | Secure Shell (remote login)
        23	  | TCP	Telnet	| Unencrypted remote access
        25	  | TCP	SMTP	| Email sending (Mail Transfer)
        53	  | UDP/TCP	DNS | Domain Name System
        80    | TCP	HTTP	| Web traffic (unencrypted)
        443	  | TCP	HTTPS	| Encrypted web traffic
        110	  | TCP	POP3	| Email retrieval
        143	  | TCP	IMAP	| Email synchronization
        3389  | TCP	RDP	    | Remote Desktop Protocol
        _________________________________________________

         Well-Known Ports: 0-1023 (System services)
         Registered Ports: 1024-49151 (Applications)
         Dynamic/Private Ports: 49152-65535 (Temporary connections)

## 3. TCP/IP Packet Anatomy

- TCP Segment Structure:

        Field	                         | Description
        _______________________________________________________________________
        Source Port	                     | Sender’s port
        Destination Port	             | Receiver’s port
        Sequence Number	                 | Tracks packet order
        Acknowledgment Number	         | Confirms received data
        Flags (SYN, ACK, FIN, RST, etc.) |	Control connection state
        Window Size	Flow control         | (how much data receiver can accept)
        _______________________________________________________________________

- UDP Datagram Structure:

        Simpler: Source Port, Destination Port, Length, Checksum.

## 4. TCP Handshake (3-Way Handshake)

    SYN → Client sends SYN (Synchronize) to server.

    SYN-ACK → Server responds with SYN-ACK.

    ACK → Client sends ACK (Acknowledgment).

- Connection Termination (4-Way Handshake):

        FIN → One side requests closure.
    
        ACK → Other side acknowledges.
    
        FIN → Other side also closes.
    
        ACK → Final confirmation.

**Activities**
## 1. Analyze TCP Flags Using Wireshark

    Download Wireshark (wireshark.org).

    Capture Traffic:

        Filter for tcp or http.

    Identify Flags:

        SYN = New connection

        ACK = Acknowledgment

        FIN = Connection termination

        RST = Abrupt reset

- Example:

        Open a website in a browser and observe the SYN → SYN-ACK → ACK sequence.

2. Run a Basic Port Scan Using Nmap

        Install Nmap (nmap.org).
    
        Scan Your Local Network:
        sh

nmap -sV 192.168.1.0/24

    -sV = Detect service versions.

Scan a Single Device:

    sh

    nmap -p 1-1000 192.168.1.1

    Checks ports 1-1000 on a router.

Common Nmap Flags:

        -sS = Stealth scan (SYN scan)
    
        -O = OS detection
    
        -A = Aggressive scan (OS + version detection)

## Command-Line Network Tools

**Objectives**

    Use CLI tools for network diagnostics.

    Understand basic traffic monitoring techniques.

**Lessons**

## 1. ifconfig vs. ip (Network Interface Configuration)

        Command	          | Description                             | Example
        ____________________________________________________________________________
        ifconfig (Legacy) |	Displays/sets network interfaces	    | ifconfig eth0
        ip (Modern)	      | More powerful replacement for ifconfig	| ip addr show
        ___________________________________________________________________________

**Key Uses:**

    Check IP addresses, MAC addresses, and interface status.

    Enable/disable interfaces (sudo ifconfig eth0 up/down).

## 2. ping, traceroute, nslookup (Connectivity & DNS)

        Command	                          | Purpose	                                     | Example
        __________________________________________________________________________________________________________
        ping	                          | Tests reachability & latency                 | ping google.com
        traceroute                        | (tracert on Windows) Shows path packets take |	traceroute google.com
        nslookup                          | Queries DNS records	nslookup                 | example.com
        ____________________________________________________________________________________________________________

**Advanced ping Flags:**

    -c 4 (Send 4 packets) → ping -c 4 google.com

    -i 2 (Interval of 2 sec) → ping -i 2 google.com

## 3. netstat vs. ss (Network Statistics)
        Command	         | Description	                     | Example
        ____________________________________________________________________
        netstat (Legacy) | Shows connections, routing tables | netstat -tuln
        ss (Modern)	     | Faster replacement for netstat	 | ss -tuln
        ____________________________________________________________________

**Common Flags:**

    -t = TCP connections

    -u = UDP connections

    -l = Listening ports

    -n = Show numeric addresses (no DNS resolution)

## 4. Introduction to nmap (Network Scanning)

- Basic Usage:

        nmap -sV 192.168.1.1
    
        -sV = Service detection
    
        -O = OS detection

- Common Scan Types:

        Scan Type	 | Command	                   |Purpose
        ________________________________________________________________________________
        Ping Scan    | nmap -sn 192.168.1.0/24	   | Discovers live hosts
        Port Scan	 | nmap -p 80,443 192.168.1.1  | Checks specific ports
        Stealth Scan | nmap -sS 192.168.1.1        | SYN scan (avoids full handshake)
        __________________________________________________________________________
**Activities**

1. Explore Network Interfaces on Your System

- Linux/Mac:
        sh
        
        ip addr show   # Modern
        ifconfig       # Legacy

Look for:

    Interface names (eth0, wlan0).

    IP & MAC addresses.

    Status (UP = active).

- Windows:
        sh
        
        ipconfig /all

2. Use nmap to Scan Local Devices

    Find your local subnet:

        sh
        ip route show  # Linux/Mac
        ipconfig       # Windows
        
        (Example: 192.168.1.0/24)
        
        Scan for live hosts:
        sh
        
        nmap -sn 192.168.1.0/24
        
        Scan a specific device:
        sh

        nmap -A 192.168.1.1

        (-A = Aggressive scan: OS + service detection)

## Network Topologies and Devices
**Objectives**

    Understand physical and logical network topologies.

    Learn how network devices (hubs, switches, routers) operate.

    Explore firewall basics and their role in networks.

**Lessons**
## 1. Network Topologies

Topologies define how devices are physically or logically connected.
    
**Physical Topologies**

        Topology           | Description                                                | Pros                           | Cons
        _________________________________________________________________________________________________________________________________
        Star               | All devices connect to a central hub/switch	            | Easy to manage, fault-tolerant | Single point of failure (hub/switch)
        Bus	               | All devices share a single backbone cable	                | Simple, low cost	             | Entire network fails if cable breaks
        Ring               | Devices form a closed loop (data travels in one direction) | No collisions                  | One device failure breaks the ring
        Mesh               | Every device connects to every other device	            | Highly redundant, reliable	 | Expensive, complex cabling
        Hybrid             | Mix of two or more topologies (e.g., star-bus)	            | Flexible, scalable	         | More complex to configure
        __________________________________________________________________________________________________________________________________
        
    Logical Topologies

        Ethernet (Bus-like) → Uses CSMA/CD (Collision Detection).   
        Token Ring → Devices pass a token to transmit data (rare today).

## 2. Network Devices

        Device	 | Layer (OSI)	       | Function
        ______________________________________________________________________________
        Hub	     | Layer 1 (Physical)  | Broadcasts data to all ports (dumb repeater)
        Switch	 | Layer 2 (Data Link) | Forwards data based on MAC addresses
        Router	 | Layer 3 (Network)   | Routes traffic between different networks
        Firewall | Layer 3/4/7	       | Filters traffic based on security rules
        ______________________________________________________________________________

- Key Differences:

        Hub → All devices see all traffic (inefficient).
    
        Switch → Learns MACs, sends data only to the correct device.
    
        Router → Connects different networks (e.g., LAN to Internet).

3. Firewall Basics

    Filters traffic based on rules (IP, port, protocol).

    Types:

        Packet-filtering (Basic, works at Layer 3/4)

        Stateful (Tracks connections, more secure)

        Next-Gen (NGFW) (Deep packet inspection, Layer 7 filtering)

-  Common Firewall Rules:

        Allow HTTP (Port 80) but block FTP (Port 21).
    
        Block ICMP (Disable ping responses for security).

**Activities**

1. Create a Visual Map of a Simulated Network

Scenario: Design a small office network with:

    1 Router (connected to the Internet)

    2 Switches (one for each department)

    5 Computers (3 in Sales, 2 in HR)

    1 Firewall (between router and switches)

Tools to Use:

    Draw.io (Free diagramming tool)

    Cisco Packet Tracer (Network simulator)

Example Diagram:

        [Internet]  
        |  
        [Router]  
        |  
        [Firewall]  
        /   \  
        [Switch A]    [Switch B]  
        |  |  |      |     |  
        PC1 PC2 PC3   HR-PC1 HR-PC2  

Key Elements to Label:

    IP ranges (e.g., 192.168.1.0/24 for Sales, 192.168.2.0/24 for HR)

    Device types (Router, Switch, Firewall)

    Connections (Wired/Wireless)

## Wireless Networks and Attacks
**Objectives**

- Understand Wi-Fi standards (802.11) and encryption protocols (WEP, WPA, WPA2, WPA3).
- Identify common Wi-Fi attacks (deauth, evil twin, KRACK).
- Learn ethical hacking tools (Aircrack-ng, Wireshark).

**Lessons**
## 1. 802.11 Wi-Fi Standards

        Standard           | Frequency   | Max Speed | Range
        _______________________________________________________
        802.11a	           | 5 GHz	     | 54 Mbps   | Short
        802.11b	           | 2.4 GHz     | 11 Mbps	 | Medium
        802.11g	           | 2.4 GHz     | 54 Mbps	 | Medium
        802.11n (Wi-Fi 4)  | 2.4/5 GHz   | 600 Mbps	 | Long
        802.11ac (Wi-Fi 5) | 5 GHz	     | 6.9 Gbps	 | Medium
        802.11ax (Wi-Fi 6) | 2.4/5/6 GHz | 9.6 Gbps	 | Long
        _________________________________________________________
- Key Takeaways:

        2.4 GHz → Better range, more interference.
    
        5 GHz → Faster speeds, less interference.
    
        6 GHz (Wi-Fi 6E) → New, ultra-fast, less congestion.

## 2. Wi-Fi Security Protocols

        Protocol	                   | Encryption	| Security Level              | Flaws
        _________________________________________________________________________________________________
        WEP (Wired Equivalent Privacy) | RC4 (Weak)	| Broken                      | Crackable in minutes
        WPA (Wi-Fi Protected Access)   | TKIP + RC4	| Weak                        | Vulnerable to attacks
        WPA2	                       | AES-CCMP   | Strong (if strong password) | KRACK attack (2017)
        WPA3	                       | AES-GCMP   | Very Strong                 | Resistant to KRACK
        _________________________________________________________________________________________________

- Best Practices:

        Avoid WEP/WPA (use WPA2/WPA3).

        Use strong passwords (12+ chars, symbols, numbers).

        Disable WPS (Wi-Fi Protected Setup – easily hacked).

## 3. Common Wi-Fi Attacks

        Attack	                | How It Works	                    | Tool Used
        ___________________________________________________________________________
        Deauthentication Attack | Forces devices to disconnect	    | aireplay-ng
        Evil Twin	            | Fake Wi-Fi AP to steal data	    | airbase-ng
        KRACK Attack            | Exploits WPA2 handshake	        | Wireshark
        WPS PIN Attack          | Brute-forces router PIN	        | reaver
        WPA Handshake Capture   |  Captures login hash for cracking	| airodump-ng
        ___________________________________________________________________________

## 4. Aircrack-ng Suite (Ethical Hacking Tool)

Aircrack-ng is a Wi-Fi security auditing toolset used to:

    Scan networks (airodump-ng)

    Capture handshakes (airodump-ng)

    Perform deauth attacks (aireplay-ng)

    Crack passwords (aircrack-ng)

- Legal Note: Only use on your own networks or with explicit permission.
- 
**Activities**
1. Scan for Wi-Fi Networks & Analyze Encryption

Tools Needed:

    Kali Linux (or any Linux with Aircrack-ng)

    Wireless adapter (supports monitor mode)

Steps:

    Enable monitor mode:
    bash

airmon-ng start wlan0

Scan networks:

    airodump-ng wlan0mon

    Analyze output:

        Look for BSSID (MAC), ESSID (name), encryption (WEP/WPA/WPA2).

2. Capture a WPA Handshake

Steps:

    Target a network:
    bash

    airodump-ng -c 6 --bssid 00:11:22:33:44:55 -w capture wlan0mon

    -c 6 → Channel

    --bssid → Router MAC

    -w capture → Save to file

Force a handshake (deauth attack):

    aireplay-ng -0 2 -a 00:11:22:33:44:55 -c AA:BB:CC:DD:EE:FF wlan0mon

    -0 2 → Send 2 deauth packets

    -a → AP MAC

    -c → Client MAC

Check for handshake:

    Aircrack-ng will show "WPA handshake captured".

Crack the password (optional):

    aircrack-ng -w rockyou.txt capture.cap

    -w rockyou.txt → Wordlist

# Firewalls and Packet Filtering
**Objectives**

    Understand Linux iptables and its role in packet filtering.

    Learn how to create, modify, and delete firewall rules.

    Set default policies and manage chains (INPUT, OUTPUT, FORWARD).

**Lessons**
## 1. iptables Overview

iptables is a Linux firewall that filters traffic using tables, chains, and rules.
- Key Components

        Component | Description
        _________________________________________________________________
        Tables	  | filter (default), nat, mangle, raw
        Chains	  | INPUT (incoming), OUTPUT (outgoing), FORWARD (routed)
        Rules	  | Define allow/deny actions based on IP/port/protocol
        __________________________________________________________________

- Common Policies:

        ACCEPT → Allow traffic
    
        DROP → Silently block
    
        REJECT → Block + send error

## 2. Writing Basic Rules
Rule Syntax

    iptables -A [CHAIN] -p [PROTOCOL] --dport [PORT] -j [ACTION]

        Flag    | Meaning	       | Example
        __________________________________________
        -A      | Append rule	   | -A INPUT
        -p	    | Protocol	       | -p tcp 
        --dport | Destination port | --dport 22
        -j	    | Jump to action   | -j ACCEPT
        __________________________________________
Example Rules

Allow SSH (Port 22):

    iptables -A INPUT -p tcp --dport 22 -j ACCEPT

Block Ping (ICMP):

    iptables -A INPUT -p icmp -j DROP

Allow HTTP/HTTPS:

    iptables -A INPUT -p tcp --dport 80 -j ACCEPT  
    iptables -A INPUT -p tcp --dport 443 -j ACCEPT

3. Default Policies and Chains

Set default actions if no rule matches:

    iptables -P INPUT DROP    # Block all incoming by default  
    iptables -P OUTPUT ACCEPT # Allow all outgoing  
    iptables -P FORWARD DROP  # Block forwarded traffic  

- View Rules:
  
        iptables -L -v  # List all rules  
        iptables -L -n  # Show IPs as numbers (no DNS lookup)  

**Activities**
1. Configure iptables to Allow/Block Traffic

Task:

    Allow SSH (22), HTTP (80), HTTPS (443).

    Block all other incoming traffic.

Solution:

Set default policies:

    iptables -P INPUT DROP  
    iptables -P OUTPUT ACCEPT  

Allow SSH, HTTP, HTTPS: 

    iptables -A INPUT -p tcp --dport 22 -j ACCEPT  
    iptables -A INPUT -p tcp --dport 80 -j ACCEPT  
    iptables -A INPUT -p tcp --dport 443 -j ACCEPT  

Allow loopback (important for system services) : 

    iptables -A INPUT -i lo -j ACCEPT  

Verify:
bash

iptables -L -v  # Check if rules are applied  

2. Flush and Reset iptables Settings

Task:

    Delete all rules and reset to default allow.

Solution:

Flush all rules :

    iptables -F  

Reset policies to ACCEPT :

    iptables -P INPUT ACCEPT  
    iptables -P OUTPUT ACCEPT  
    iptables -P FORWARD ACCEPT  

Verify  
iptables -L  


# Network Sniffing and Analysis
Objectives

    Use packet sniffers (tcpdump, Wireshark) to analyze network traffic.

    Understand how to filter and interpret captured data.

    Learn how to follow TCP streams for deeper analysis.

Lessons
1. tcpdump Basics

tcpdump is a command-line packet analyzer that captures live traffic.
Basic Usage
bash

sudo tcpdump -i eth0  # Capture on interface eth0

Common Flags

        Flag | Description	                | Example
        ______________________________________________________
        -i	 | Interface	                | -i wlan0
        -n	 | No DNS resolution (show IPs)	| -n
        -c	 | Capture X packets	        | -c 100
        -w	 | Save to file	                | -w capture.pcap
        -r	 | Read from file	            | -r capture.pcap
        _______________________________________________________
Filtering Traffic
bash

sudo tcpdump -i eth0 host 192.168.1.1  # Filter by IP  
sudo tcpdump -i eth0 port 80           # Filter by port  
sudo tcpdump -i eth0 tcp               # Only TCP traffic  

2. Wireshark Deep Dive

Wireshark is a GUI-based packet analyzer with advanced features.
Key Features

    Live capture and offline analysis.

    Protocol decoding (HTTP, DNS, TCP, etc.).

    Color-coding for easier analysis.

    Follow TCP Stream (reconstructs full conversations).

Basic Filters
        Filter	               | Description
        ________________________________________________
        ip.addr == 192.168.1.1 | Filter by IP
        tcp.port == 80	       | Filter by port
        http	               | Show only HTTP traffic
        dns	                   | Show only DNS queries
        _________________________________________________

3. Filters and Stream Following
Following a TCP Stream

    Right-click a packet → Follow → TCP Stream.

    Wireshark reconstructs the entire conversation (HTTP requests, FTP transfers, etc.).

Advanced Filters

    Find failed login attempts:
    text

http.request.method == POST && http contains "login"

Detect DNS queries:
text

    dns.qry.name contains "google.com"

Activities
1. Capture and Filter Traffic Using Wireshark

Task:

    Capture HTTP traffic and analyze a web request.

Steps:

    Open Wireshark → Select interface (eth0, wlan0).

    Apply filter: http

    Open a website in your browser.

    Inspect the HTTP GET/POST requests.

2. Follow a TCP Stream to Analyze Data

Task:

    Capture SSH traffic and follow the encrypted stream.

Steps:

    Start capture → Filter: tcp.port == 22

    SSH into a server (e.g., ssh user@192.168.1.1).

    Stop capture → Right-click a packet → Follow TCP Stream.

    Observe the encrypted payload (no plaintext).
