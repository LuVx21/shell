#!/bin/bash

useradd -m luvx
echo 'luvx ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
su - luvx

# vim /etc/ssh/sshd_config
# PermitRootLogin no
# MaxAuthTries 3

sudo yum update
sudo yum -y install gcc gcc-c++ automake autoconf libtool make zlib-devel bzip2-devel openssl openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel

sudo yum install git zsh tree
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# 引入zsh-syntax-highlighting plugin
# sed -i "62izsh-syntax-highlighting" .zshrc
# ssh-keygen -t rsa -C "yeyu0926@gmail.com"

mkdir code && cd code
git clone https://github.com/luvx21/luvx_trial.git
git clone https://github.com/luvx21/shell.git
cp shell/init/alias.sh shell/init/path.sh shell/init/vimrc ~
cd
mv alias.sh .alias
mv path.sh .path
mv vimrc .vimrc
echo 'source ~/.alias' >> ~/.zshrc
echo 'source ~/.path' >> ~/.zshrc
git clone https://github.com/tomasr/molokai ~/.vim/molokai
mv ~/.vim/molokai/colors ~/.vim

# SpaceVim
# curl -sLf https://spacevim.org/install.sh | bash
# curl -sLf https://spacevim.org/install.sh | bash -s -- --uninstall

# 开放端口
# iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
# iptables save
# 或
# vi /etc/sysconfig/iptables
# -A INPUT -m state –state NEW -m tcp -p tcp –dport 8080 -j ACCEPT


# wget https://github.com/jingweno/ccat/releases/download/v1.1.0/linux-amd64-1.1.0.tar.gz
sudo yum install cloc
sudo yum install autojump
sudo yum install -y tmux
sudo yum install -y ipython
sudo yum install -y htop

