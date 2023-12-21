#!/bin/bash

for port in `seq 6371 6372`; do \
  PORT=${port} envsubst < template.tmpl > ${port}.txt
done