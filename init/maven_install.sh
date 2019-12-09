#! /bin/bash

version=3.5.4
url=https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/$version/binaries/apache-maven-$version-bin.tar.gz
filename=apache-maven-$version-bin.tar.gz
sudo wget -c $url -O $filename

sudo mkdir -p /opt/install
sudo tar -zxvf $filename -C /opt/install/
sudo ln -s /opt/install/apache-maven-$version /opt/maven

sudo rm -f $filename
