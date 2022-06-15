#!/bin/bash

# shell 循环

#for ((i = 1; i <= 10; i++)); do
#for i in $(seq 1 10); do
for i in {1..10}; do
  echo $(expr $i \* 3 + 1)
done

#awk 'BEGIN{for(i=1; i<=10; i++) print i}'

#for i in $(ls); do
#for i in $*; do
#for i in f1 f2 f3; do
list="a b c d"
for i in $list; do
  echo $i is args\!
done

#for file in $(ls *.sh); do
for file in ~/*; do
  echo $file is file path\!
done
