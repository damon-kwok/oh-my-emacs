ROOT_DIR_NAME=my-emacs-config
export SHAMAN_ROOT=/home/`whoami`/$ROOT_DIR_NAME
export SHAMAN_BIN=$SHAMAN_ROOT/bin
export LOCAL_BIN=/home/`whoami`/.local/bin
export ROSWELL_BIN=/home/`whoami`/.roswell/bin
export CATKIN_WS_BIN=/home/`whoami`/catkin_ws/bin
export OPAM_BIN=/home/`whoami`/.opam/system/bin
export CARGO_BIN=/home/`whoami`/.cargo/system/bin
export PATH=$SHAMAN_BIN:$CARGO_BIN:$OPAM_BIN:$ROSWELL_BIN:$CATKIN_WS_BIN:$LOCAL_BIN:$PATH

export SHELL_NAME=ps |  grep $$  |  awk '{print $4}'

# User Settings
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

# ROS
case "$SHELL_NAME" in
	"zsh")
		source /opt/ros/kinetic/env.zsh
		source $HOME/catkin_ws/devel/env.zsh
		;;
	"bash")
		source /opt/ros/kinetic/env.bash
		source $HOME/catkin_ws/devel/env.bash
		;;
esac

export PATH=$PATH:$HOME/catkin_ws/bin

# Cyberman
export PATH=$HOME/Cyberman:$PATH

# Nodejs
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Golang
export GOROOT=/usr/lib/go
export GOPATH=$HOME/goprojects
export PATH=$PATH:$GOPATH/bin

# Rust
source $HOME/.cargo/env

# Nim-lang
export PATH=$HOME/.nimble/bin:$PATH

# Elixir
# export PATH=$HOME/dev/elixir-1.5.2/bin:/usr/local/bin:$PATH

# Ocaml: OPAM configuration
case "$SHELL_NAME" in
	"zsh")
		. $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
		;;
	"bash")
		. $HOME/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
		;;
	"csh")
		. $HOME/.opam/opam-init/init.csh > /dev/null 2> /dev/null || true
		;;
esac

################################################################################
function upgrade() {
    sudo apt update && sudo apt dist-upgrade && sudo apt autoremove && rosdep update && bash-it update && upgrade_oh_my_zsh
}

# find-str $2:str $1:file
# example:
# find-str "/opt/ros/kinetic/" ~/.bashrc
# result=$?
# echo $result
function find-str() {
	local STR=$1
	local FILE=$2
	
    grep $STR $FILE >/dev/null
    if [ $? -eq 0 ]; then
		echo "found!"
		return $(( 1 ));
    else
		echo "not found!"
		return $(( 0 ));
    fi
}

function find-str() {
	local str=$1
	local file=$2
	
    grep $str $file >/dev/null
	
    if [ $? -eq 0 ]; then
		echo "found:$str"
		return $(( 1 ));
    else
		echo "not found:$str"
		return $(( 0 ));
    fi
}


# smart-rtags $void
function auto-gen-rtags() {
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
