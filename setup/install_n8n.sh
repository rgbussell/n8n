#!/bin/bash

# Exit on error
set -e

echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "Checking for Node.js installation..."
if command -v node >/dev/null 2>&1; then
    echo "Node.js is already installed. Version: $(node -v)"
else
    echo "Installing Node.js (LTS)..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt install -y nodejs
fi

echo "Checking for npm installation..."
if command -v npm >/dev/null 2>&1; then
    echo "npm is already installed. Version: $(npm -v)"
else
    echo "Installing npm..."
    sudo apt install -y npm
fi

echo "Checking for n8n installation..."
if command -v n8n >/dev/null 2>&1; then
    echo "n8n is already installed. Version: $(n8n -v)"
else
    echo "Installing n8n globally..."
    sudo npm install -g n8n
fi

# TODO figure out what do to with n8n

#echo "Creating n8n user..."
#sudo useradd -m -s /bin/bash n8n || true

#echo "Creating n8n data directory..."
#sudo mkdir -p /var/n8n
#sudo chown n8n:n8n /var/n8n

#echo "Creating systemd service for n8n..."
#sudo tee /etc/systemd/system/n8n.service > /dev/null <<EOF
#[Unit]
#Description=n8n workflow automation tool
#After=network.target

#[Service]
#Type=simple
#User=n8n
#Environment=DATA_FOLDER=/var/n8n
#ExecStart=/usr/bin/n8n
#Restart=on-failure

#[Install]
#WantedBy=multi-user.target
#EOF

#echo "Reloading systemd and enabling n8n service..."
#sudo systemctl daemon-reload
#sudo systemctl enable n8n
#sudo systemctl start n8n

echo "n8n installation complete. Access it at http://localhost:5678"