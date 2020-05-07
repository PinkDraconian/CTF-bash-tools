#!/bin/bash

#
# Can display examples for how commands are structured
# Following commands can be used:
# 	- gobuster
# 	- tty (How to upgrade a shell to tty)
#	- john
#	- ping (Set up a ping listen)
#	- find
# Usage: ctf-ex <CMD>
#

option=$(tr '[:upper:]' '[:lower:]' <<< "$1")  # Convert command choice to lowercase

if [[ $option == "-h" || $# != 1 ]]; then
	echo "Usage: ctf-ex <CMD>
Commands implemented
	- gobuster
	- tty
	- john
	- ping
	- find"
elif [[ $option == "gobuster" ]]; then
	echo "Enumerate directories on HTTP:
	gobuster dir --wordlist /usr/share/wordlists/dirb/big.txt --url <URL> [-x <EXTENSIONS, CSV>] [-o <OUTFILE>]
Enumerate directories on HTTPS:
	gobuster dir -k --wordlist /usr/share/wordlists/dirb/big.txt --url <URL> [-x <EXTENSIONS, CSV>] [-o <OUTFILE>]"
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
elif [[ $option == "ping" ]]; then
	echo "Setting up listener for pings
	tcpdump -i tun0 icmp and icmp[icmptype]=icmp-echo"
elif [[ $option == "find" ]]; then
	echo "Finding a file and dismissing permission denied messages
	find / -type f -name \"keyword\" 2>&1 | grep -v \"Permission denied\""
fi