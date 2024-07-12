#!/bin/bash

function daily-fn {
    echo "copy....."
    cp $HOME/Library/Application\ Support/Microsoft\ Edge\ Dev/Default/Cookies $HOME/data/sqlite

    echo "delete......"
    rm $HOME/Library/Application\ Support/Beyond\ Compare*/registry.dat
    rm ~/docker/freshrss/data/cache/*.spc

    echo "brew....."
    brew update && brew upgrade && brew cu -af

    echo "brew clean"
    brew cleanup && brew autoremove
    rm -r $HOME/Library/Caches/Homebrew/downloads/*

    omz update &
}

function daily-clean() {
    echo "go clean..."
    go clean -cache
    go clean -fuzzcache

    echo "delete......"
    rm -r $HOME/Library/Application\ Support/Caches/*
    rm -r $HOME/Library/Application\ Support/apifox/{logs,Cache}

    # rm -r $HOME/Library/Caches/JetBrains/*

    rm -r $HOME/Library/Logs/JetBrains/*

    echo "docker......"
    docker builder prune
    docker image prune
}
