#!/bin/bash

# ---------------------------------------------------------
# Update all installed packages
# ---------------------------------------------------------
yum update -y

# ---------------------------------------------------------
# Install Docker using Amazon Linux Extras
# ---------------------------------------------------------
amazon-linux-extras install docker -y

# ---------------------------------------------------------
# Start the Docker service
# ---------------------------------------------------------
systemctl start docker

# ---------------------------------------------------------
# Enable Docker to start automatically after reboot
# ---------------------------------------------------------
systemctl enable docker

# ---------------------------------------------------------
# Add the default EC2 user to the Docker group
# This allows the ec2-user to run Docker commands
# without using sudo (effective after next login)
# ---------------------------------------------------------
usermod -aG docker ec2-user

# ---------------------------------------------------------
# Set permissions for the Docker socket
# (Used here for the assignment. In production, prefer
# managing access through the Docker group instead.)
# ---------------------------------------------------------
chmod 666 /var/run/docker.sock

# ---------------------------------------------------------
# Pull the latest official NGINX Docker image
# ---------------------------------------------------------
docker pull nginx:latest

# ---------------------------------------------------------
# Remove the existing NGINX container if it already exists
# This prevents errors if the script runs again.
# ---------------------------------------------------------
docker rm -f nginx-container 2>/dev/null || true

# ---------------------------------------------------------
# Run the NGINX container
#
# -d                 : Run container in detached mode
# --name             : Assign a name to the container
# --restart          : Automatically restart after reboot
# -p 80:80           : Map EC2 port 80 to container port 80
# ---------------------------------------------------------
docker run -d \
  --name nginx-container \
  --restart unless-stopped \
  -p 80:80 \
  nginx:latest