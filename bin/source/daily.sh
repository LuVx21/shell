#!/bin/bash

function daily-fn {
    echo "brew....."
    brew update && brew upgrade && brew cu -af

    echo "brew download clean"
    brew cleanup
    rm -r $HOME/Library/Caches/Homebrew/downloads/*

    rm -r $HOME/Library/Application\ Support/Caches/*
}