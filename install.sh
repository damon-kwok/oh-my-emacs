#!/usr/bin/env bash

if [ ! -e "$HOME/.shaman/.git/index" ]; then
	git clone https://github.com/damon-kwok/my-emacs-config $HOME/.shaman
else
	cd $HOME/.shaman
	git pull
fi

chmod +x $HOME/.shaman/bin/*

$HOME/.shaman/bin/shaman $@
