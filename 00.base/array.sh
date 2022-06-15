#!/bin/bash

string="tx-dev/luvx-http-server/luvx-server"
# 字符串分割
array=(`echo $string | tr '/' ' '` )

for var in ${array[@]}
do
   echo $var
done

echo "第一个元素为: ${array[0]}"



