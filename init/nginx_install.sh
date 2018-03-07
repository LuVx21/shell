#! /bin/bash

# yum install -y pcre pcre-devel
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.37.tar.gz
tar -zxvf pcre-8.37.tar.gz
cd pcre-8.34
./configure --prefix=/usr/local/pcre
make && make install

# yum install -y zlib zlib-devel
wget http://zlib.net/zlib-1.2.8.tar.gz
tar -zxvf zlib-1.2.8.tar.gz
cd zlib-1.2.8
./configure --prefix=/usr/local/zlib
make && make install

wget http://nginx.org/download/nginx-1.12.2.tar.gz
tar -zxvf nginx-1.12.2.tar.gz
cd nginx-1.12.2
./configure --prefix=/usr/local/nginx
make && make install
