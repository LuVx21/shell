#!/usr/bin/env bash

# 检查文件是否存在
file_exists() { [ -f "$1" ]; }
# 检查文件是否可读
file_readable() { [ -r "$1" ]; }
# 检查文件是否可写
file_writable() { [ -w "$1" ]; }
# 检查文件是否可执行
file_executable() { [ -x "$1" ]; }

safe_mkdir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo "创建目录: $1"
    fi
}

# 0 = 目录存在且为空, 1 = 目录存在且不为空, 2 = 目录不存在
directory_empty() {
    local dir="$1"

    # 检查目录是否存在
    if [ ! -d "$dir" ]; then
        $DEBUG && echo "错误: 目录 '$dir' 不存在" >&2
        return 2
    fi
    # 检查是否为空
    if [ -z "$(ls -A "$dir" 2>/dev/null)" ]; then
        return 0  # 空目录
    fi
    return 1  # 非空目录
}

# 检查文件是否包含特定字符串
file_contains() {
    grep -q "$1" "$2" 2>/dev/null
}
# 在文件开头添加内容
prepend_to_file() {
    local content="$1"
    local file="$2"
    echo -e "$content\n$(cat "$file" 2>/dev/null)" > "$file.tmp" && mv "$file.tmp" "$file"
}

# 在文件末尾添加内容
append_to_file() {
    local content="$1"
    local file="$2"
    echo "$content" >> "$file"
}

# 安全下载文件
download_file() {
    local url="$1"
    local output="${2:-$(basename "$url")}"

    if command -v wget >/dev/null; then
        wget -q "$url" -O "$output"
    elif command -v curl >/dev/null; then
        curl -s -L "$url" -o "$output"
    else
        echo "Error: Neither wget nor curl found" >&2
        return 1
    fi
}

# 下载并验证文件完整性
download_and_verify() {
    local url="$1"
    local checksum_url="$2"
    local output="${3:-$(basename "$url")}"

    download_file "$url" "$output"

    if [ -n "$checksum_url" ]; then
        local expected_checksum=$(download_file "$checksum_url" -)
        local actual_checksum=$(sha256sum "$output" | cut -d' ' -f1)

        if [ "$expected_checksum" != "$actual_checksum" ]; then
            echo "Error: Checksum verification failed" >&2
            return 1
        fi
    fi
}