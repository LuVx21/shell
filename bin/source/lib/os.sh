#!/usr/bin/env bash

is_macos() { [ "$(uname)" = "Darwin" ]; }
is_linux() { [ "$(uname)" = "Linux" ]; }
is_wsl()   { grep -qi microsoft /proc/version 2>/dev/null; }

get_arch() { uname -m; }

# 获取 CPU 核心数
cpu_count() {
    if is_mac; then
        sysctl -n hw.ncpu
    else
        nproc
    fi
}

# 获取内存总量（MB）
total_memory() {
    if is_mac; then
        sysctl -n hw.memsize | awk '{print int($1/1024/1024)}'
    else
        free -m | awk '/^Mem:/{print $2}'
    fi
}
# 检查进程是否在运行
is_process_running() { pgrep -f "$1" >/dev/null; }
# 获取进程 PID
get_pid() { pgrep -f "$1"; }

# 杀死进程
kill_process() {
    local pattern="$1"
    local signal="${2:-TERM}"

    pkill -$signal -f "$pattern"
}

# 检查端口是否在使用
is_port_used() {
    local port="$1"

    if is_mac; then
        lsof -i:"$port" >/dev/null 2>&1
    else
        netstat -tuln | grep -q ":$port "
    fi
}

# 获取监听指定端口的进程
get_process_by_port() {
    local port="$1"

    if is_mac; then
        lsof -i:"$port" | awk 'NR>1 {print $1, $2}'
    else
        netstat -tulpn 2>/dev/null | grep ":$port " | awk '{print $7}'
    fi
}
# 获取本机 IP 地址
get_local_ip() {
    if is_mac; then
        ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1
    else
        hostname -I | awk '{print $1}'
    fi
}
# 获取公网 IP
get_public_ip() {
    curl -s ifconfig.me || curl -s icanhazip.com || curl -s ipinfo.io/ip
}
