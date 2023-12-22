#!/bin/bash
###
### my-script — does one thing well
###
### Usage:
###   my-script <input> <output>
###
### Options:
###   <input>   Input file to read.
###   <output>  Output file to write. Use '-' for stdout.
###   -h        Show this message.


help() {
    sed -rn 's/^### ?//;T;p' "$0"
}

if [[ $# == 0 ]] || [[ "$1" == "-h" ]]; then
    help
    exit 1
fi


# from: https://samizdat.dev/help-message-for-shell-scripts/
# from: https://gist.github.com/kovetskiy/a4bb510595b3a6b17bfd1bd9ac8bb4a5
