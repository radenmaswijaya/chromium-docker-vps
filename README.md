# Chromium Docker VPS Installer

This script allows you to automatically set up a Chromium browser inside a Docker container on any Ubuntu VPS. The browser can be accessed via a web UI (port 3010) using VNC.
## Features
- One-click setup via Bash script
- Web access to Chromium (headless)
- Docker-based and isolated
- Automatic timezone setup
- Randomized VNC password

## How to Use

```bash
wget https://raw.githubusercontent.com/radenmaswijaya/chromium-docker-vps/main/setup-chromium.sh
chmod +x setup-chromium.sh
sudo ./setup-chromium.sh

