#!/bin/bash
for line in `find ./src/main/java -type f`
do
    after=${line/01\.before/02\.after}
    before=`md5sum $line`
    after=`md5sum $after`

    before=${before:0:32}
    after=${after:0:32}

    if [ $before != $after ]
    then
        echo $(basename $line) >> 1
        echo $before : $after >> 1
    fi
done
