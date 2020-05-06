#!/bin/bash

#
# Script to add aliases for all the scripts to ~/.bash_aliases
# Firstly, it will add all the aliases to ~/.bash_aliases
# Then it will prompt the user to source ~/.bashrc or restart the terminal
#

echo "
# Aliases for CTF-bash-tools (https://github.com/PinkDraconian/CTF-bash-tools)
alias ctf-py=\"$(pwd)/scripts/ctf-py.sh\"
alias ctf-connect=\"$(pwd)/scripts/ctf-connect.sh\"
alias ctf-ex=\"$(pwd)/scripts/ctf-ex.sh\"
alias ctf-ssh=\"$(pwd)/scripts/ctf-ssh.sh\"" >> ~/.bash_aliases

# Prompt user to source ~/.bashrc or restart the terminal
echo "Aliases have been added! You can now use
	'ctf-py' to create a solve.py script
	'ctf-connect ip port' to create a connect.sh script
	'ctf-ex cmd' to see examples of a certain command
	'ctf-ssh' to generate an rsa keypair for ssh login
In order to use these, either run 'source ~/.bashrc' or restart the terminal.
If you upgraded the script, you can delete the old entries from ~/.bash_aliases"
