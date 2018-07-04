#!/bin/bash

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
