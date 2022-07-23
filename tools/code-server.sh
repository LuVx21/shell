#!/bin/bash

arglen=$#

install(){
    version=4.5.1
    filename=code-server-$version-linux-amd64.tar.gz
    wget -P /opt/pkg/ \
    https://github.91chi.fun/https://github.com//coder/code-server/releases/download/v$version/$filename
    tar -zxvf $filename -C /opt/install
    ln -s /opt/install/code-server-$version-linux-amd64 /opt/code-server
}

startup(){
    read -p "please input you password:" passwd
    export PASSWORD=$passwd
    nohup /opt/code-server/bin/code-server --auth password --host 0.0.0.0 --port 58080 > out.file 2>&1 &
    echo -e "\r\nStarting..."
}

shut_down(){
    ps aux | grep code-server | grep -v grep | awk '{print $2}' | xargs kill -9
}

show_help(){
    echo -e "\r\n\tCoder Server"
    echo -e "\r\nUsage: sh code start|stop|restart"
    # exit
}

if [ $arglen -eq 0 ]
 then
    show_help
else
    case "$1" in
        "install")
            install
            ;;
        "start")
            startup
            ;;
        "stop")
            shut_down
            ;;
        "restart")
            shut_down
            startup
            ;;
    esac
fi
