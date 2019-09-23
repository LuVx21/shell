#!/bin/bash

wget http://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-3.1.2/hadoop-3.1.2.tar.gz
wget https://mirrors.tuna.tsinghua.edu.cn/apache/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz
wget https://mirrors.tuna.tsinghua.edu.cn/apache/hbase/2.2.1/hbase-2.2.1-bin.tar.gz
wget http://mirrors.tuna.tsinghua.edu.cn/apache/hbase/2.2.1/hbase-2.2.1-client-bin.tar.gz

mkdir temp
tar -zxvf hadoop-3.1.2.tar.gz -C ./temp
tar -zxvf apache-hive-3.1.2-bin.tar.gz -C ./temp
tar -zxvf hbase-2.2.1-bin.tar.gz -C ./temp
tar -zxvf hbase-2.2.1-client-bin.tar.gz -C ./temp

cd temp;
cd /usr/local/;sudo rm -fr hive hadoop hbase hbase_client;cd -;
sudo mv apache-hive-3.1.2-bin /usr/local/hive
sudo mv hadoop-3.1.2 /usr/local/hadoop
sudo mv hbase-2.2.1 /usr/local/hbase
sudo mv hbase-2.2.1-client /usr/local/hbase_client

echo 'install completed'

