#!/bin/bash

# before centos6.8
# yum install mysql mysql-server mysql-devel
# centos7
yum install mariadb mariadb-server

service mysqld start

# >update mysql.user set password = PASSWORD('1121') where user='root';
# >flush privileges;