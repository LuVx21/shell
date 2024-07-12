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
