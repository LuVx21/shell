#!/bin/bash


function mvn-compile-pl-fn() {
    if [ "$1" = "" ];
    then
        echo -e "需指定模块名"
        return
    fi

    #-T 1C -Dmaven.test.skip=true -Dmaven.compile.fork=true --offline
    mvn compile \
    -pl $1 --also-make -DskipTests
}
