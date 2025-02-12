######################################Docker######################################
alias dk='docker'
alias dkb='docker build --build-arg CR=$ALI_CR_NS'
alias dkc='docker container'
alias dke='docker exec -it'
alias dki='docker image'
alias dkl='docker logs -f'
alias dkm='docker manifest'
alias dkn='docker network'
alias dkr='docker run --rm -it --add-host="host.docker.internal:host-gateway"'
alias dkrd='docker run --rm -itd --add-host="host.docker.internal:host-gateway"'
# alias dkrv='dkr -v $(pwd):/root/data'
alias dks='docker system'
alias dkv='docker volume'

alias dkin='docker inspect'
alias dkps='docker ps'

alias dkils='docker image ls --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}" | sort'

alias dkpsa='docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"'
alias dkpsdead='docker ps -f status=dead -a'
alias dkpsexited='docker ps -f status=exited -a'
alias dkpsf='docker ps -a -f'
alias dkrm='docker rm -f -v'
alias dkstp='docker stop'
alias dkstrt='docker start'
##############################################################################

function dkni-fn {
    docker inspect $1 | jq '.[0].Containers | .[]' | jq '.IPv4Address+"    "+.Name' | sed 's/"//g' | sort
}
alias dkchkhealth='docker inspect -f "{{json .State.Health}}"'
alias dkenv='docker inspect -f "{{json .Config.Env}}"'
alias dklabels='docker inspect -f "{{json .Config.Labels}}"'
alias dklogpath='docker inspect -f "{{.LogPath}}"'
alias dkmount='docker inspect -f "{{json .Mounts}}"'
alias dknetmode='docker inspect -f "{{json .HostConfig.NetworkMode}}"'
alias dkst='docker inspect -f "{{json .State}}"'

alias dkni=dkni-fn


alias dkbb='docker buildx build --build-arg CR=$ALI_CR_NS'

alias dkpull='fun() { docker pull dockerproxy.net/$1; docker tag dockerproxy.net/$1 $1; docker image rm dockerproxy.net/$1;};fun'

# alias grpcui='dkr --name grpcui fullstorydev/grpcui'
# alias grpcurl='dkr --name grpcurl fullstorydev/grpcurl'
# alias litecli='dkr -v $(pwd):/data -w /data --name litecli $ALI_CR/luvx/litecli'
# alias mongosh='dkr --name mongosh alpine/mongosh mongosh'
# alias mycli='dkr --name mycli $ALI_CR/luvx/mycli'
alias mysql='dkr --name mysql alpine/mysql'
alias duckdb='dkr -v $(pwd):/root/data --name "duckdb_$(date +%s)" $ALI_CR/luvx/duckdb'
# alias pgcli='dkr --name pgcli $ALI_CR/luvx/pgcli'
# alias psql='dkr --name psql alpine/psql'
# alias sqlite='dkr -v $(pwd):/data -w /data --name sqlite alpine/sqlite'
# 例: usql sqlite3:./data/sqlite/main.db
# alias usql='dkr -v $(pwd):/data -w /data --name usql usql/usql'
# alias octosql='dkr --name octosql jauderho/octosql'
# alias iredis='dkr --name ireids $ALI_CR/luvx/ireids:latest-alpine ireids'
# alias tl='dkr -v $(pwd):/data -w /data --name toolong $ALI_CR/luvx/toolong:latest-alpine tl'
# alias dolphie='dkr --name dolphie $ALI_CR/luvx/dolphie:latest dolphie'
# alias frogmouth='dkr -v $(pwd):/data -w /data --name frogmouth $ALI_CR/luvx/frogmouth:latest-alpine frogmouth'
