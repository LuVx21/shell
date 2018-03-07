#! /bin/bash

# https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-server_5.7.21-1ubuntu16.04_amd64.deb-bundle.tar

groupadd mysql
useradd -r -g mysql mysql

mkdir -p /usr/local/mysql
tar -xvf mysql-server_5.7.21-1ubuntu16.04_amd64.deb-bundle.tar
tar -zxvf mysql-server_5.7.21-1ubuntu16.04_amd64.deb-bundle.tar.gz -C /usr/local/mysql

# sudo apt-get install mysql-server
# sudo apt-get install mysql-client
# sudo apt-get install libmysqlclient-dev
# sudo service mysql start