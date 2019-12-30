#!/bin/bash

########################### user #################################
useradd -m luvx
echo 'luvx ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
su - luvx

# vim /etc/ssh/sshd_config
# PermitRootLogin no
# MaxAuthTries 3

########################### oh-my-zsh #################################
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
gcl https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
gcl https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
gcl https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
# 引入zsh-syntax-highlighting plugin
# sed -i "62izsh-syntax-highlighting" .zshrc

############################################################
mkdir code && cd code
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
############################################################
ssh-keygen -t rsa -C "yeyu0926@gmail.com"
cat ~/.ssh/id_rsa.pub >> authorized_keys
########################### vim #################################
升级vim8
curl -L https://copr.fedorainfracloud.org/coprs/hnakamur/vim/repo/epel-7/hnakamur-vim-epel-7.repo -o /etc/yum.repos.d/hnakamur-vim-epel-7.repo
yum update -y vim*

# SpaceVim
# curl -sLf https://spacevim.org/install.sh | bash
# curl -sLf https://spacevim.org/install.sh | bash -s -- --uninstall

########################### ??? #################################
# wget https://github.com/jingweno/ccat/releases/download/v1.1.0/linux-amd64-1.1.0.tar.gz

########################### saferm #################################
# curl https://raw.githubusercontent.com/lagerspetz/linux-stuff/master/scripts/saferm.sh > saferm.sh
git clone https://github.com/lagerspetz/linux-stuff
sudo mv linux-stuff/scripts/saferm.sh $(dirname $(which rm))
rm -Rf linux-stuff
echo 'alias rm=/bin/saferm.sh' >> ~/.alias
############################################################

wget http://www.rarlab.com/rar/rarlinux-3.8.0.tar.gz
tar zxvf rarlinux-3.8.0.tar.gz
cd rar
make
make install

############################ 命令行读md ################################
wget -o /usr/bin/mdr https://github.com/MichaelMure/mdr/releases/download/v0.2.0/mdr_linux_amd64
