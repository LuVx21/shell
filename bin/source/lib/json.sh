#!/usr/bin/env bash

# 检查是否安装了 jq
has_jq() {
    command -v jq >/dev/null
}

# 从 JSON 中提取值
json_get() {
    local json="$1"
    local key="$2"

    if has_jq; then
        echo "$json" | jq -r "$key"
    else
        echo "Error: jq is required" >&2
        return 1
    fi
}

# 创建简单的 JSON
json_create() {
    local data=""
    while [ $# -gt 0 ]; do
        local key="$1"
        local value="$2"
        shift 2

        if [ -n "$data" ]; then
            data="$data,"
        fi
        data="$data\"$key\":\"$value\""
    done
    echo "{$data}"
}