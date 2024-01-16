#!/bin/bash

function daily-fn {
    echo "brew....."
    brew update && brew upgrade && brew cu -af
}