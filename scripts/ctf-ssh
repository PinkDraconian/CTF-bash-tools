#!/bin/bash

#
# Script to create new ssh keypair (with empty password), set the correct permissions and tell the user where to upload them
#

# Checking if id_rsa already exists
if [ -f id_rsa ] || [ -f id_rsa.pub ]; then
    echo "[!] id_rsa or id_rsa.pub files already exist."
    exit 1
fi

# Creating keypair
ssh-keygen -t rsa -f id_rsa -P ""

# Setting correct permissions
chmod 600 id_rsa

# Message for user
echo "
Put the public key in ~/.ssh/authorized_keys
	echo \"$(cat id_rsa.pub)\" >> ~/.ssh/authorized_keys

Log in using
	ssh -i id_rsa user@ip"
