#!/bin/ash
set -eu

podman exec minecraft-server_mc_1 rcon-cli tellraw @a "{\"text\":\"[Server] - Restarting in 15 minutes\",\"color\":\"gold\"}"
sleep 600
podman exec minecraft-server_mc_1 rcon-cli tellraw @a "{\"text\":\"[Server] - Restarting in 5 minutes\",\"color\":\"red\"}"
sleep 300
podman stop minecraft-server_mc_1
sleep 60
podman start minecraft-server_mc_1
