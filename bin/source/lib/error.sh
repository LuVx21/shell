#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/color.sh"

# 带错误处理的命令执行
run_safe() {
    local cmd="$*"
    local output
    local status

    output=$($cmd 2>&1)
    status=$?

    if [ $status -ne 0 ]; then
        log_error "命令执行失败: $cmd"
        log_error "错误信息: $output"
        return $status
    fi

    echo "$output"
    return 0
}

# 重试函数
retry() {
    local max_attempts="$1"
    local delay="$2"
    shift 2
    local cmd=("$@")

    local attempt=1
    while [ $attempt -le $max_attempts ]; do
        if "${cmd[@]}"; then
            return 0
        fi

        log_warning "尝试 $attempt/$max_attempts 失败，${delay}秒后重试..."
        sleep "$delay"
        ((attempt++))
    done

    log_error "所有尝试均失败: ${cmd[*]}"
    return 1
}