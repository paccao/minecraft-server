# my minecraft server

Documentation: https://docker-minecraft-server.readthedocs.io

Set up config easily with https://setupmc.com/java-server/

## Getting started

Download the latest `modpacks/*.mrpack` file to your mc launcher (Prism or modrinth)

Spin up the server with compose up, it will download the mods and configure the server automagically

```sh
podman compose up
```

## Backups

Are taken automatically with simple backups. They are stored as a zip in `mc-data/simplebackups/<$LEVEL>/`

$LEVEL should match the value of the var `LEVEL` in the compose file.

## Online mode

Set the argument `ONLINE_MODE` in the compose file to `true`
