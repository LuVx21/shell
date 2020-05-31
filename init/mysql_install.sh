#! /bin/bash

#↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

# CentOS
wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
yum localinstall mysql57-community-release-el7-11.noarch.rpm

# 确认仓库
# ll /etc/yum.repos.d
# yum repolist enabled | grep "mysql.*-community.*"

yum install mysql-community-server
systemctl start mysqld
systemctl status mysqld
# 其他配置
# systemctl stop mysqld
# systemctl disenable mysqld
# systemctl daemon-reload

# 修改密码
grep 'temporary password' /var/log/mysqld.log
# mysql_secure_installation

## after login
# set global validate_password_policy=0;
# set global validate_password_length=1;
## select @@validate_password_length;
# set password = password('root');
## 配置远程登录
# grant all privileges on *.* to 'root'@'%' identified by '1121' with grant option;
# flush privileges;

#↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑


# 自定义安装
#########################################################################

# wget https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-server_5.7.21-1ubuntu16.04_amd64.deb-bundle.tar

# # groupadd mysql
# # useradd -r -g mysql mysql

# mkdir -p /usr/local/mysql
# tar -xvf mysql-server_5.7.21-1ubuntu16.04_amd64.deb-bundle.tar
# tar -zxvf mysql-server_5.7.21-1ubuntu16.04_amd64.deb-bundle.tar.gz -C /usr/local/mysql

#########################################################################

## 一些配置: 编码
# show variables like 'char%'
# vim /etc/my.cnf # [mysqld]
# character-set-server=utf8
# character-set-database=utf8
# default-character-set=utf8

# Ubuntu
###################################################
# sudo apt-get install mysql-server
# sudo apt-get install mysql-client
# sudo apt-get install libmysqlclient-dev
# sudo service mysql start
###################################################