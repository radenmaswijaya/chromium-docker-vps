#!/bin/bash

# Display banner (optional)
echo "===> Chromium VPS Auto Installer"

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

# Update system & install dependencies
apt update && apt upgrade -y
apt install -y curl wget sudo gnupg2 ca-certificates lsb-release

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Install Docker Compose (stable version)
COMPOSE_VERSION="1.29.2"
curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Set timezone
read -p "Enter your timezone (default: Asia/Jakarta): " TZ
TZ=${TZ:-Asia/Jakarta}
timedatectl set-timezone $TZ

# Generate random credentials
USERNAME="user$(openssl rand -hex 2)"
PASSWORD="$(openssl rand -hex 8)"

# Prepare docker-compose for Chromium
mkdir -p ~/chromium
cat > ~/chromium/docker-compose.yaml <<EOF
version: '3'
services:
  chromium:
    image: zenika/alpine-chrome:with-node
    ports:
      - "3010:3000"
    environment:
      - TZ=$TZ
      - VNC_PASSWORD=$PASSWORD
    shm_size: 2g
EOF

# Launch the container
cd ~/chromium
docker-compose up -d

# Display access info
IP=$(curl -s ifconfig.me)
echo ""
echo "===> Chromium WebUI Ready!"
echo "URL : http://$IP:3010"
echo "User: $USERNAME"
echo "Pass: $PASSWORD"
