#!/bin/bash

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

function kill-process {
    
}

function find-file {
    
}

function smart-rtags {
    dir=`pwd`
    echo this dir:$dir

    # check rdm launche status
    
    if [ -e 'CMakeLists.txt' ]; then
	mkdir -p rtags-cache
	cd rtags-cache/
	cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=1
	rc -J .
	cd ..
    else
	cd ..
	smart-rtags
    fi
}

# check install:rtags irony-server

function find-camke {
    
}

find-str "/opt/ros/kinetic/" ~/.bashrc
echo result:$?
