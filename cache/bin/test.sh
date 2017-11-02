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

find-str "/opt/ros/kinetic/" ~/.bashrc
echo result:$?
