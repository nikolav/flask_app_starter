#!/bin/bash

USERNAME=$(whoami)

# Update system packages
yes | sudo apt update 
yes | sudo apt-get update 

# Install essential tools
yes | sudo apt-get install make build-essential autoconf automake libtool pkg-config cmake ninja-build uuid-dev 
yes | sudo apt-get install unzip zip software-properties-common lsb-release apt-transport-https htop net-tools 
yes | sudo apt-get install git curl wget ca-certificates 
yes | sudo apt-get install libssl-dev libffi-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev 
yes | sudo apt-get install gnupg ufw unattended-upgrades 

# Docker Installation
yes | sudo apt-get update 
yes | sudo apt-get install ca-certificates curl gnupg lsb-release 
sudo install -m 0755 -d /etc/apt/keyrings 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg 
sudo chmod a+r /etc/apt/keyrings/docker.gpg 
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" |  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
yes | sudo apt-get update 
yes | sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 
sudo systemctl enable docker 
sudo systemctl start docker 
sudo usermod -aG docker $USERNAME 

#Cleanup
yes | sudo apt-get autoremove 
yes | sudo apt-get clean 
