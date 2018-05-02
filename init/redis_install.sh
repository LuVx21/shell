#! /bin/bash

wget http://download.redis.io/releases/redis-4.0.8.tar.gz
tar -zxvf redis-4.0.8.tar.gz
cd redis-4.0.8
make

# cli
src/redis-server
src/redis-cli

# sudo apt-get install tcl
cd src && make test
sudo make PREFIX=/usr/local/redis install

sudo cp ../redis.conf /usr/local/redis/

cd;echo "alias redisup='/usr/local/redis/bin/redis-server /usr/local/redis/redis.conf'" >> .alias
source .alias

# config redis.conf
