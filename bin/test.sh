#!/usr/bin/env bash

echo "aaa:$@"
function hello() {
    echo "hello,shaman!"
}

FUNC_NAME="hello"
# eval $FUNC_NAME
eval "hello"
# add source
# install or upgrade

if [ ! -d $HOME/.emacs.d/libs/mu-1.0 ]; then
	echo "no"
	cd $HOME/.emacs.d/libs/
	
	# curl -O https://github.com/djcb/mu/releases/download/v1.0/mu-1.0.tar.xz
	# xz -d ./mu-1.0.tar.xz
	# tar xvf mu-1.0.tar
	cp -f $SHAMAN_ROOT/tool/mu-1.0.tar.xz $HOME/.emacs.d/libs/ 
	tar xpvf mu-1.0.tar.xz -C .
else
	echo "yes"
fi
