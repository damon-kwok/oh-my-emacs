#!/usr/bin/env bash

echo "aaa:$@"
function hello() {
    echo "hello,emacs!"
}

FUNC_NAME="hello"
# eval $FUNC_NAME
eval "hello"

##################################
function haha() {
    # local bransh=$1 && "-b $1" || ""
    if [ "$1" == "" ]; then
        local bran=""
    else
        local bran="-b $1"
    fi
    echo "result:$bran"
}

haha
haha 2.12


