######################################Docker######################################
alias dk='docker'
alias dkb='docker build --build-arg CR=$ALI_CR_NS'
alias dkc='docker container'
alias dke='docker exec -it'
alias dki='docker image'
alias dkl='docker logs -f'
alias dkm='docker manifest'
alias dkn='docker network'
alias dkr='docker run -it --network=net_common --add-host="host.docker.internal:host-gateway"'
alias dkrm='dkr --rm'
alias dkrd='dkr -d'
alias dkrv='dkr -v $(pwd):/app -w /app --name "alias_$(date +%s)"'
alias dks='docker system'
alias dkv='docker volume'

alias dkin='docker inspect'
alias dkps='docker ps'

alias dkils='docker image ls --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}" | sort'

alias dkpsa='docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"'
alias dkpsdead='docker ps -f status=dead -a'
alias dkpsexited='docker ps -f status=exited -a'
alias dkpsf='docker ps -a -f'
# alias dkrm='docker rm -f -v'
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

# alias grpcui='dkrm --name grpcui fullstorydev/grpcui'
# alias grpcurl='dkrm --name grpcurl fullstorydev/grpcurl'
# alias litecli='dkrm -v $(pwd):/data -w /data --name litecli $ALI_CR/luvx/litecli'
alias mongosh='dkrm --name "mongosh_$(date +%s)" $ALI_CR/luvx/mongosh mongosh'
# alias mycli='dkrm --name mycli $ALI_CR/luvx/mycli:latest-alpine mycli'
alias mysql='dkrm --name mysql $ALI_CR/luvx/alpine_mysql'
alias duckdb='dkrm -v $(pwd):/root/data --name "duckdb_$(date +%s)" $ALI_CR/luvx/duckdb'
# alias pgcli='dkrm --name pgcli $ALI_CR/luvx/pgcli'
# alias psql='dkrm --name psql alpine/psql'
# alias sqlite='dkrm -v $(pwd):/data -w /data --name sqlite alpine/sqlite'
# 例: usql sqlite3:./data/sqlite/main.db
# alias usql='dkrm -v $(pwd):/data -w /data --name usql usql/usql'
# alias octosql='dkrm --name octosql jauderho/octosql'
# alias iredis='dkrm --name ireids $ALI_CR/luvx/ireids:latest-alpine ireids'
# alias tl='dkrm -v $(pwd):/data -w /data --name toolong $ALI_CR/luvx/toolong:latest-alpine tl'
# alias dolphie='dkrm --name dolphie $ALI_CR/luvx/dolphie:latest-alpine dolphie'
# alias frogmouth='dkrm -v $(pwd):/data -w /data --name frogmouth $ALI_CR/luvx/frogmouth:latest-alpine frogmouth'
# 检查所有更新
alias cup='dkrm -v /var/run/docker.sock:/var/run/docker.sock $GH_CR_NJU/sergi0g/cup check'
alias watchtower='dkrm -v /var/run/docker.sock:/var/run/docker.sock $GH_CR_NJU/nicholas-fedor/watchtower --cleanup --run-once'
alias gemini='dkrm -v $HOME/.gemini/oauth_creds.json:/root/.gemini/oauth_creds.json us-docker.pkg.dev/gemini-code-dev/gemini-cli/sandbox:0.18.0'
alias crush='dkrm -v $HOME/.config/crush/crush.json:/root/.config/crush/crush.json -e DEEPSEEK_API_KEY=$DEEPSEEK_KEY $ALI_CR/luvx/crush:latest-alpine crush'
# alias lazydocker='dkrm -v /var/run/docker.sock:/var/run/docker.sock $ALI_CR/luvx/lazydocker:latest-alpine lazydocker'
alias lazysql='dkrm -v $HOME/.config/lazysql/config.toml:/root/.config/lazysql/config.toml --name test $ALI_CR/luvx/lazysql:latest-alpine lazysql'
alias go-cyclic='dkrv $ALI_CR/luvx/go-cyclic:latest-alpine go-cyclic'
