#!/bin/bash

#
# Script to create a connect.sh file that can be used to connect to a challenge
# Firstly, it checks if there are cmd arguments, if not, it prints a help message
# Then it checks if the connect.sh already exists
# Then it creates the actual file
# Lastly it makes it executable
#

# Help prompt for if no arguments are supplied
if [ $# -eq 0 ]
  then
    echo "Usage: ctf-connect ip port"
    exit 1
fi

# Checking if connect.sh already exists
if [ -f connect.sh ]; then
    echo "[!] connect.sh already exists."
    exit 1
fi

# Creating and filling file
echo "#!/bin/bash

nc $1 $2" > connect.sh

# Making file executable
chmod +x connect.sh
