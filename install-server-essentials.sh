#!/usr/bin/env bash
# set -euo pipefail

# Use the real user (not root) for docker group
USERNAME="${SUDO_USER:-$USER}"

###############################################################################
# Prevent interactive daemon-restart prompts (needrestart)
###############################################################################
sudo mkdir -p /etc/needrestart/conf.d
sudo bash -c 'echo "nrconf{restart} = \"a\";" > /etc/needrestart/conf.d/99-auto-restart.conf'

# Global noninteractive environment
export DEBIAN_FRONTEND=noninteractive

###############################################################################
# 1) Update & Upgrade
###############################################################################
sudo apt-get update -yq
sudo apt-get upgrade -yq

###############################################################################
# 2) Install essential tools
###############################################################################
sudo apt-get install -yq \
  make build-essential autoconf automake libtool pkg-config cmake ninja-build uuid-dev \
  unzip zip software-properties-common lsb-release apt-transport-https htop net-tools \
  git curl wget ca-certificates \
  libssl-dev libffi-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
  gnupg ufw unattended-upgrades

###############################################################################
# 3) Docker installation (official repo)
###############################################################################
# Add Docker’s official GPG key & repo
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
   https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update after adding Docker repo
sudo apt-get update -yq

# Install Docker engine & plugins
sudo apt-get install -yq \
  docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable --now docker

# Add current user to docker group
sudo usermod -aG docker "$USERNAME"

###############################################################################
# 4) Nginx installation
###############################################################################
sudo apt-get install -yq nginx

sudo ufw allow 'Nginx Full'
sudo ufw --force enable

sudo systemctl enable --now nginx

###############################################################################
# 5) Cleanup
###############################################################################
sudo apt-get autoremove -yq
sudo apt-get clean -y
