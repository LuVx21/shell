#!/bin/bash

KV_DIR="${HOME}/.kv"
DEFAULT_BUCKET="default"

# 确保存储目录存在
mkdir -p "${KV_DIR}"

# 帮助信息
show_help() {
    cat << EOF
简单的键值对存储
用法: kv <命令> [参数] [@bucket]

命令:
  set <key> <value> [@bucket]   设置键值对
  get <key> [@bucket]           获取键对应的值
  del <key> [@bucket]           删除键值对
  ls [选项] [@bucket]           列出信息
    -b     列出所有bucket
    -k     列出指定bucket的所有key
    -v     列出指定bucket的所有value

参数:
  @bucket  存储桶名称, 默认为"default"
EOF
}

# 获取bucket文件路径
get_bucket_file() {
    local bucket="$1"
    echo "${KV_DIR}/${bucket}.kv.txt"
}

# 解析bucket参数
parse_bucket() {
    local args=("$@")
    local bucket="$DEFAULT_BUCKET"

    for ((i=${#args[@]}-1; i>=0; i--)); do
        if [[ "${args[i]}" =~ ^@ ]]; then
            bucket="${args[i]:1}"
            break
        fi
    done
    echo "$bucket"
}

# 过滤掉bucket参数
filter_args() {
    local args=("$@")
    local filtered=()

    for arg in "${args[@]}"; do
        if [[ ! "${arg}" =~ ^@ ]]; then
            filtered+=("$arg")
        fi
    done
    echo "${filtered[@]}"
}

del() {
    local key=$1
    local bucket_file=$2
    grep -v "^${key}=" "$bucket_file" > "${bucket_file}.tmp" 2>/dev/null || true
    mv "${bucket_file}.tmp" "$bucket_file"
}

case "$1" in
    set)
        args=($(filter_args "${@:2}"))
        if [ ${#args[@]} -lt 2 ]; then
            echo "错误: 缺少参数。用法: kv set <key> <value> [@bucket]"
            exit 1
        fi

        key="${args[0]}"
        value="${args[1]}"
        bucket=$(parse_bucket "${@:2}")
        bucket_file=$(get_bucket_file "$bucket")

        # 如果文件存在, 先删除这个key
        if [ -f "$bucket_file" ]; then
            del ${key} ${bucket_file}
        fi

        # 添加新的键值对
        echo "${key}=${value}" >> "$bucket_file"
        echo "已设置: ${key}=${value} (bucket: ${bucket})"
        ;;

    get)
        args=($(filter_args "${@:2}"))
        if [ ${#args[@]} -lt 1 ]; then
            echo "错误: 缺少参数。用法: kv get <key> [@bucket]"
            exit 1
        fi

        key="${args[0]}"
        bucket=$(parse_bucket "${@:2}")
        bucket_file=$(get_bucket_file "$bucket")

        if [ ! -f "$bucket_file" ]; then
            # echo "bucket '${bucket}' 不存在或为空"
            exit 0
        fi

        value=$(grep "^${key}=" "$bucket_file" | cut -d'=' -f2- 2>/dev/null || true)

        if [ -z "$value" ]; then
            # echo "键 '${key}' 在 bucket '${bucket}' 中不存在"
            exit 0
        else
            echo "$value"
        fi
        ;;

    del)
        args=($(filter_args "${@:2}"))
        if [ ${#args[@]} -lt 1 ]; then
            echo "错误: 缺少参数。用法: kv del <key> [@bucket]"
            exit 1
        fi

        key="${args[0]}"
        bucket=$(parse_bucket "${@:2}")
        bucket_file=$(get_bucket_file "$bucket")

        if [ ! -f "$bucket_file" ]; then
            # echo "bucket '${bucket}' 不存在或为空"
            exit 0
        fi

        if grep -q "^${key}=" "$bucket_file"; then
            del ${key} ${bucket_file}
            echo "已删除键: ${key} (bucket: ${bucket})"

            # 如果文件为空, 删除它
            if [ ! -s "$bucket_file" ]; then
                rm -f "$bucket_file"
            fi
        else
            # echo "键 '${key}' 在 bucket '${bucket}' 中不存在"
            exit 0
        fi
        ;;

    ls)
        shift
        option=""
        bucket="$DEFAULT_BUCKET"

        # 解析选项和bucket
        for ((i=$#; i>=1; i--)); do
            arg="${!i}"
            if [[ "$arg" == "-b" || "$arg" == "-k" || "$arg" == "-v" ]]; then
                if [ -z "$option" ]; then
                    option="$arg"
                fi
            elif [[ "${arg}" =~ ^@ ]]; then
                bucket="${arg:1}"
            fi
        done

        case "$option" in
            -b)
                echo "可用的bucket:"
                for file in "${KV_DIR}"/*.kv.txt; do
                    [ -e "$file" ] || continue
                    filename=$(basename "$file" .kv.txt)
                    echo "  @${filename}"
                done
                if [ ! -f "${KV_DIR}/${DEFAULT_BUCKET}.kv.txt" ]; then
                    echo "  @${DEFAULT_BUCKET}"
                fi
                ;;

            -k)
                bucket_file=$(get_bucket_file "$bucket")
                # 文件不存在或内容空
                if [ ! -f "$bucket_file" ] || [ ! -s "$bucket_file" ]; then
                    exit 0
                fi
                cut -d'=' -f1 "$bucket_file" 2>/dev/null
                ;;

            -v)
                bucket_file=$(get_bucket_file "$bucket")
                if [ ! -f "$bucket_file" ] || [ ! -s "$bucket_file" ]; then
                    exit 0
                fi
                cut -d'=' -f2- "$bucket_file" 2>/dev/null
                ;;

            "")
                bucket_file=$(get_bucket_file "$bucket")
                if [ ! -f "$bucket_file" ] || [ ! -s "$bucket_file" ]; then
                    exit 0
                fi
                cat "$bucket_file" | while IFS='=' read -r key value; do
                    printf "%-40s %s\n" "$key" "$value"
                done
                ;;

            *)
                echo "错误: 无效选项 '$option'"
                echo "用法: kv ls [-b|-k|-v] [@bucket]"
                exit 1
                ;;
        esac
        ;;

    --help|-h)
        show_help
        ;;

    *)
        echo "错误: 未知命令 '$1'"
        echo "使用 'kv --help' 查看帮助"
        exit 1
        ;;
esac