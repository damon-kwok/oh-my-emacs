#!/usr/bin/env bash

if [ ! -e "$HOME/.oh-my-emacs/.git/index" ]; then
    git clone https://github.com/damon-kwok/oh-my-emacs $HOME/.oh-my-emacs --depth=1
else
    cd $HOME/.oh-my-emacs
    git pull
fi
