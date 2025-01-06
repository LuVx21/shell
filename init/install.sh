#!/bin/bash

install=/opt/install

OS_NAME="$(uname -s)"
case "${OS_NAME##*-}" in
    Linux)  OS='linux'; L_OS='linux' ;;
    Darwin) OS='macos'; L_OS='darwin' ;;
    *) echo >&2 "不支持的系统: ${OS_NAME}"; exit 1 ;;
esac;

ARCH_NAME="$(uname -m)" # 或arch
case "${ARCH_NAME##*-}" in
    x86_64)        ARCH_V0='amd64'; ARCH_V1='x64';     ARCH_V2='amd64' ;;
    arm64|aarch64) ARCH_V0='arm64'; ARCH_V1='aarch64'; ARCH_V2='aarch64' ;;
    *) echo >&2 "不支持的架构: ${ARCH_NAME}"; exit 1 ;;
esac;
echo "----------------------------------------------------------------"
echo "$OS_NAME -> $OS $L_OS"
echo "$ARCH_NAME -> $ARCH_V0 $ARCH_V1 $ARCH_V2"
echo "----------------------------------------------------------------"

Usage() {
  echo "$0 <module_name>"
}

if [ $# -eq 0 ]; then
# if [ "$1" = "" ]; then
    echo -e "需指定模块名"
    Usage
    exit 1
elif [ "$1" = "java" ]; then
    version=23
    file=jdk-${version}_${OS}-${ARCH_V1}_bin.tar.gz
    target=$install/jdk$version
    url=https://download.oracle.com/java/$version/latest/$file
    # https://download.oracle.com/graalvm/$version/latest/graalvm-$file
    wget $url -P $install
    rm -fr $target && mkdir -p $target
    tar -zxvf $install/$file --strip-components 2 -C $target
    rm /opt/$1 && ln -s $target /opt/$1
    exit 0
elif [ "$1" = "go" ]; then
    [[ -n $2 ]] && version=$2 || version="1.23.4"
    echo "安装go: $version";
    file=go${version}.${L_OS}-${ARCH_V0}.tar.gz
    target=$install/go
    url=https://go.dev/dl/$file
    wget $url -P $install
    rm -fr $target && mkdir -p $target
    tar -zxvf $install/$file --strip-components 1 -C $target
    sudo rm /opt/$1 && sudo ln -s $target /opt/$1
    go env -w GOPROXY=https://goproxy.cn,direct
    exit 0
elif [ "$1" = "frp" ]; then
    version=0.61.0
    file=frp_${version}_${L_OS}_${ARCH_V0}.tar.gz
    url=https://github.com/fatedier/frp/releases/download/v$version/$file
    echo $url
    exit 0
elif [ "$1" = "mvnd" ]; then
    version=1.0.2
    file=maven-mvnd-${version}-${L_OS}-${ARCH_V2}.tar.gz
    target=$install/mvnd
    url=https://github.com/apache/maven-mvnd/releases/download/$version/$file
    wget $url -P $install
    rm -fr $target && mkdir -p $target
    tar -zxvf $install/$file --strip-components 2 -C $target
    rm /opt/$1 && ln -s $target /opt/$1
    exit 0
elif [ "$1" = "jq" ]; then
    curl -fSL https://github.com/stedolan/jq/releases/latest/download/jq-${OS}-${ARCH_V0} -o /usr/bin/jq
    sudo chmod +x /usr/bin/jq
    exit 0
else
    echo -e "无指定模块名"
    exit 1
fi