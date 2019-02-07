#!/bin/bash -e

ssh-keygen -R datanode-1
ssh-keygen -R datanode-2
ssh-keygen -R 192.168.77.1
ssh-keygen -R 192.168.77.2
ssh-keygen -R 192.168.77.3

ssh-keygen -R masternode-1
ssh-keygen -R masternode-2
ssh-keygen -R 192.168.77.4
ssh-keygen -R 192.168.77.5

ssh-keygen -R kibana
ssh-keygen -R 192.168.77.6

