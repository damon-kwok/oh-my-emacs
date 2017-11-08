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
	return $true #$(( $true ));
    else
	echo "Not found!"
	return $false #$(( $false ));
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
	if [ ! "/"=`pwd` ]; then
	    auto-gen-rtags	    
	fi
    fi
}

# check install:rtags irony-server
function find-camke {
    
}

function kill-process {
    
}

function find-file {
    
}

function env-dir {
    if [ ! "/"=`pwd` ]; then
	echo "dir:/"
    else
	echo "dir:"`pwd`
    fi
}

find-str "devel0" ~/.bashrc
if [ $? ]; then
    echo "haha:"$?
else
    echo "hoho:"$?
fi
