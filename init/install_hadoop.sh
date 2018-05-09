#!/bin/bash

wget http://archive.cloudera.com/cdh5/cdh/5/hadoop-2.6.0-cdh5.14.2.tar.gz
sudo tar -xvf hadoop-2.6.0-cdh5.14.2.tar.gz -C /usr/local/
sudo mv /usr/local/hadoop-2.6.0-cdh5.14.2 /usr/local/hadoop
