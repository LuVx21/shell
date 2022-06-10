#!/bin/bash

########################### user #################################
useradd -m luvx
echo 'luvx ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
su - luvx

# vim /etc/ssh/sshd_config
# PermitRootLogin no
# MaxAuthTries 3

# ssh-copy-id user@host

########################### user #################################
yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel asciidoc
yum install gcc perl-ExtUtils-MakeMaker
yum remove git
wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.32.0.tar.xz
tar -xvf git-2.32.0.tar.xz
cd git-2.32.0
make prefix=/usr/local/git all
make prefix=/usr/local/git install
echo "export PATH=$PATH:/usr/local/git/bin" >> /etc/profile && source /etc/profile
git --version


yum install wget gcc openssl-devel -y
wget https://curl.haxx.se/download/curl-7.67.0.tar.gz
gunzip -c curl-7.83.0.tar.gz | tar xvf -
cd curl-7.67.0
./configure --with-ssl --prefix=/usr/local/curl
make && make install
echo "export PATH=/usr/local/curl/bin:$PATH" >> /etc/profile && source /etc/profile
curl --version

# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
/bin/bash -c "$(curl -fsSL 'https://cdn.jsdelivr.net/gh/Mintimate/HomebrewLinux@latest/HomebrewAutoInstall-Linux.sh')"

echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /etc/profile && source /etc/profile


########################### oh-my-zsh #################################
oh-my-zsh() {
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    gcl --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    gcl --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    gcl --depth=1 https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
    # 引入zsh-syntax-highlighting plugin
    # sed -i "62izsh-syntax-highlighting" .zshrc
}

############################ alias ################################
init_alias() {
    mkdir code && cd code
    git clone https://github.com/luvx21/shell.git --depth=1
    cp shell/init/alias.sh shell/init/path.sh shell/init/vim/vimrc ~
    cd
    mv alias.sh .alias
    mv path.sh .path
    echo 'source ~/.alias' >> ~/.zshrc
    echo 'source ~/.path' >> ~/.zshrc

    mv vimrc .vimrc
    mkdir ~/.vim
    git clone https://github.com/tomasr/molokai ~/.vim/molokai
    mv ~/.vim/molokai/colors ~/.vim
}
############################# git ###############################
init_git() {
    git config --global user.name "F.LuVx"
    git config --global user.email "yeyu0926@hotmail.com"
    ssh-keygen -t rsa -C "yeyu0926@hotmail.com"
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
}
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
git clone https://github.com/lagerspetz/linux-stuff --depth=1
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
