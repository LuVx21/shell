#!/bin/bash

wget http://mirrors.tuna.tsinghua.edu.cn/apache/kafka/2.2.0/kafka_2.12-2.2.0.tgz
sudo tar -zxvf kafka_2.12-2.2.0.tgz -C /usr/local/
sudo mv /usr/local/kafka_2.12-2.2.0 /usr/local/kafka

