#!/usr/bin/bash
sudo docker-compose -f /home/andrew/docker/docker-compose.denmesh.yml stop
sudo topgrade --disable firmware
sudo docker-compose -f /home/andrew/docker/docker-compose.denmesh.yml pull
sudo docker-compose -f /home/andrew/docker/docker-compose.denmesh.yml up -d
sudo docker system prune -af
sudo dnf autoremove
