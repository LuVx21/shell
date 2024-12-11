#!/bin/bash

install=/opt/install

OS_NAME="$(uname -s)"
case "${OS_NAME##*-}" in \
    Linux) OS='linux'; L_OS='linux' ;; \
    Darwin) OS='macos'; L_OS='darwin' ;; \
    *) echo >&2 "不支持的系统: ${OS_NAME}"; exit 1 ;; \
esac;

ARCH_NAME="$(uname -m)" # 或arch
case "${ARCH_NAME##*-}" in \
    x86_64) ARCH='amd64'; L_ARCH='x64'; LL_ARCH='amd64' ;; \
    arm64) ARCH='arm64'; L_ARCH='aarch64'; LL_ARCH='aarch64' ;; \
    *) echo >&2 "不支持的架构: ${ARCH_NAME}"; exit 1 ;; \
esac;
echo "----------------------------------------------------------------"
echo "$OS_NAME -> $OS $L_OS"
echo "$ARCH_NAME -> $ARCH $L_ARCH $LL_ARCH"
echo "----------------------------------------------------------------"

if [ "$1" = "" ];then
    echo -e "需指定模块名"
    exit 1
elif [ "$1" = "java" ];then
    version=23
    file=jdk-${version}_${OS}-${L_ARCH}_bin.tar.gz
    target=$install/jdk$version
    url=https://download.oracle.com/java/$version/latest/$file
    # https://download.oracle.com/graalvm/$version/latest/graalvm-$file
    wget $url -P $install
    rm -fr $target && mkdir -p $target
    tar -zxvf $install/$file --strip-components 2 -C $target
    rm /opt/$1 && ln -s $target /opt/$1
    exit 0
elif [ "$1" = "go" ];then
    [[ -n $2 ]] && version=$2 || version="1.23.4"
    echo "安装go: $version";
    file=go${version}.${L_OS}-${ARCH}.tar.gz
    target=$install/go
    url=https://go.dev/dl/$file
    wget $url -P $install
    rm -fr $target && mkdir -p $target
    tar -zxvf $install/$file --strip-components 1 -C $target
    sudo rm /opt/$1 && sudo ln -s $target /opt/$1
    go env -w GOPROXY=https://goproxy.cn,direct
    exit 0
elif [ "$1" = "frp" ];then
    version=0.61.0
    file=frp_${version}_${L_OS}_${ARCH}.tar.gz
    url=https://github.com/fatedier/frp/releases/download/v$version/$file
    echo $url
    exit 0
elif [ "$1" = "mvnd" ];then
    version=1.0.2
    file=maven-mvnd-${version}-${L_OS}-${LL_ARCH}.tar.gz
    target=$install/mvnd
    url=https://github.com/apache/maven-mvnd/releases/download/$version/$file
    wget $url -P $install
    rm -fr $target && mkdir -p $target
    tar -zxvf $install/$file --strip-components 2 -C $target
    rm /opt/$1 && ln -s $target /opt/$1
    exit 0
else
    echo -e "无指定模块名"
    exit 1
fi