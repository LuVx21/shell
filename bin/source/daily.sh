#!/bin/bash

function daily-fn {
    echo "brew....."
    brew update && brew upgrade && brew cu -af

    echo "brew download clean"
    brew cleanup

    echo "go clean..."
    go clean -cache
    go clean -fuzzcache

    echo "delete......"
    rm -r $HOME/Library/Application\ Support/Caches/*

    rm -r $HOME/Library/Caches/Homebrew/downloads/*
    rm -r $HOME/Library/Caches/JetBrains/*

    rm -r $HOME/Library/Logs/JetBrains/*

    rm $HOME/Library/Application\ Support/Beyond\ Compare/registry.dat

    omz update
}
