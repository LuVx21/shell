#!/bin/bash
for line in `find ./00.src/01.before -type f`
do
    after=${line/01\.before/02\.after}

    # 方式1:二进制比较
    cmp $line $after

    # 方式2:md5比较
    # before=`md5sum $line`
    # after=`md5sum $after`

    # before=${before:0:32}
    # after=${after:0:32}

    # if [ $before != $after ]
    # then
    #     echo $(basename $line) >> 1
    #     echo $before : $after >> 1
    # fi
done
