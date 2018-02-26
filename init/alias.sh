alias clean='mvn clean && gradle clean'
alias jb='fun () { dir=$(dirname $1) && name=$(basename $1 .java) && cd $dir && javac $(basename $1) && java $name && rm $name".class" && cd - > /dev/null;};fun'
alias rmall='fun () { find . -type f -name $1 | xargs rm -rv {} ;};fun'
# alias rmall='fun () { find . -type f -name $1 -delete ;};fun'
alias redisup='redis-server /usr/local/redis/redis.conf'

