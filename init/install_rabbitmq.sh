#!/bin/bash

sudo yum install erlang
wget https://dl.bintray.com/rabbitmq/all/rabbitmq-server/3.6.14/rabbitmq-server-3.6.14-1.el7.noarch.rpm
sudo yum localinstall rabbitmq-server-3.6.14-1.el7.noarch.rpm
