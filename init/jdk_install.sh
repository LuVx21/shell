#! /bin/bash

# 删除
yum list installed | grep java
yum -y remove java-1.8.0-openjdk.x86_64
wget -c +url 


# https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz

# http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-linux-x64.rpm
# wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-linux-x64.tar.gz
# mkdir -p /usr/local/java
# tar -zxvf jdk-8u162-linux-x64.tar.gz -C /usr/local/java


sudo mkdir -p /opt/install
filename=$1
sudo tar -zxvf $filename -C /opt/install/

arr=$(ls -l /opt/install | grep jdk | awk '{print $9}')
for i in ${arr[*]}
do
    dirnm=$i
done

