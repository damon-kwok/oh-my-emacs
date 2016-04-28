export ROOT=$(cd `dirname $0`; pwd)
export CACHE=$ROOT/home
export APP_HOME=$CACHE/apps

# $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
# emacs
export EMACS_HOME=$APP_HOME/emacs-bin-w64-25.0.92-O2
# export EMACS_HOME=$APP_HOME/emacs-25-20160331T094545Z-bin-i686-mingw32
export EMACS_BIN=$EMACS_HOME/bin

export HOME=$ROOT/home
export ALTERNATE_EDITOR=$EMACS_BIN/emacsc.exe
export EMACS_SERVER_FILE=$HOME/.emacs.d/server/emacs-server-file

# $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
# msys2
export MSYS_HOME=$APP_HOME/msys32
export MSYS_BIN=$MSYS_HOME/usr/bin

# $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
# omnisharp
export OMNISHARP_HOME=$APP_HOME/omnisharp-server
export OMNISHARP_BIN=$OMNISHARP_HOME/bin

# $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
# protobuf-net
export PROTOBUF_BIN=$APP_HOME/protobuf

export PATH=$MSYS_BIN:$PATH
export PATH=$OMNISHARP_BIN:$PATH
export PATH=$EMACS_BIN:$PATH
export PATH=$ROOT/bin:$PATH

mkdir -p $CACHE

export ZIP_HOME=$APP_HOME-zip

if [ -d $APP_HOME ]; then
   echo apps exist!
else
  echo apps missing!
  if [ -d $ZIP_HOME ]; then
     git fetch
     # 7z x $ZIP_HOME/apps-ttttt.7z.001 -y -aos -o$APP_HOME
	 cat apps-%ddd%.zip.* > ttttt.zip
	 unzip ttttt.zip
  else
     git clone https://github.com/damon-kwok/my-emacs-apps.git $ZIP_HOME
     # 7z x $ZIP_HOME/apps-ttttt.7z.001 -y -aos -o$APP_HOME
	 cat apps-ttttt.zip.* > ttttt.zip
	 unzip ttttt.zip
  fi
fi
