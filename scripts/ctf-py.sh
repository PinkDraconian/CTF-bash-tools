#!/bin/bash

#
# Creates a solve.py file initialized with a
#	- Shebang
# 	- Main function
#	- Calling the main function if __name__ == __main__
# It first will check if the file doesn't already exists to make sure we're not overriding anything.
# Then it will create the file
# Lastly, it will make the file executable
# 

# Check if solve.py doesn't already exist
if [ -f solve.py ]; then
    echo "[!] solve.py already exists."
    exit 1
fi

# Making the file
echo "#!/usr/bin/env python3

def main():
	pass


if __name__ == '__main__':
	main()" > solve.py

# Making the file executable
chmod +x solve.py
