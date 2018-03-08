alias .='source'
alias e='open'
alias q='exit'
alias clean='mvn clean && gradle clean'
alias mysqlup='systemctl start mysqlid || service mysql start'
alias mysqldown='systemctl stop mysqlid || service mysql stop'
alias redisup='redis-server /usr/local/redis/redis.conf'

alias jb='fun () { dir=$(dirname $1) && name=$(basename $1 .java) && cd $dir && javac $(basename $1) && java $name && rm $name".class" && cd - > /dev/null;};fun'
alias rmall='fun () { find . -type f -name $1 | xargs rm -rv {} ;};fun'
# alias rmall='fun () { find . -type f -name $1 -delete ;};fun'

