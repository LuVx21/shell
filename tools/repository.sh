repository_name=coding-parent
mkdir -p ./$repository_name/.git/

cat > ./$repository_name/.git/config <<- EOF
[user]
    email = yeyu0926@hotmail.com
    name = F.LuVx
[core]
    repositoryformatversion = 0
    filemode = false
    bare = false
    logallrefupdates = true
    symlinks = false
    ignorecase = true
    autocrlf = input
    safecrlf = true
[remote "origin"]
    url = git@e.coding.net:LuVx21/code/${repository_name}
    url = git@github.com:LuVx21/${repository_name}
    url = git@gitee.com:LuVx/${repository_name}
    fetch = +refs/heads/*:refs/remotes/origin/*
[remote "coding"]
    url = git@e.coding.net:LuVx21/code/${repository_name}
    fetch = +refs/heads/*:refs/remotes/origin/*
[remote "github"]
    url = git@github.com:LuVx21/${repository_name}
    fetch = +refs/heads/*:refs/remotes/origin/*
[remote "gitee"]
    url = git@gitee.com:LuVx/${repository_name}
    fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
    remote = origin
    merge = refs/heads/master

EOF