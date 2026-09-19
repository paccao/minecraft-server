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


## Things to nerf (TODO)
- Forgotten (mob) drop rate of lucky hat
- Ancient debris/ netherite ingot in supplementaries/quark/etc.. strongholds in the nether
- Maybe good enchanting books from pots in caves? Needs more testing
- Emeralds, diamonds, enchanted weapons etc from larger villager cities in the overworld
- Create tinker city makes the player skip Create progression entirely (easy getting a shit ton of bronze, rotation speed controllers, and some brass casing etc.
- RPG mod(s) overall seems strong? Only tried Warrior at the time of writing. Shield spam plus sword ability super strong. Either vanilla minecraft shields are just strong, or the Spell casting on the weapons are too strong.Needs more testing with bosses etc.

