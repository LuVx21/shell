#!/bin/bash

sudo apt-get update

# ssh
ps -e | grep ssh
/etc/init.d/ssh start
sudo apt-get install openssh-server

# 防火墙
apt install ufw
sudo ufw enable
sudo ufw enable deny
sudo ufw status


sudo apt-get install build-essential libtool gcc automake autoconf make openssl
