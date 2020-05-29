#!/bin/bash

arglen=$#

name=$1
version=$2

init() {
    sudo mkdir -p /opt/install
}

kafka() {
    # version=2.2.2
    url=http://mirrors.tuna.tsinghua.edu.cn/apache/kafka/$version/kafka_2.12-$version.tgz
    filename=basename $url
    sudo wget -c $url -O $filename

    init
    sudo tar -zxvf $filename -C /opt/install/
    sudo ln -s /opt/install/kafka_2.12-$version /opt/kafka

    sudo rm -f $filename
}

maven() {
    # version=3.5.4
    url=https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/$version/binaries/apache-maven-$version-bin.tar.gz
    filename=apache-maven-$version-bin.tar.gz
    sudo wget -c $url -O $filename

    init
    sudo tar -zxvf $filename -C /opt/install/
    sudo ln -s /opt/install/apache-maven-$version /opt/maven

    sudo rm -f $filename

}

help() {
cat <<-'EOF'
        _            __        ____
       (_)___  _____/ /_____ _/ / /
      / / __ \/ ___/ __/ __ `/ / /
     / / / / (__  ) /_/ /_/ / / /
    /_/_/ /_/____/\__/\__,_/_/_/

    Usage: install kafka 2.2.2
EOF
}

if [ $arglen -eq 0 ]
then
    help
else
    case "$1" in
        "init")
            init
            ;;
        "kafka")
            kafka
            ;;
        "java")
            java
            ;;
        "maven")
            maven
            ;;
        "help")
            help
            ;;
    esac
fi
