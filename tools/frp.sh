#!/bin/bash

arglen=$#

version=0.44.0
# hostPrefix=https://github.91chi.fun/https://github.com//fatedier/frp/releases/download/
hostPrefix=https://github.com/fatedier/frp/releases/download/

install_server(){
    filename=frp_${version}_linux_amd64.tar.gz
    sudo wget -P /opt/pkg/ ${hostPrefix}v${version}/$filename
    sudo tar -zxvf $filename -C /opt/install
    ln -s /opt/install/frp_${version}_linux_amd64 /opt/frp
}

start_server(){
    nohup /opt/frp/frps -c /opt/frp/frps.ini &
}


# 客户端

install_client(){
    filename=frp_${version}_darwin_amd64.tar.gz
    sudo wget -P /opt/pkg/ ${hostPrefix}v${version}/$filename
}

start_client(){
    nohup /opt/frp/frpc -c /opt/frp/frpc.ini &
}

if [ $arglen -eq 0 ]
 then
    echo frp
else
    case "$1" in
        "install_server")
            install_server
            ;;
        "start_server")
            start_server
            ;;
        "install_client")
            install_client
            ;;
        "start_client")
            start_client
            ;;
    esac
fi
