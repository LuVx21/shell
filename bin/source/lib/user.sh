#!/usr/bin/env bash

is_root() { [ "$EUID" -eq 0 ]; }

# 询问是/否
ask_yes_no() {
    local prompt="$1"
    local default="${2:-n}"

    if [ "$default" = "y" ]; then
        prompt="$prompt [Y/n]: "
    else
        prompt="$prompt [y/N]: "
    fi

    read -p "$prompt" -n 1 -r
    echo

    if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY && "$default" = "y" ]]; then
        return 0
    else
        return 1
    fi
}

# 询问密码（不显示输入）
ask_password() {
    read -sp "$1: " password
    echo
    echo "$password"
}

# 从列表中选择
select_from_list() {
    local prompt="$1"
    shift
    local options=("$@")

    echo "$prompt"
    for i in "${!options[@]}"; do
        printf "%d) %s\n" $((i+1)) "${options[i]}"
    done

    while true; do
        read -p "选择 [1-${#options[@]}]: " choice
        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#options[@]}" ]; then
            echo "${options[$((choice-1))]}"
            return
        fi
        echo "无效选择"
    done
}