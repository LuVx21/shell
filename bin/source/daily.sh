#!/bin/bash

function daily-fn {
    echo "copy....."
    cp $HOME/Library/Application\ Support/Microsoft\ Edge\ Dev/Default/Cookies $HOME/data/sqlite

    echo "delete......"
    rm $HOME/Library/Application\ Support/Beyond\ Compare*/registry.dat
    rm ~/docker/freshrss/data/cache/*.spc

    echo "brew......"
    brew update && brew upgrade && brew cu -af

    echo "brew clean"
    brew cleanup && brew autoremove
    rm -fr $HOME/Library/Caches/Homebrew/downloads

    omz update &

    if [ -d "/Volumes/WD" ]; then
        echo "rsync......"
        rsync -arlvP --exclude={'.DS_Store','*.tmp'} $HOME/Music/Music/Media.localized/Music/ /Volumes/WD/00.Music
        rsync -arlvP --exclude={'.DS_Store','*.tmp'} $HOME/Pictures/DCIM/ /Volumes/WD/00.相册
        rsync -arlvP --exclude={'.DS_Store','*.tmp'} $HOME/Pictures/Picture/ /Volumes/WD/01.Picture
        rsync -arlvP --exclude={'.DS_Store','*.tmp'} $HOME/code/ /Volumes/WD/code
    fi
}

function daily-clean() {
    echo "go clean..."
    go clean -cache
    go clean -fuzzcache
    go clean -modcache

    pip3 cache purge

    echo "delete......"
    rm -r $HOME/Library/Caches/go-build
    rm -r $HOME/Library/Caches/{JetBrains,gopls}
    rm -r $HOME/Library/Application\ Support/Caches/*
    rm -r $HOME/Library/Application\ Support/apifox/{logs,Cache}

    rm -r $HOME/Library/Logs/JetBrains/*

    echo "docker......"
    docker builder prune -f
    docker image prune -f
}
