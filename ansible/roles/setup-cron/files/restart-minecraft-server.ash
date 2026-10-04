#!/bin/ash
set -eu

podman exec minecraft-server_mc_1 rcon-cli say "Server restarting in 15 minutes"
sleep 600
podman exec minecraft-server_mc_1 rcon-cli say "Server restarting in 5 minutes"
sleep 300
podman stop minecraft-server_mc_1
sleep 60
podman compose up -d --file /home/ansible/minecraft-server/docker-compose.yaml
