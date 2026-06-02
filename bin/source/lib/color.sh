#!/usr/bin/env bash
# 定义颜色代码
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 彩色输出函数
color_echo() {
    local color="$1"
    local msg="$2"
    echo -e "${color}$(date '+%Y-%m-%d %H:%M:%S') - ${msg}${NC}"
}

# 预定义的颜色输出
log_info() {
    color_echo "$CYAN" "[INFO] $*"
}

log_success() {
    color_echo "$GREEN" "[SUCCESS] $*"
}

log_warning() {
    color_echo "$YELLOW" "[WARNING] $*"
}

log_error() {
    color_echo "$RED" "[ERROR] $*" >&2
}