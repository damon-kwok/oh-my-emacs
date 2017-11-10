#!/bin/bash

# find-str $2:str $1:file
# example:
# find-str "/opt/ros/kinetic/" ~/.bashrc
# result=$?
# echo $result
function find-str {    
    grep $1 $2 >/dev/null
    if [ $? -eq 0 ]; then
	echo "Found!"
	return $(( 1 ));
    else
	echo "Not found!"
	return $(( 0 ));
    fi
}

# smart-rtags $void
function auto-gen-rtags {
    dir=`pwd`
    echo this dir:$dir

    # check rdm launche status
    
    if [ -e 'CMakeLists.txt' ]; then
	if [ ! -d 'ratgs-indexes' ]; then
	    mkdir -p rtags-indexes
	    cd rtags-indexes/
	    cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=1
	    rc -J .
	    cd ..
	fi
    else
	cd ..
	if [ ! "/" == `pwd` ]; then
	    auto-gen-rtags	    
	fi
    fi
}

# check install:rtags irony-server
function find-camke {
    echo 111
}

function kill-process {
    echo 222
}

function find-file {
    echo 333
}

function dirp {
    dir=`pwd`
    if [ ! "/" == "$dir" ]; then
	echo "dir is "`pwd`
    else
	echo "dir is root"
    fi
}

dirp

# find-str "devel" ~/.bashrc
# if [ $? -eq 1 ]; then
    # echo "found:"$?
# else
    # echo "not-found:"$?
# fi

function readp {
    read -p "$1(Y/n)" c
    echo "your input:$c"
    if [ "$c" == "y" ] || [ "$c" == "Y" ] || [ "$c" == "" ]; then
	echo yes!!!
    elif [ "$c" == "n" ] || [ "$c" == "N" ]; then
	 echo no!!!!
    else
	readp $1
    fi
}
