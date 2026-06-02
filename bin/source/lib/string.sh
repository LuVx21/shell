#!/usr/bin/env bash
DEBUG=${DEBUG:-false}

# 检查字符串是否为空
is_empty() {
    [ -z "${1// }" ]
}

# 检查字符串是否为数字
is_number() {
    case $1 in
        ''|*[!0-9]*) return 1 ;;
        *) return 0 ;;
    esac
}

# 检查字符串是否为整数（可包含负号）
is_integer() {
    case $1 in
        ''|*[!0-9-]*) return 1 ;;
        -*) [ "${1#-}" -eq "${1#-}" ] 2>/dev/null ;;
        *) [ "$1" -eq "$1" ] 2>/dev/null ;;
    esac
}

# 检查字符串是否为浮点数
is_float() {
    case $1 in
        ''|*[!0-9.-]*) return 1 ;;
        *.*.*) return 1 ;;
        *) [ "$1" = "${1#-}" ] || [ "$1" = "${1#+}" ] || {
            printf '%f' "$1" >/dev/null 2>&1
        } ;;
    esac
}

# 检查是否是有效的邮箱地址
is_email() {
    [[ "$1" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]
}

# 检查是否是有效的 URL
is_url() {
    [[ "$1" =~ ^https?://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(/.*)?$ ]]
}

# 转换为小写
to_lower() {
    echo "$1" | tr '[:upper:]' '[:lower:]'
}

# 转换为大写
to_upper() {
    echo "$1" | tr '[:lower:]' '[:upper:]'
}

# 首字母大写
capitalize() {
    local str="$1"
    echo "${str^}"
}

# 每个单词首字母大写
title_case() {
    echo "$1" | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))} 1'
}

# 移除字符串两端的空格
trim() {
    local var="$*"
    var="${var#"${var%%[![:space:]]*}"}"
    var="${var%"${var##*[![:space:]]}"}"
    echo -n "$var"
}

# 移除所有空白字符
strip_whitespace() {
    echo "$1" | tr -d '[:space:]'
}

# 获取字符串长度
strlen() {
    echo ${#1}
}

# 字符串是否以特定前缀开头
starts_with() {
    [[ "$1" == "$2"* ]]
}

# 字符串是否以特定后缀结尾
ends_with() {
    [[ "$1" == *"$2" ]]
}

# 提取子字符串
substr() {
    local str="$1"
    local start="$2"
    local length="$3"

    if [ -n "$length" ]; then
        echo "${str:$start:$length}"
    else
        echo "${str:$start}"
    fi
}

# 字符串替换
str_replace() {
    local str="$1"
    local search="$2"
    local replace="$3"
    echo "${str//$search/$replace}"
}