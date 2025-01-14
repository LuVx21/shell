######################################Docker######################################
alias dk='docker'
alias dkb='docker build --build-arg CR=$ALI_CR_NS'
alias dkc='docker container'
alias dke='docker exec -it'
alias dki='docker image'
alias dkl='docker logs -f'
alias dkm='docker manifest'
alias dkn='docker network'
alias dkr='docker run --rm -it'
alias dkrd='docker run --rm -itd'
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

# alias grpcui="docker run --rm -it --name grpcui fullstorydev/grpcui"
# alias grpcurl="docker run --rm -it --name grpcurl fullstorydev/grpcurl"
# alias litecli="docker run --rm -it -v $(pwd):/data -w /data --name litecli $ALI_CR/luvx/litecli"
# alias mongosh="docker run --rm -it --name mongosh alpine/mongosh mongosh"
# alias mycli="docker run --rm -it --name mycli $ALI_CR/luvx/mycli"
alias mysql="docker run --rm -it --name mysql alpine/mysql"
# alias pgcli="docker run --rm -it --name pgcli $ALI_CR/luvx/pgcli"
# alias psql="docker run --rm -it --name psql alpine/psql"
# alias sqlite="docker run --rm -it -v $(pwd):/data -w /data --name sqlite alpine/sqlite"
# 例: usql sqlite3:./data/sqlite/main.db
# alias usql="docker run --rm -it -v $(pwd):/data -w /data --name usql usql/usql"
# alias octosql="docker run --rm -it --name octosql jauderho/octosql"
# alias iredis="docker run --rm -it --name ireids $ALI_CR/luvx/ireids:alpine-latest ireids"
# alias tl="docker run --rm -it -v $(pwd):/data -w /data --name toolong $ALI_CR/luvx/toolong:alpine-latest tl"
# alias dolphie="docker run --rm -it --name dolphie $ALI_CR/luvx/dolphie:latest dolphie"
# alias frogmouth="docker run --rm -it -v $(pwd):/data -w /data --name frogmouth $ALI_CR/luvx/frogmouth:alpine-latest frogmouth"