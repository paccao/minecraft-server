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

```sh
ansible-playbook --ask-pass --ask-vault-pass ansible/bootstrap.yaml -i ansible/inventory.ini --user root
```

Remember that:

`--ask-pass` = SSH user password

`--ask-become-pass` = doas password
