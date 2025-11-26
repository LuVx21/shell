source_home=$(cd `dirname $0`; pwd)
# echo "source $source_home/init.sh" > ~/.zshrc

source $source_home/env.sh
source $source_home/path.sh

source $source_home/alias.sh
source $source_home/docker-aliases.sh
source $source_home/docker-aliases1.sh

source $source_home/daily.sh
source $source_home/mvns.sh

source $source_home/docker-cmd.sh
source $source_home/tool.sh
source $source_home/zsh.sh

if [ -f "$source_home/secrets.sh" ]; then
  source $source_home/secrets.sh
fi

if [ ! -f "${HOME}/data/bin/kkv" ]; then
  ln -s $source_home/script/kv.sh ${HOME}/data/bin/kkv
fi
if [ ! -f "${HOME}/data/bin/mac" ]; then
  ln -s $source_home/script/mac.sh ${HOME}/data/bin/mac
fi
