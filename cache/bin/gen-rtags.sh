#!/bin/bash

source /opt/ros/kinetic/setup.bash
source ~/my-emacs-config//cache/bin/setup.sh
echo "1:$1"
echo "2:$PATH"
echo "3:`which rc`"

auto-gen-rtags
