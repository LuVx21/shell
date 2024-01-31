#!/bin/bash

function daily-fn {
    echo "brew....."
    brew update && brew upgrade && brew cu -af

    echo "brew download clean"
    brew cleanup
    rm -fr $HOME/Library/Caches/Homebrew/downloads/*
}