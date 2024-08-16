#!/bin/bash

install=/opt/install

if [ "$1" = "" ];then
    echo -e "需指定模块名"
    exit 1
elif [ "$1" = "java" ];then
    version=21
    file=jdk-${version}_macos-aarch64_bin.tar.gz
    target=$install/jdk$version
    url=https://download.oracle.com/java/$version/latest/$file
    # https://download.oracle.com/graalvm/$version/latest/graalvm-$file
    wget $url -P $install
    rm -fr $target && mkdir -p $target
    tar -zxvf $install/$file --strip-components 2 -C $target
    rm /opt/$1 && ln -s $target /opt/$1
    exit 0
elif [ "$1" = "go" ];then
    version=1.23.0
    file=go$version.darwin-arm64.tar.gz
    target=$install/go
    url=https://go.dev/dl/$file
    wget $url -P $install
    rm -fr $target && mkdir -p $target
    tar -zxvf $install/$file --strip-components 1 -C $target
    sudo rm /opt/$1 && sudo ln -s $target /opt/$1
    go env -w GOPROXY=https://goproxy.cn,direct
    exit 0
elif [ "$1" = "frp" ];then
    version=0.58.1
    file=frp_${version}_darwin_arm64.tar.gz
    url=https://github.com/fatedier/frp/releases/download/v$version/$file
    echo $url
    exit 0
elif [ "$1" = "mvnd" ];then
    version=1.0-m8
    file=maven-mvnd-$version-m40-darwin-aarch64.tar.gz
    url=https://github.com/apache/maven-mvnd/releases/download/$version/$file
    echo $url
    exit 0
else
    echo -e "无指定模块名"
    exit 1
fi