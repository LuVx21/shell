#!/usr/bin/env bash
DEBUG=${DEBUG:-false}

# 获取当前时间戳
timestamp() {
    date +%s
}

# 获取当前日期时间
now() {
    date '+%Y-%m-%d %H:%M:%S'
}

# 获取当前日期
today() {
    date '+%Y-%m-%d'
}

# 格式化时间戳
format_timestamp() {
    local ts="$1"
    local format="${2:-%Y-%m-%d %H:%M:%S}"
    date -d "@$ts" +"$format" 2>/dev/null || date -r "$ts" +"$format"
}

# 计算时间差（秒）
time_diff() {
    local start="$1"
    local end="${2:-$(timestamp)}"
    echo $((end - start))
}
# 获取 N 天前的日期
days_ago() {
    local days="$1"
    if is_mac; then
        date -v -"${days}d" '+%Y-%m-%d'
    else
        date -d "$days days ago" '+%Y-%m-%d'
    fi
}

# 获取 N 天后的日期
days_from_now() {
    local days="$1"
    if is_mac; then
        date -v +"${days}d" '+%Y-%m-%d'
    else
        date -d "$days days" '+%Y-%m-%d'
    fi
}
