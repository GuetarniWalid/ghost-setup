#!/bin/bash

# Update the package list
sudo apt-get update

# Upgrade installed packages
sudo apt-get upgrade -y

# Install the required packages if not already installed
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker’s official GPG key using the new method
if [ ! -f /etc/apt/trusted.gpg.d/docker.gpg ]; then
  echo "Adding Docker GPG key..."
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/docker.gpg > /dev/null
else
  echo "Docker GPG key already exists."
fi

# Set up the stable repository
if ! grep -q "^deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-noble.list; then
  echo "Adding Docker repository..."
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
else
  echo "Docker repository already exists."
fi

# Update the package list again to include Docker packages
sudo apt-get update

# Install the latest version of Docker CE if not already installed
if ! dpkg -l | grep -q docker-ce; then
  echo "Installing Docker CE..."
  sudo apt-get install -y docker-ce
else
  echo "Docker CE is already installed."
fi

# Add your current user to the docker group (to avoid using sudo every time)
if ! groups ${USER} | grep -q '\bdocker\b'; then
  echo "Adding user to docker group..."
  sudo usermod -aG docker ${USER}
else
  echo "User already in docker group."
fi

# Install Docker Compose if not already installed
if ! command -v docker-compose &> /dev/null; then
  echo "Installing Docker Compose..."
  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
else
  echo "Docker Compose is already installed."
fi

# Check the installation
docker --version
docker-compose --version

# Change to the Ghost project directory
cd /opt/ghost

# Ensure docker-compose.yml is present
if [ ! -f docker-compose.yml ]; then
  echo "docker-compose.yml not found in /root/ghost"
  exit 1
fi

# Launch the Ghost project
echo "Starting Ghost project with Docker Compose..."
docker-compose up -d
