#!/usr/bin/env bash

function hello() {
    echo "hello,shaman!"
}

FUNC_NAME="hello"
# eval $FUNC_NAME
eval "hello"
# add source
# install or upgrade
