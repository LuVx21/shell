# alias cat=ccat
# alias rm=/bin/saferm.sh
# alias j=autojump
alias .='source'
alias e='open'
alias q='exit'

######################################自定义######################################
# alias rm='trash -F'
alias rss='~/OneDrive/Code/rss/rss.sh'
alias proxy='export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890'
# proxy
alias unproxy='unset http_proxy;unset https_proxy;unset all_proxy'
alias proxy_status='echo $http_proxy $https_proxy;curl cip.cc;curl ip.im/info'
alias bak1='fun() { rsync -av --exclude="target" $1/. $1_bak;};fun'

# alias mysqlup='systemctl start mysqlid || service mysql start'
# alias mysqldown='systemctl stop mysqlid || service mysql stop'
# alias redisup='redis-server /usr/local/redis/redis.conf'

# alias rmall='fun () { find . -type f -name $1 | xargs rm -rv {} ;};fun'
# alias rmall='fun () { find . -type f -name $1 -delete ;};fun'
alias mvn1='mvnd -T 1C -Dmaven.test.skip=true -Dmaven.compile.fork=true'
######################################Git######################################
alias gdiff='fun() { git diff --full-index $1...$2; };fun'
alias gdcab='git diff --cached --binary'
alias gstaco='git add --all && git stash && git checkout $1'
alias ggpush1='ggpull && ggpush'

alias gcbdesc='git config branch."$(git_current_branch)".description $1'
alias gbdesc='gcf | grep "branch.*desc.*"'
###################################### ######################################
ckv() {
    local key="$1"
    sqlite3 $HOME/data/sqlite/main.db "select common_value from common_key_value where invalid = 0 and biz_type = 0 and common_key = '$key'"
}

alias pc='pbcopy'
alias pp='pbpaste'