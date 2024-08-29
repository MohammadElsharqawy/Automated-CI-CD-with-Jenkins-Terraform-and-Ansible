#!/bin/bash

ssh_config="$HOME/.ssh/config"

echo "
Host bastion
    HostName $1
    User ubuntu
    IdentityFile ~/.ssh/id_rsa
" > "$ssh_config"

# Add private IP with ProxyCommand to jump server
echo "
Host private-ec2 
    HostName $2
    User ubuntu
    IdentityFile ~/.ssh/id_rsa
    ProxyJump bastion
" >> "$ssh_config"

#to configure this, run this command in the terminal
#make sure to make it executable
#./ansible_ssh_configuration.sh '${EC2_PUBLIC_IP}' '${EC2_PRIVATE_IP}'