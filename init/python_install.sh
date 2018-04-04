#! /bin/bash

wget https://www.python.org/ftp/python/3.5.5/Python-3.5.5.tar.xz

tar -xvf Python-3.5.5.tar.xz
cd Python-3.5.5
./configure --prefix=/usr/local/python3
make && make install

ln -s /usr/local/python3/bin/python3.5 /usr/local/bin/python3
ln -s /usr/local/python3/bin/pip3.5 /usr/local/bin/pip3
pip install --upgrade pip

mkdir ~/.pip
echo '[global]' >> ~/.pip/pip.conf
echo 'index-url = https://pypi.tuna.tsinghua.edu.cn/simple' >> ~/.pip/pip.conf

