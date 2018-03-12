#! /bin/bash

# 配置linux环境用
yum install zsh
yum install git
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mkdir code && cd code
git clone https://github.com/luvx21/luvx_trial.git
git clone https://github.com/luvx21/shell.git

cp shell/init/alias.sh shell/init/path.sh ~
cd
mv alias.sh .alias
mv path.sh .path
echo 'source ~/.alias' >> ~/.zshrc
echo 'source ~/.path' >> ~/.zshrc


# 开放端口
iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
iptables save
# 或
# vi /etc/sysconfig/iptables
# -A INPUT -m state –state NEW -m tcp -p tcp –dport 8080 -j ACCEPT


# SpaceVim
# curl -sLf https://spacevim.org/install.sh | bash
# curl -sLf https://spacevim.org/install.sh | bash -s -- --uninstall

# centos
# yum -y install zlib-devel bzip2-devel openssl openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel
# yum install gcc gcc-c++
# yum -y install automake autoconf libtool make

# ubuntu
# apt-get install build-essential
# apt-get install libtool