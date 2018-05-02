#!/bin/bash

sudo yum update
sudo yum -y install gcc gcc-c++ automake autoconf libtool make zlib-devel bzip2-devel openssl openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel
sudo yum install git zsh tree
sudo yum install cloc autojump tmux htop dos2unix

# 开放端口
# iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
# iptables save
# 或
# vi /etc/sysconfig/iptables
# -A INPUT -m state –state NEW -m tcp -p tcp –dport 8080 -j ACCEPT
