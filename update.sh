#!/usr/bin/bash

# 1. Stop the services to release any locks on image layers
sudo docker-compose -f /home/andrew/docker/docker-compose.denmesh.yml stop

# 2. Prune BEFORE the pull to clear out old images and cache
# This ensures you have room for the new incoming data
sudo docker system prune -af

# 3. System maintenance
topgrade --disable firmware
sudo dnf autoremove -y

# 4. Pull and Restart
sudo docker-compose -f /home/andrew/docker/docker-compose.denmesh.yml pull
sudo docker-compose -f /home/andrew/docker/docker-compose.denmesh.yml up -d
