#!/usr/bin/env bash

# 读取配置文件
read_config() {
    local config_file="$1"
    local key="$2"

    if [ -f "$config_file" ]; then
        grep "^$key=" "$config_file" | cut -d'=' -f2-
    fi
}

# 写入配置文件
write_config() {
    local config_file="$1"
    local key="$2"
    local value="$3"

    if [ ! -f "$config_file" ]; then
        touch "$config_file"
    fi

    if grep -q "^$key=" "$config_file"; then
        sed -i "s|^$key=.*|$key=$value|" "$config_file"
    else
        echo "$key=$value" >> "$config_file"
    fi
}

# 备份文件
backup_file() {
    local file="$1"
    local backup_dir="${2:-./backups}"

    if [ ! -f "$file" ]; then
        log_error "文件不存在: $file"
        return 1
    fi

    mkdir_safe "$backup_dir"

    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_file="$backup_dir/$(basename "$file").$timestamp.bak"

    cp "$file" "$backup_file"
    log_success "备份完成: $backup_file"
    echo "$backup_file"
}

# 恢复备份
restore_backup() {
    local file="$1"
    local backup_dir="${2:-./backups}"

    local latest_backup=$(ls -t "$backup_dir/$(basename "$file")."*.bak 2>/dev/null | head -1)

    if [ -z "$latest_backup" ]; then
        log_error "没有找到备份文件"
        return 1
    fi

    cp "$latest_backup" "$file"
    log_success "从 $latest_backup 恢复完成"
}