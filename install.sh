#!/usr/bin/env bash

if [ ! -e "$HOME/.oh-my-emacs/.git/index" ]; then
    git clone https://github.com/damon-kwok/oh-my-emacs $HOME/.oh-my-emacs --depth=1
else
    cd $HOME/.oh-my-emacs
    git pull
fi

function link-init-el() {
    tip "link"
    bkdir=~/emacs-config-backup/`date +%Y-%m-%d@%H-%M-%S`
    mkdir -p $bkdir

    if [ -e ~/.emacs ]; then
	mv ~/.emacs $bkdir
    fi

    if [ -e ~/emacs-config ]; then
	mv ~/emacs-config $bkdir
    fi

    tip "link .emacs"
    cp -a $OME_ROOT/emacs-config/init.el ~/.emacs 
    ln -s $OME_ROOT/emacs-config ~/emacs-config 
}
link-init-el
