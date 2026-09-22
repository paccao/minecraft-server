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

## Restore backups / create server from a backup

If the mounted data path is empty, the server will either create a new save file. But if the `WORLD` variable is defined, it will create the server based on that backup.

If you want to restore from a specific backup, change the `WORLD` variable and add `FORCE_WORLD_COPY=true`

## Online mode

Set the argument `ONLINE_MODE` in the compose file to `true`

## Run commands towards the server

Use the `RCON_CLI`

for example:

```sh
podman exec minecraft-server_mc_1 rcon-cli op <playerName>
```

## Things to nerf (TODO)

There is a graphical config interface ingame, but it says its locked ingame, some troubleshooting is required

- Forgotten (mob) drop rate of lucky hat - NOT CONFIGURABLE
- Ancient debris/ netherite ingot in supplementaries/quark/etc.. strongholds in the nether
- Maybe good enchanting books from pots in caves? Needs more testing (Supplementaries)
- Emeralds, diamonds, enchanted weapons etc from larger villager cities in the overworld
- Create tinker city makes the player skip Create progression entirely (easy getting a shit ton of bronze, rotation speed controllers, and some brass casing etc.
- RPG mod(s) overall seems strong? Only tried Warrior at the time of writing. Shield spam plus sword ability super strong. Either vanilla minecraft shields are just strong, or the Spell casting on the weapons are too strong.Needs more testing with bosses etc.
- create enchanting industries. Good books should cost way more XP, or perhaps recipes needs to be modified

## Interesting mods to add maybe
https://modrinth.com/mod/create-cobblestone - reduces lag but makes it really easy to generate cobblestone, might be too easy
