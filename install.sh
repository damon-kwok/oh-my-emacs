#!/usr/bin/env bash

if [ ! -e "$HOME/.oh-my-emacs/.git/index" ]; then
	git clone https://github.com/damon-kwok/oh-my-emacs $HOME/.oh-my-emacs
else
	cd $HOME/.oh-my-emacs
	git pull
fi

chmod +x $HOME/.oh-my-emacs/bin/*

grep ".oh-my-emacs/bin/env" ~/.bashrc >/dev/null
if [ $? -eq 0 ]; then
	echo "source $HOME/.oh-my-emacs/bin/env" >> ~/.bashrc
fi

source ~/.bashrc
