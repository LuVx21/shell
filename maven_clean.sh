#!/bin/bash

# rm ./1.txt ./2.txt

find ~/.m2 -iname '*.pom' | while read pom; do
  parent=$(dirname "$pom")
  echo $(dirname "$parent") >>1.txt
done

cat 1.txt | uniq -d >2.txt

for line in $(cat 2.txt); do
  last=$(ls $line | tail -1)
  for file in $(ls $line); do
    # echo $file;
    if [ "$file" != "$last" ]; then
      # echo $line/$file;
      rm -rf $line/$file
    fi
  done
done

rm ./1.txt ./2.txt
