#!/bin/bash

for port in `seq 6371 6372`; do \
  PORT=${port} envsubst < template.tmpl > ${port}.txt
  # 或
  # file_text=$(< ./template.tmpl)
  # eval "cat <<EOF
  # $file_text
  # EOF" > ${port}.txt
done