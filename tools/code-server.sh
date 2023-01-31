#!/bin/bash

arglen=$#

show_help(){
    echo -e "\r\n\tCoder Server"
    echo -e "\r\nUsage: sh code start|stop|restart"
    # exit
}

startup(){
    read -t 10 -p "please input you password:" passwd
    passwd=${passwd:admin}
    export PASSWORD=$passwd
    nohup /opt/code-server/bin/code-server --auth password --host 0.0.0.0 --port 58080 > out.log 2>&1 &
    echo -e "\r\nStarting..."
}

shut_down(){
    ps aux | grep code-server | grep -v grep | awk '{print $2}' | xargs kill -9
    echo -e "\r\nShutdown..."
}

install(){
    version=4.9.1
    filename=code-server-$version-linux-amd64.tar.gz
    wget -P /opt/pkg/ \
    https://github.91chi.fun/https://github.com//coder/code-server/releases/download/v$version/$filename
    tar -zxvf /opt/pkg/$filename -C /opt/install
    shut_down
    rm -r /opt/code-server
    ln -s /opt/install/code-server-$version-linux-amd64 /opt/code-server
    startup
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
