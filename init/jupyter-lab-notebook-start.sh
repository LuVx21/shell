#!/bin/bash
pip install --upgrade pip
pip install ipython \
# jupyter \
jupyterlab

# Java内核
wget https://github.com/SpencerPark/IJava/releases/download/v1.3.0/ijava-1.3.0.zip
unzip ijava-1.3.0.zip -d ./ijava
cd ijava && python install.py --sys-prefix && cd -

# kotlin内核
pip install kotlin-jupyter-kernel

# go内核
# https://github.com/gopherdata/gophernotes
env GO111MODULE=off go get -d -u github.com/gopherdata/gophernotes
cd "$(go env GOPATH)"/src/github.com/gopherdata/gophernotes
env GO111MODULE=on go install
mkdir -p ~/.local/share/jupyter/kernels/gophernotes
cp kernel/* ~/.local/share/jupyter/kernels/gophernotes
cd ~/.local/share/jupyter/kernels/gophernotes
chmod +w ./kernel.json # in case copied kernel.json has no write permission
sed "s|gophernotes|$(go env GOPATH)/bin/gophernotes|" < kernel.json.in > kernel.json
cd -

# 插件
# pip install jupyter_contrib_nbextensions
# jupyter contrib nbextension install --user

# pip install jupyter_nbextensions_configurator
# jupyter nbextensions_configurator enable --user

# pip install autopep8

# ------------------------------jupyter notebook-------------------------------------
# export PASSWORD=xxxx
# nohup jupyter notebook --ip 0.0.0.0 --port 58081 --no-browser --allow-root --notebook-dir ~/code/doc > out.file 2>&1 &
# echo -e "\r\nStarting..."

# ------------------------------jupyter lab-------------------------------------
# ipython
# from notebook.auth import passwd
# passwd() # 生成密码,复制备用

jupyter lab --generate-config
# vim ~/.jupyter/jupyter_notebook_config.py
cat >> ~/.jupyter/jupyter_notebook_config.py << EOF
c.ServerApp.allow_remote_access = True
c.ServerApp.open_browser = False
c.ServerApp.password = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
c.ServerApp.ip = '0.0.0.0'
c.ServerApp.port = 58082
c.ServerApp.allow_root = True
EOF

nohup jupyter lab --notebook-dir ~/code/doc > out.file 2>&1 &
echo -e "\r\nStarting..."
