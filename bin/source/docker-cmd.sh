#!/bin/bash
function docker-login() {
    if ! [ -z "$DOCKER_REGISTRY_PASSWORD" ]; then
        echo $DOCKER_REGISTRY_PASSWORD | docker login -u $DOCKER_REGISTRY_USER --password-stdin
    fi
    if ! [ -z "$ALI_CR_PASSWORD" ]; then
        echo -n "登录阿里云容器服务:"
        echo $ALI_CR_PASSWORD | docker login -u $ALI_CR_USER $ALI_CR --password-stdin
        echo -n "登录腾讯云容器服务:"
        echo $ALI_CR_PASSWORD | docker login -u $TX_CR_USER $TX_CR --password-stdin
    fi
    if ! [ -z "$GH_CR_PASSWORD" ]; then
        echo -n "登录Github容器服务:"
        echo $GH_CR_PASSWORD | docker login -u $GH_CR_USER ghcr.io --password-stdin
    fi
}

function dockers() {

    if [ "$1" = "" ]; then
        echo -e "需指定操作"
        # exit 1
    elif [ "$1" = "update" ]; then
        # docker images | tail +2 | grep -v luvx | grep -v none | awk '{print $1,$2}' | sed 's/ /:/g' | sort | uniq | xargs -I F docker pull F
        docker images | tail +2 | grep -v luvx | grep -v none | awk '{print $1,$2}' | sed 's/ /:/g' | sort | uniq | xargs -I F docker inspect --format='docker pull --platform={{.Os}}/{{.Architecture}} F' F | xargs -I F sh -c "F"
        # docker image ls --format "table {{.Repository}}:{{.Tag}}" | tail +2 | grep -v luvx | grep -v none | sort | uniq | xargs -I F docker inspect --format='docker pull --platform={{.Os}}/{{.Architecture}} F' F | xargs -I F sh -c "F"

        # images=`docker container ls -a | tail +2 | grep -v luvx | awk '{print $2}' | sort | uniq`
        # for image in $images; do
        #     echo '更新...'$image
        #     docker pull $image
        # done
        # exit 0
    elif [ "$1" = "manifest" ]; then
        local source_image=$2 target_image=$3
        local tag=$(echo $target_image | awk -F':' '{if (NF==2) print $2; else print ""}')
        if [ -z $tag ]; then
            tag=$(echo $source_image | awk -F':' '{if (NF==2) print $2; else print "latest"}')
        fi
        local ps=""
        local cmd=""
        for p in 'linux/arm64' 'linux/amd64'; do
            local temp_tag="${tag}_${p//\//_}"
            ps+="$target_image:$temp_tag "
            cmd+="echo "拉/推送镜像,架构:$p";\n docker pull --platform=$p $source_image && docker tag $source_image $target_image:$temp_tag && docker push $target_image:$temp_tag;\n"
        done
        cmd+="\n echo '创建manifest...' && \
        \n docker manifest create $target_image:$tag $ps && \
        \n echo '推送manifest...' && \
        \n docker manifest push $target_image:$tag && \
        \n echo '删除manifest...' && \
        \n docker manifest rm $target_image:$tag;
        "
        echo -e $cmd
        echo -n "请确认是否执行(y/n):"
        read -t 10 y;
        if [ $y = 'y' ]; then
            eval $(echo -e $cmd)
        fi
    elif [ "$1" = "backup" ]; then
        if [ "$2" = "" ];then
            echo -e "需指定镜像Id"
            # exit 1
        fi
        local input_arr=($@)
        local slice=( "${input_arr[@]:1}" )
        for id in ${slice[@]}; do
            # local image=`docker images | grep $id -m 1 | awk '{print $1}' | sed 's/\//_/g'`
            local image=`docker images | grep $id -m 1 | awk '{print $1}'`
            [[ $image == luvx/* ]] && image=${image#luvx/} || image=${image/\//_}
            local version=`docker images | grep $id -m 1 | awk '{print $2}'`

            if [[ -z $image || -z $version ]]; then
                echo -e "未找到镜像 $id"
                continue
            fi
            # 架构
            local Architecture=`docker inspect $id | jq -r '.[0].Os + "_" + .[0].Architecture'`
            version=$version\_$Architecture

            for registry in $TX_CR_NS $ALI_CR_NS; do
                local nimage=$registry/$image
                echo '备份为->'$nimage:$version
                docker tag $id $nimage:$version
                docker push $nimage:$version && docker image rm $nimage:$version
            done
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