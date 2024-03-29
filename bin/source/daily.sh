#!/bin/bash

function daily-fn {
    echo "copy....."
    cp $HOME/Library/Application\ Support/Microsoft\ Edge\ Dev/Default/Cookies $HOME/data/sqlite

    echo "brew....."
    brew update && brew upgrade && brew cu -af

    echo "brew clean"
    brew cleanup && brew autoremove

    echo "go clean..."
    go clean -cache
    go clean -fuzzcache

    echo "delete......"
    rm -r $HOME/Library/Application\ Support/Caches/*
    rm -r $HOME/Library/Application\ Support/apifox/{logs,Cache}

    rm -r $HOME/Library/Caches/Homebrew/downloads/*
    # rm -r $HOME/Library/Caches/JetBrains/*

    rm -r $HOME/Library/Logs/JetBrains/*

    # rm $HOME/Library/Application\ Support/Beyond\ Compare/registry.dat

    omz update &
}
