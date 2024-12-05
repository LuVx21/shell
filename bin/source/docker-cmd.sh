function docker-login() {
    if ! [ -z "$DOCKER_REGISTRY_PASSWORD" ]; then
        echo $DOCKER_REGISTRY_PASSWORD | docker login -u $DOCKER_REGISTRY_USER --password-stdin
    fi
    if ! [ -z "$ALIYUN_REGISTRY_PASSWORD" ]; then
        echo -e "登录阿里云容器服务"
        echo $ALIYUN_REGISTRY_PASSWORD | docker login -u $ALIYUN_REGISTRY_USER $ALIYUN_REGISTRY --password-stdin
        echo -e "登录腾讯云容器服务"
        echo $ALIYUN_REGISTRY_PASSWORD | docker login -u $TXYUN_REGISTRY_USER $TXYUN_REGISTRY --password-stdin
    fi
    if ! [ -z "$GHCR_REGISTRY_PASSWORD" ]; then
        echo -e "登录Github容器服务"
        echo $GHCR_REGISTRY_PASSWORD | docker login -u $GHCR_REGISTRY_USER ghcr.io --password-stdin
    fi
}

function dockers() {

    if [ "$1" = "" ];
    then
        echo -e "需指定操作"
        # exit 1
    elif [ "$1" = "update" ];then
        docker images | tail +2 | grep -v luvx | grep -v none | awk '{print $1,$2}' | sed 's/ /:/g' | sort | uniq | xargs -I F docker pull F
        # images=`docker container ls -a | tail +2 | grep -v luvx | awk '{print $2}' | sort | uniq`
        # for image in $images; do
        #     echo '更新...'$image
        #     docker pull $image
        # done
        # exit 0
    elif [ "$1" = "manifest" ];then
        local source_image=$2 target_image=$3
        local tag=$(echo $source_image | awk -F':' '{if (NF==2) print $2; else print "latest"}')
        local ps=""
        for p in 'linux/amd64' 'linux/arm64'; do
            local temp_tag="${tag}_${p//\//_}"
            ps+="$target_image:$temp_tag "
            echo "docker pull --platform=$p $source_image && docker tag $source_image $target_image:$temp_tag && docker push $target_image:$temp_tag"
        done
        echo "docker manifest create $target_image:$tag $ps && docker manifest push $target_image:$tag && docker manifest rm $target_image:$tag"
    elif [ "$1" = "backup" ];then
        if [ "$2" = "" ];then
            echo -e "需指定镜像Id"
            # exit 1
        fi
        local image=`docker images | grep $2 -m 1 | awk '{print $1}' | sed 's/\//_/g'`
        local version=`docker images | grep $2 -m 1 | awk '{print $2}'`

        # 架构
        local Architecture=`docker inspect $2 | jq -r '.[0].Os + "_" + .[0].Architecture'`
        version=$version\_$Architecture

        for registry in $TXYUN_REGISTRY $ALIYUN_REGISTRY; do
            local nimage=$registry/luvx21/$image
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

    local namespace=$1
    local repositorie=$2
    local name=$3

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
    local tags=`curl -L -s "https://hub.docker.com/v2/namespaces/$namespace/repositories/$repositorie/tags?page=1&page_size=100&name=$name" | jq '.results[]["name"]' | sed 's/\"//g' | sort -u`

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