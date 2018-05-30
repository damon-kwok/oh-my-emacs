ROOT_DIR_NAME=my-emacs-config
export SHAMAN_ROOT=/home/`whoami`/$ROOT_DIR_NAME
export SHAMAN_BIN=$SHAMAN_ROOT/bin
export LOCAL_BIN=/home/`whoami`/.local/bin
export ROSWELL_BIN=/home/`whoami`/.roswell/bin
export CATKIN_WS_BIN=/home/`whoami`/catkin_ws/bin
export OPAM_BIN=/home/`whoami`/.opam/system/bin
export CARGO_BIN=/home/`whoami`/.cargo/system/bin
export PATH=$SHAMAN_BIN:$CARGO_BIN:$OPAM_BIN:$ROSWELL_BIN:$CATKIN_WS_BIN:$LOCAL_BIN:$PATH

# User Settings
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

# Golang
export GOROOT=/usr/lib/go
export GOPATH=$HOME/goprojects
export PATH=$PATH:$GOPATH/bin

# Rust
source $HOME/.cargo/env

# ROS
source /opt/ros/kinetic/setup.bash
source ~/catkin_ws/devel/setup.bash
export PATH=$PATH:/home/damon/catkin_ws/bin

# Nim-lang
export PATH=/home/damon/.nimble/bin:$PATH

################################################################################
function upgrade {
    sudo apt update && sudo apt dist-upgrade && sudo apt autoremove && rosdep update
}

# find-str $2:str $1:file
# example:
# find-str "/opt/ros/kinetic/" ~/.bashrc
# result=$?
# echo $result
function find-str {    
    grep $1 $2 >/dev/null
    if [ $? -eq 0 ]; then
	return $(( 1 ));
    else
	return $(( 0 ));
    fi
}

# smart-rtags $void
function auto-gen-rtags {
    DIR=`pwd`
    # echo "check dir:$DIR"

    if [ -f "$DIR/CMakeLists.txt" ]; then
	if [ ! -d "$DIR/rtags_indexes" ]; then
	    echo "$DIR/rtags_indexes is creating..."
	    mkdir -p $DIR/rtags_indexes
	    cd rtags_indexes/
	    cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=1
	    rc -J .
	    cd ..
	else
	    echo "$DIR/rtags_indexes is exist!"
	fi
    else
	cd ..
	if [ ! "/" == "$DIR" ]; then
	    auto-gen-rtags	    
	fi
    fi
}

# check install:rtags irony-server
# function find-camke {
    # echo 111
# }

# function kill-process {
    # echo 222
# }

# function find-file {
    # echo 333
# }

# function dirp {
    # DIR=`pwd`
    # if [ ! "/" == "$DIR" ]; then
	# echo "dir is "`pwd`
    # else
	# echo "dir is root"
    # fi
# }

# dirp

# find-str "devel" ~/.bashrc
# if [ $? -eq 1 ]; then
    # echo "found:"$?
# else
    # echo "not-found:"$?
# fi

# function readp- {
    # read -p "$1(Y/n)" c
    # if [ "$c" == "y" ] || [ "$c" == "Y" ] || [ "$c" == "" ]; then
	# return $(( 1 ));
    # elif [ "$c" == "n" ] || [ "$c" == "N" ]; then
	# return $(( 0 ));
    # else
	# echo "invalid input:$c"
	# readp "$1"
    # fi
# }

