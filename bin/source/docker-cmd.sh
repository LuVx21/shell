function dockers() {

    if [ "$1" = "" ];
    then
        echo -e "需指定操作"
        # exit 1
    elif [ "$1" = "update" ];then
        docker images | tail +2 | grep -v luvx | awk '{print $1,$2}' | sed 's/ /:/g' | xargs -I F docker pull F
        # images=`docker container ls -a | tail +2 | grep -v luvx | awk '{print $2}' | sort | uniq`
        # for image in $images; do
        #     echo '更新...'$image
        #     docker pull $image
        # done
        # exit 0
    elif [ "$1" = "sync" ];then
    elif [ "$1" = "backup" ];then
        if [ "$2" = "" ];then
            echo -e "需指定镜像Id"
            # exit 1
        fi
        image=`docker images | grep $2 -m 1 | awk '{print $1}' | sed 's/\//_/g'`
        version=`docker images | grep $2 -m 1 | awk '{print $2}'`

        # 架构
        Architecture=`docker inspect $2 | jq -r '.[0].Architecture'`
        if [ "$Architecture" = "amd64" ];then
            version=$version\_amd64
        fi

        for registry in 'registry.cn-shanghai.aliyuncs.com' 'ccr.ccs.tencentyun.com'; do
            nimage=$registry/luvx21/$image
            echo '备份为->'$nimage:$version
            docker tag $2 $nimage:$version
            docker push $nimage:$version && docker image rm $nimage:$version
        done
        # exit 0
    else
        echo -e "无指定操作"
        # exit 1
    fi
}


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

# 镜像架构
function dk_arch {
    docker inspect $1 | jq -r '.[0].Architecture'
}