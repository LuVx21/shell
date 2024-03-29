#!/bin/bash

# $#：表示传递给脚本或函数的参数个数
#1 获取输入参数个数，如果没有参数，直接退出
pcount=$#
if((pcount==0)); then
    echo no args;
    exit;
fi

#2 获取文件名称
p1=$1
fname=`basename $p1`
echo fname=$fname

#3 获取上级目录到绝对路径
pdir=`cd -P $(dirname $p1); pwd`
echo pdir=$pdir

#4 获取当前用户名称
user=`whoami`

#5 IP地址循环
# for((host=0; host<5; host++)); do
#     echo $pdir/$fname $user@192.168.3.15$host:$pdir
#     echo --------------- 192.168.3.15$host ----------------
#     rsync -rvl $pdir/$fname $user@192.168.3.15$host:$pdir
# done

#5 自定义域名循环
for host in {master,slaver1,slaver2,slaver3,slaver4,slaver5}; do
    #echo $pdir/$fname $user@$host:$pdir
    echo --------------- $host ----------------
    rsync -rvl $pdir/$fname $user@$host:$pdir
done

