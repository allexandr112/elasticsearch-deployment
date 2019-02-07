# Description
This repo contains Vagrantfile and ansible roles to deploy ELK stack with kibana.
By default it launches 5 VMs: 1 Kibana node, 1 dedicated datanode, 2 dedicated masternodes, 1 node with combined masternode and datanode roles.
Datanodes also work as ingest nodes, masternodes don't.

This repo also contains default private keys `access.pem` and `access.pem.pub` for created VMs. These keys are used to easily launch ansible-playbook without typing passwords for each host. To disable host checks for ansible the repo also contains `ansible.cfg` file with necessary ansible config.

Script `clear-stored-keys.sh` is used to clear all stored connection config from `known-hosts` file. You can modify it in your own way.

Plugin `vagrant-hostmanager` is used to modify host machine `/etc/hosts` file by adding there static ips (specified in Vagrantfile) and hostnames of vms. So that VMs can be accessed via it's hostname or static ip from host machine.

Plugin `vagrant-hostsupdater` also updates `/etc/hosts` files on each described in Vagrantfile VM and adds there info about all created VMs. So that allows to use hostnames inside VMs to make communication between them more easily.

You can change amount of VMs created and roles assigned to them by modifying Vagrantfile and inventory.ini files. Default configs can be found there. Also don't forget to change `clear-stored-keys.sh` script according to your changes.

# Prerequisites
Requires ansible and vagrant installed
For vagrant also next plugins are required:
1. vagrant-hostmanager
2. vagrant-hostsupdater

Default solution creates 4 VMs with 2 GB RAM and 2 CPU each for cluster. And it also creates 1 VM with 1.5 GB RAM and 1 CPU for kibana. Each machine use vagrant box `Ubuntu/trusty64`.

## Install ansible
1. Install python3-pip
2. Execute command `sudo pip3 install ansible`

## Install vagrant
Depends on which Linux distro you use
For Debian: `sudo apt-get install vagrant`

## Install vagrant plugins
1. `vagrant plugin install vagrant-hostsupdater`
2. `vagrant plugin install vagrant-hostmanager`

# How to run
1. From directory with cloned repo run command `vagrant up`. During the execution you may be asked to enter sudo pass, it is normal and it is needed to update /etc/hosts by vagrant plugins.
2. Run `./clear-stored-key.sh` command. if neccessary make `chmod +x clear-stored-key.sh`
3. `cd ansible`
4. `ansible-playbook -i inventory.ini -u vagrant --private-key ../access.pem elasticsearch-site.yml`
 

