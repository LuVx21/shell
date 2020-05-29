#!/bin/bash

# 切换为镜像库
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
wget http://mirrors.aliyun.com/repo/Centos-7.repo -O /etc/yum.repos.d/CentOS-Base.repo

# 增加一个好的仓库
# Software Collections -> https://www.softwarecollections.org/en/
sudo yum install centos-release-scl
# scl enable rh-php70 bash

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

# 安装 DNF
yum install epel-release
yum install dnf


# 安装denyhosts
wget http://jaist.dl.sourceforge.net/project/denyhosts/denyhosts/2.6/DenyHosts-2.6.tar.gz
tar -zxvf DenyHosts-2.6.tar.gz
cd DenyHosts-2.6
python setup.py install
# 进入安装目录
cd /usr/share/denyhosts/
# 创建配置文件
cp denyhosts.cfg-dist denyhosts.cfg
# 启动文件副本
cp daemon-control-dist daemon-control
# 创建软连接
ln -s /usr/share/denyhosts/daemon-control /etc/init.d/denyhosts
# 设置Denyhosts为开机自动启动
# 添加denyhosts服务
chkconfig --add denyhosts
# 设置denyhosts在各等级为开启状态
chkconfig denyhosts on
# 查询是否设置成功
chkconfig --list denyhosts
# 启动denyhosts服务
systemctl start denyhosts
# 查询denyhosts服务状态
systemctl status denyhosts
# denyhosts的配置文件
cat /usr/share/denyhosts/denyhosts.cfg
# 白名单列表
cat /etc/hosts.allow
# 黑名单列表
cat /etc/hosts.deny

# fish
cd /etc/yum.repos.d/
wget http://download.opensuse.org/repositories/shells:fish:release:2/CentOS_7/shells:fish:release:2.repo
yum install fish

