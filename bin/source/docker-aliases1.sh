######################################Docker######################################
alias dk='docker'
alias dkb='docker build --build-arg CR=$ALI_CR_NS'
alias dkc='docker container'
alias dke='docker exec -it'
alias dki='docker image'
alias dkl='docker logs'
alias dkm='docker manifest'
alias dkn='docker network'
alias dks='docker system'
alias dkv='docker volume'
alias dcon='docker container'

alias dexec='docker exec -it'
alias dkimg='docker image ls --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}" | sort'
alias dklog='docker logs'
alias dkpsa='docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"'
alias dkpsdead='docker ps -f status=dead -a'
alias dkpsexited='docker ps -f status=exited -a'
alias dkpsf='docker ps -a -f'
alias dkrm='docker rm -f -v'
alias dkrun='docker run --rm -itd'
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
