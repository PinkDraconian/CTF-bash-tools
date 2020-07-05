#!/bin/bash

#
# Can display examples for how commands are structured
# Following commands can be used:
# 	- gobuster
# 	- tty (How to upgrade a shell to tty)
#	- john
#	- ping (Set up a ping listen)
#	- find
#	- pwntools
#	- sqlmap
# 	- crackmapexec
# 	- smbclient.py
#	- mount
# Usage: ctf-ex <CMD>
#

option=$(tr '[:upper:]' '[:lower:]' <<< "$1")  # Convert command choice to lowercase

if [[ $option == "-h" || $# != 1 ]]; then
	echo "Usage: ctf-ex <CMD>
Commands implemented
	- gobuster
	- crackmapexec
	- tty
	- john
	- ping
	- find
	- pwntools
	- sqlmap
	- smbclient.py
	- mount"
elif [[ $option == "crackmapexec" ]]; then
	echo "Bruteforce smb
	crackmapexec smb 10.10.10.192 -u users -p pass
Bruteforce winrm
	crackmapexec winrm 10.10.10.192 -u users -p pass"
elif [[ $option == "gobuster" ]]; then
	echo "Enumerate directories on HTTP:
	gobuster dir --wordlist /usr/share/wordlists/dirb/big.txt --url <URL> [-x <EXTENSIONS, CSV>] [-o <OUTFILE>]
Enumerate directories on HTTPS:
	gobuster dir -k --wordlist /usr/share/wordlists/dirb/big.txt --url <URL> [-x <EXTENSIONS, CSV>] [-o <OUTFILE>]
Enumerate vhosts:
	gobuster vhost --wordlist /usr/share/wordlists/SecLists/Discovery/DNS/fierce-hostlist.txt --url <URL>"
elif [[ $option == "tty" ]]; then
	echo "Fully upgrading to TTY shell
	python3 -c 'import pty; pty.spawn(\"/bin/bash\")'
	ctrl+z
	echo $TERM && tput lines && tput cols
	stty raw -echo
	fg
	export SHELL=bash
	export TERM=xterm-256color
	stty rows 24 columns 121"
elif [[ $option == "john" ]]; then
	echo "Cracking hash
	john --wordlist=/usr/share/wordlists/rockyou.txt hash_file"
elif [[ $option == "mount" ]]; then
	echo "Mount a shared folder
	mount -t cifs -o username=user,password=password //x.x.x.x/share /mnt/share"
elif [[ $option == "ping" ]]; then
	echo "Setting up listener for pings
	tcpdump -i tun0 icmp and icmp[icmptype]=icmp-echo"
elif [[ $option == "find" ]]; then
	echo "Finding a file and dismissing permission denied messages
	find / -type f -name \"keyword\" 2>&1 | grep -v \"Permission denied\""
elif [[ $option == "pwntools" ]]; then
	echo "Making a remote connection
	io = remote('ip', port)
Setting debug mode
	context.log_level = 'DEBUG'"
elif [[ $option == "smbclient.py" ]]; then
	echo "Login
	smbclient.py DOMAIN/USERNAME:PASS@IP"
elif [[ $option == "sqlmap" ]]; then
	echo "SQLi testing from saved request from burp
	sqlmap --level 5 --risk 3 --batch -r <FILE>
SQLi from GET request
	sqlmap --level 5 --risk 3 --batch -u <URL>"
fi