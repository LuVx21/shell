#!/bin/bash

version=2.2.2
url=http://mirrors.tuna.tsinghua.edu.cn/apache/kafka/$version/kafka_2.12-$version.tgz
filename=kafka_2.12-$version.tgz
sudo wget -c $url -O $filename

sudo mkdir -p /opt/install
sudo tar -zxvf $filename -C /opt/install/
sudo ln -s /opt/install/kafka_2.12-$version /opt/kafka

sudo rm -f $filename
