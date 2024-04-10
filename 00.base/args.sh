#!/bin/bash

function test01() {
    arglen=$#
    if [ $arglen -eq 0 ]
    then
        echo 'haha'
    else
        pwd
    fi
}

function test02() {
    all_num=10

    a=$(date +%F' '%T)

    for num in `seq 1 ${all_num}`
    do
        sleep 1
        echo ${num}
    done

    b=$(date +%F' '%T)

    echo -e "startTime:\t$a"
    echo -e "endTime:\t$b"
}