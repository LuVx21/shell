#! /bin/bash

# 二进制文件安装
wget https://npm.taobao.org/mirrors/node/v8.9.3/node-v8.9.3-linux-x64.tar.xz
tar -xvf node-v8.9.3-linux-x64.tar.xz -C /usr/local
mv /usr/local/node-v8.9.3-linux-x64 /usr/local/nodejs

ln -s /usr/local/nodejs/bin/node /usr/local/bin/node
ln -s /usr/local/nodejs/bin/npm /usr/local/bin/npm

# 源码安装
git clone https://github.com/nodejs/node.git
sudo chmod -R 755 node

cd node
./configure --prefix=/usr/local/nodejs
make && make install

# sudo apt-get install nodejs
# sudo apt-get install npm
