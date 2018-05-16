#!/bin/bash

useradd -m luvx
echo 'luvx ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
su - luvx

# vim /etc/ssh/sshd_config
# PermitRootLogin no
# MaxAuthTries 3

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

# wget https://github.com/jingweno/ccat/releases/download/v1.1.0/linux-amd64-1.1.0.tar.gz

# saferm
git clone https://github.com/lagerspetz/linux-stuff
sudo mv linux-stuff/scripts/saferm.sh $(dirname $(which rm))
rm -Rf linux-stuff
echo 'alias rm=/bin/saferm.sh' >> ~/.alias

wget http://www.rarlab.com/rar/rarlinux-3.8.0.tar.gz
tar zxvf rarlinux-3.8.0.tar.gz
cd rar
make
make install
