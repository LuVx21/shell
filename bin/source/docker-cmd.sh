function docker-tag() {

    namespace=$1
    repositorie=$2
    name=$3

    if [[ $# -lt 1 ]] || [[ "$1" == "-h" ]]; then
        cat << HELP

docker-tag -- 列出docker镜像的tags

Options:
    -h 查看说明

EXAMPLE:
    - list all tags for repositorie:redisearch of namespace:redislabs:
    docker-tag redislabs redisearch

    - list all redisearch tags containing 2.8:
    docker-tag redislabs redisearch 2.8

HELP
        return
    fi

    # if [[ -n "${namespace}" ]]; then
    #     # echo "Search image ${repositorie} on ${repo_url}"
    # else
    #     exit 1
    # fi

    # https://hub.docker.com/v2/repositories/redislabs/redisearch/tags/?page_size=25&page=2&name=2&ordering
    tags=`curl -L -s "https://hub.docker.com/v2/namespaces/$namespace/repositories/$repositorie/tags?page=1&page_size=100&name=$name" | jq '.results[]["name"]' | sed 's/\"//g' | sort -u`

    if [ -n "$3" ]
    then
        tags=` echo "${tags}" | grep "$3" `
    fi

    echo "${tags}"

}