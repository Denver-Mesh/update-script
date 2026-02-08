#!/usr/bin/bash

COMPOSE_FILE="/home/andrew/docker/docker-compose.denmesh.yml"

# 1. Stop the server to free up RAM and Image locks
sudo docker compose -f $COMPOSE_FILE stop

# 2. Clear out old Docker bloat to make room for the pull
sudo docker system prune -af

# 3. The "Do-It-All" Update
# topgrade runs 'dnf upgrade' automatically.
# Adding --cleanup tells topgrade to run the autoremove logic for you.
topgrade --disable firmware --cleanup -y

# 4. Pull the new images and restart
sudo docker compose -f $COMPOSE_FILE pull
sudo docker compose -f $COMPOSE_FILE up -d
