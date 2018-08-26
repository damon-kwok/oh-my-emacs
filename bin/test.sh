#!/usr/bin/env bash

echo "aaa:$@"
function hello() {
    echo "hello,$1!"
}
hello $@
FUNC_NAME="hello"
# eval $FUNC_NAME
eval "hello $?"

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

# haha
# haha 2.12

echo "11111111111"
echo `test "pip"`
if test pip == "" ; then
    echo "no pip"
else
    echo "has pip"
fi


