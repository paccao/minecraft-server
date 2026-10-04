# Ansible playbooks

This project uses ansible to configure an alpine server to deploy the minecraft server

It uses `ansible-vault` to encrypt the `ansible_become_password` in order to run privileged commands on the VPS

## Initial bootstrap

SSH into the server and change the following in `/etc/ssh/sshd_config`

```
PermitRootLogin yes
PasswordAuthentication yes
```

This is a vulnerability, but is required for us to run the initial bootstrap manually. The playbook will patch this up later.

## Edit your local config

/etc/hosts needs to be changed if you dont have a DNS for your internal network. If you are hosting it on a public VPS, use its public static IP or DNS if you have that set up.

`sudoedit /etc/hosts`

Add:

```
# Static DCHP lease for alpine server
192.168.30.30 pi5-alpine-1
```

Next, update your ssh config:

`vim ~/.ssh/config`

```
Host pi5-alpine-1
  User minecraft
```

## Run the bootstrap playbook

First time run, add the `--tags known_hosts` to the command below to set up known_hosts.

If you run with that flag multiple times, it will append the pub key to known hosts each run.

**FIRST RUN:**

```sh
ansible-playbook --ask-pass --ask-vault-pass ansible/bootstrap.yaml --user root --tags with_known_hosts -vvv
```

If you need to reconfigure something, run without the tags:

```sh
ansible-playbook --ask-pass --ask-vault-pass ansible/bootstrap.yaml --user root
```

Remember that:

`--ask-pass` = SSH user password

`--ask-become-pass` = doas password

## Init the minecraft server

First add your ssh key to the ssh-agent

```fish
# Fish shell
eval (ssh-agent -c)
# Or bash shell:
# eval "$(ssh-agent -s)"
ssh-add <path_to_private_key>
```

Then run the init-playbook. This is a one-time setup type of playbook. It sets up the git-repo, the minecraft user and copies over the data from your local host to the remote server.

```sh
ansible-playbook ansible/init-mcserver.yaml --ask-pass --ask-become-pass --ask-vault-pass
```

If you have a minecraft server already on your local machine (in this git repo), add the following tag:

```sh
---tags with_copy_data # Optional, if you dont have a minecraft server already on your local machine - skip this step.
```

If you dont have a server locally, you can just create a new server from a `.mrpack` file you supply in the compose values.

## Set up automatic server restarts with cron


```sh
ansible-playbook --ask-pass ansible/setup-cron.yaml --user root
```

## Backups

Run the backup playbook.

#### Localhost backup

```sh
ansible-playbook --ask-become-pass ansible/local-backup.yaml
```

**Default behaviour** is taking a backup of simplebackups .zip files only.

It requires sudo in order for rsync to be able to keep the ownership on the files that are copied, podman creates the mounted files with a special user and group id, 100999.

It has two tags **options**:

```sh
--tags full_backup # `all` also works
--tags partial_datadir # full server snapshot excluding simplebackups, default `data-v2/`
```

#### Full sync of remote data to localhost

```sh
ansible-playbook --ask-become-pass ansible/remote-to-local-backup.yaml
```

It requires sudo in order for rsync to be able to keep the ownership on the files that are copied, podman creates the mounted files with a special user and group id, 100999.
