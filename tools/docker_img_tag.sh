#!/bin/sh
# 查询docker镜像的tag
repo_url=https://registry.hub.docker.com/v1/repositories
image_name=$1

curl -s ${repo_url}/${image_name}/tags | json_reformat | grep name | awk '{print $2}' | sed -e 's/"//g'

