#!/bin/bash

version=0.44.0
# hostPrefix=https://github.91chi.fun/https://github.com//fatedier/frp/releases/download/
hostPrefix=https://github.com/fatedier/frp/releases/download/

install_server(){
    filename=frp_${version}_linux_amd64.tar.gz
    sudo wget -P /opt/pkg/ ${hostPrefix}v${version}/$filename
    sudo tar -zxvf $filename -C /opt/install
    ln -s /opt/install/frp_0.44.0_linux_amd64 /opt/frp
}

start_server(){
    ./frps -c ./frps.ini
}


# 客户端

install_client(){
    filename=frp_${version}_darwin_amd64.tar.gz
    sudo wget -P /opt/pkg/ ${hostPrefix}v${version}/$filename
}

start_client(){
    ./frpc -c ./frpc.ini
}
