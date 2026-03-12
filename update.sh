#!/usr/bin/bash

COMPOSE_FILE="/home/andrew/docker/docker-compose.denmesh.yml"

# 1. Stop the server to free up RAM and Image locks
sudo docker compose -f $COMPOSE_FILE stop

# 2. Clear out old Docker bloat to make room for the pull
sudo docker system prune -af

# 3. The "Do-It-All" Update
# topgrade runs 'dnf upgrade' automatically. 
# --Edit: It's 'dnf update -y' --- you're thinking of Debian based distros that use apt-get, e.g. 'apt-get update', and then 'apt-get upgrade' to actually do the update
sudo dnf update -y
# Adding --cleanup tells topgrade to run the autoremove logic for you.
# --Edit: You are not supposed to run 'dnf autoremove' everytime after running 'dnf update'
topgrade --disable firmware

# 4. Pull the new images and restart
sudo docker compose -f $COMPOSE_FILE pull
sudo docker compose -f $COMPOSE_FILE up -d

# 5. Make sure the Postfix/Dovecot/mariaDB services are running
sudo systemctl restart postfix
sudo systemctl restart dovecot
sudo systemctl restart mariaDB
