@echo off
REM medusa.bat --- This is where you apply your OCD.
REM
REM Copyright (C) 2015-2016 damon-kwok
REM
REM Author: gww <damon-kwok@outlook.com>
REM Date: 2016-04-29
REM
REM This program is free software; you can redistribute it and/or modify
REM it under the terms of the GNU General Public License as published by
REM the Free Software Foundation, either version 3 of the License, or
REM (at your option) any later version.
REM
REM This program is distributed in the hope that it will be useful,
REM but WITHOUT ANY WARRANTY; without even the implied warranty of
REM MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
REM GNU General Public License for more details.
REM
REM You should have received a copy of the GNU General Public License
REM along with this program.  If not, see <http:REMwww.gnu.org/licenses/>.
REM					 
REM Code:
REM
export LANG="en_US.UTF-8"
cd /d %~dp0%
set SHAMAN_ROOT=%CD%\..
set SHAMAN_BIN=%SHAMAN_ROOT%\bin
rem set LOCAL_BIN=/home/`whoami`/.local/bin
rem set PATH=%SHAMAN_BIN%;%LOCAL_BIN%;%PATH%
set PATH=%SHAMAN_BIN%;%PATH%

set DIR_CACHE=%SHAMAN_ROOT%\cache
set APP_HOME=%DIR_CACHE%\apps
set ZIP_HOME=%DIR_CACHE%\apps-zip

set PATH=%DIR_CACHE%\bin;%PATH%

rem if not exist %DIR_CACHE% (
   rem mkdir %DIR_CACHE%
rem )

set DIR_BLOG=%SHAMAN_ROOT%\blog
rem set DIR_DOC=%SHAMAN_ROOT%\docs
rem set DIR_PROJECT=%SHAMAN_ROOT%\projects
set DIR_WORKSPACE=%SHAMAN_ROOT%\workspace
set DIR_DEV=%SHAMAN_ROOT%\dev
set DIR_LLVM_WHERE=%SHAMAN_ROOT%\dev
set DIR_LLVM=%SHAMAN_ROOT%\dev\llvm

rem set HOME=%USERPATH%
set HOME=%SHAMAN_ROOT%

set PROJECT_BLOG=damon-kwok.github.io

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem emacs
set EMACS_HOME=%APP_HOME%\emacs
set EMACS_BIN=%EMACS_HOME%\bin
set PATH=%EMACS_BIN%;%PATH%
rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem msys2
set MSYS32_HOME=c:\msys32;d:\msys32;e:\msys32;f:\msys32;g:\msys32;
set MSYS64_HOME=c:\msys64;d:\msys64;e:\msys64;f:\msys64;g:\msys64;
set MSYS32_BIN=c:\msys32\usr\bin;d:\msys32\usr\bin;e:\msys32\usr\bin;f:\msys32\usr\bin;g:\msys32\usr\bin;
set MSYS64_BIN=c:\msys64\usr\bin;d:\msys64\usr\bin;e:\msys64\usr\bin;f:\msys64\usr\bin;g:\msys32\usr\bin;
set MINGW32_BIN=c:\msys32\mingw32\bin;d:\msys32\mingw32\bin;e:\msys32\mingw32\bin;f:\msys32\mingw32\bin;g:\msys32\mingw32\bin;
set MINGW64_BIN=c:\msys64\mingw64\bin;d:\msys64\mingw64\bin;e:\msys64\mingw64\bin;f:\msys64\mingw64\bin;g:\msys64\mingw64\bin;
set PATH=%MSYS32_HOME%;%MSYS64_HOME%;%MSYS32_BIN%;%MSYS64_BIN%;%MINGW32_BIN%;%MINGW64_BIN%;%PATH%

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem TexLive
set TEXLIVE_BIN=C:\texlive\2017\bin\win32;D:\texlive\2017\bin\win32;E:\texlive\2017\bin\win32;
set PATH=%TEXLIVE_BIN%;%PATH%

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem MsBuild
rem set MSBUILD_HOME="C:\Program Files (x86)\MSBuild\14.0\Bin"
rem set MSBUILD_BIN=%MSBUILD_HOME%\Bin

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem ocaml
set OCAML_HOME=%APP_HOME%\opam64
set OCAML_BIN=%OCAML_HOME%\bin
set OCAMLLIB=%OCAML_HOME%\lib
set PATH=%OCAML_BIN%;%PATH%

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem Haskell-Stack
if not exist %APPDATA%\stack ( mkdir %APPDATA%\stack )
if not exist %APPDATA%\stack\config.yaml ( copy /y %DIR_CACHE%\bin\config.yaml %APPDATA%\stack\ )
set STACK_HOME=%APP_HOME%\stack
set STACK_BIN=%STACK_HOME%\bin
set PATH=%STACK_BIN%;%PATH%

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem omnisharp
set OMNISHARP_HOME=%APP_HOME%\omnisharp-server
set OMNISHARP_BIN=%OMNISHARP_HOME%\bin
set PATH=%OMNISHARP_BIN%;%PATH%

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem cmake
set CMAKE_HOME=%APP_HOME%\cmake
set CMAKE_BIN=%CMAKE_HOME%\bin
set PATH=%CMAKE_BIN%;%PATH%

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem protobuf-net
set PROTOBUF_BIN=%APP_HOME%\protobuf
set PATH=%PROTOBUF_BIN%;%PATH%

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem irony-server
set IRONY_BIN=%APP_HOME%\irony-server\bin
set PATH=%APP_HOME%\gcc-6-win64\bin;c:\LLVM\bin;%IRONY_BIN%;%PATH%

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem set LLVM_HOME=%APP_HOME%\LLVM
rem set LLVM_BIN=%LLVM_HOME%\bin

rem set CLANG_HOME=%APP_HOME%\Clang\bin
rem set CLANG_BIN=%CLANG_HOME%\bin
rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rem set PATH=%MSBUILD_BIN%;%PATH%
rem set PATH=%LLVM_BIN%;%CLANG_BIN%;%PATH%
rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set JAVA_VERSION=144
set JAVA_HOME2="C:\Program Files"\Java\jdk1.8.0_%VERSION%
set JAVA_HOME=C:\PROGRA~1\Java\jdk1.8.0_%VERSION%
set JAVA_BIN=%JAVA_HOME%\bin
rem set LEIN_JAVA_CMD=%JAVA_BIN%\java.exe
set CLASSPATH=.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar;
set PATH=%JAVA_BIN%;%LEIN_JAVA_CMD%;%PATH%
rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rem bash shaman
rem goto:quit
goto:init

:init
if /i "%1"=="" goto:main
if /i "%1"=="reg" goto:reg-open-menu
if /i "%1"=="emacs" goto:emacs
if /i "%1"=="emacs-nw" goto:emacs-nw
goto:open

REM%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:env
goto:quit

REM%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:got-admin-auth
REM --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
echo Requesting administrative privileges...
goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "reg", "", "runas", 1 >> "%temp%\getadmin.vbs"

"%temp%\getadmin.vbs"
exit

:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
pushd "%CD%"
CD /D "%~dp0" 
goto:eof

REM%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:link-init-el
rem set HOME=%SHAMAN_ROOT%
rem set ALTERNATE_EDITOR=%EMACS_BIN%\emacsc.exe
rem set EMACS_SERVER_FILE=%HOME%\.emacs.d\server\emacs-server-file
copy /y %SHAMAN_ROOT%\emacs-config\init.el %HOME%\.emacs
goto:eof

:open
rem set HOME=%SHAMAN_ROOT%
rem set ALTERNATE_EDITOR=%EMACS_BIN%\emacsc.exe
rem set EMACS_SERVER_FILE=%HOME%\.emacs.d\server\emacs-server-file
rem goto:%1
rem start %EMACS_BIN%\runemacs.exe --debug-init %1
"%SHAMAN_ROOT%\cache\apps\emacs\bin\emacsclientw.exe" --server-file "%SHAMAN_ROOT%\.emacs.d\server\server" --no-wait --alternate-editor="%SHAMAN_ROOT%\cache\apps\emacs\bin\runemacs.exe" %1
exit

:reg-open-menu
rem set HOME=%SHAMAN_ROOT%
rem set ALTERNATE_EDITOR=%EMACS_BIN%\emacsc.exe
rem set EMACS_SERVER_FILE=%HOME%\.emacs.d\server\emacs-server-file

call:got-admin-auth
rem regedit.exe /S %SHAMAN_ROOT%\emacs.reg
rem reg import %SHAMAN_ROOT%\emacs.reg
rem REG ADD "HKEY_CLASSES_ROOT\*\shell\Edit with Emacs\command" /ve /t REG_SZ /d "\"%SHAMAN_ROOT%\cache\apps\emacs\bin\emacsclientw.exe\" --no-wait --server-file \"%SHAMAN_ROOT%\.emacs.d\server\server\" --alternate-editor=\"%SHAMAN_ROOT%\cache\apps\emacs\bin\runemacs.exe\" \"%%1\"" /f
REG ADD "HKEY_CLASSES_ROOT\*\shell\Edit with Emacs\command" /ve /t REG_SZ /d "\"%SHAMAN_ROOT%\shaman.bat\" \"%%1\"" /f
goto:eof

:emacs
rem set HOME=%SHAMAN_ROOT%
rem set ALTERNATE_EDITOR=%EMACS_BIN%\emacsc.exe
rem set EMACS_SERVER_FILE=%HOME%\.emacs.d\server\emacs-server-file
if not exist %HOME%\.emacs (
   copy /y %SHAMAN_ROOT%\emacs-config\init.el %HOME%\.emacs
)
cd %HOME%
start %EMACS_BIN%\runemacs.exe --debug-init
rem call %EMACS_BIN%\emacs.exe -Q -l ~/emacs-config/profile-dotemacs.el -f profile-dotemacs ~/emacs-config/init.el
exit

:emacs-nw
rem set HOME=%SHAMAN_ROOT%
rem set ALTERNATE_EDITOR=%EMACS_BIN%\emacsc.exe
rem set EMACS_SERVER_FILE=%HOME%\.emacs.d\server\emacs-server-file
if not exist %HOME%\.emacs (
   copy /y %SHAMAN_ROOT%\emacs-config\init.el %HOME%\.emacs
)
cd %HOME%
%EMACS_BIN%\emacs.exe -nw --debug-init
goto:eof

:compile-elc
rem set HOME=%SHAMAN_ROOT%
rem set ALTERNATE_EDITOR=%EMACS_BIN%\emacsc.exe
rem set EMACS_SERVER_FILE=%HOME%\.emacs.d\server\emacs-server-file

cd %SHAMAN_ROOT%\emacs-config\modules
%EMACS_BIN%\emacs.exe -Q -batch -f batch-byte-compile *.el
REM emacs --batch --eval '(byte-recompile-directory "~/.emacs.d")'
REM emacs --batch --eval '(byte-compile-file "your-elisp-file.el")'
REM emacs -Q --batch -f batch-byte-compile *.el foo/*.el
REM %EMACS_BIN%\emacs.exe --batch --eval "(byte-recompile-directory  \"~/emacs-config/modules\" 0)"
REM copy /y %SHAMAN_ROOT%\emacs-config\comp.el %HOME%\.emacs
cd %SHAMAN_ROOT%
goto:eof

:delete-elc
cd %SHAMAN_ROOT%\emacs-config\modules
rm -rf *.elc
cd %SHAMAN_ROOT%
goto:eof

:unity
set UNITY_HOME="C:\Program Files\Unity"
set UNITY_BIN=%UNITY_HOME%\Editor

REM ::code by LZ-MyST QQ:8450919 BLOG:http://hi.baidu.com/lzmyst http://www.clxp.net.cn
if "%1" neq "1" (
>"%temp%\tmp.vbs" echo set WshShell = WScript.CreateObject^(^"WScript.Shell^"^)
>>"%temp%\tmp.vbs" echo WshShell.Run chr^(34^) ^& %0 ^& chr^(34^) ^& ^" 1^",0
start /d "%temp%" tmp.vbs
exit
) 
%UNITY_BIN%\Unity.exe
goto:eof

:shell
bash
rem start msys2.exe
rem start mintty
rem msys2_shell.cmd
goto:eof

:sleep
echo "sleep %arg1%s"
ping -n %arg1% 127.0.0.1>nul
goto:eof

:svn-remove-lose
svn status grep "^!" awk `{print $2}` xargs svn rm
goto:eof

:svn-add-new
svn status grep "^\?" awk `{print $2}` xargs svn add
goto:eof

:svn-commit
svn-remove-lose
svn-add-new
svn status
rem readp "auto commit?"
rem if [ $? -eq 1 ]; then
rem     svn commit -m `date +%Y-%m-%d@%H-%M-%S`
rem else
rem     read -p "please enter commit message:" msg
rem     svn commit -m "$msg"
rem fi
set msg=%date:~0,4%-%date:~5,2%-%date:~8,2%@%time:~0,2%-%time:~3,2%-%time:~6,2%
svn commit -m "%msg%"
goto:eof

:pull
echo "do::pull"
cd %SHAMAN_ROOT%
git reset
git pull
goto:eof

:pull-blog
echo "do::pull-blog"
cd %SHAMAN_ROOT%
git reset
git pull

echo blog
if not exist %DIR_BLOG% (
   cd %SHAMAN_ROOT%
   git clone https://github.com/damon-kwok/damon-kwok.github.io.git %DIR_BLOG%
) else (
  cd %DIR_BLOG%
  git pull
)

echo workspace
if not exist %DIR_WORKSPACE% (
   cd %SHAMAN_ROOT%
   svn co svn://www.svn999.com/guowangwei.workspace workspace
) else (
  cd %DIR_WORKSPACE%
  svn cleanup .
  svn up
)

cd %SHAMAN_ROOT%
goto:eof

:push
echo "do::push"
cd %SHAMAN_ROOT%
git reset
git pull
git add .
git status
set /p msg=please input commit message:
git commit -m "%msg%"
git push -u origin master
goto:eof

:push-a
echo "do::push-a"
cd %SHAMAN_ROOT%
git reset
git pull
git add .
git status
rem git commit -m "upgrade by "%computername%
set msg=%date:~0,4%-%date:~5,2%-%date:~8,2%@%time:~0,2%-%time:~3,2%-%time:~6,2%
git commit -m "%msg%"
git push -u origin master
goto:eof

:push-blog
echo "do::push-blog"
cd %SHAMAN_ROOT%/blog
git reset
git pull
git add .
git status
rem set /p msg=please input commit message:
set msg=%date:~0,4%-%date:~5,2%-%date:~8,2%@%time:~0,2%-%time:~3,2%-%time:~6,2%
rem echo commit:%msg%
git commit -m "%msg%"
git push -u origin master
goto:eof

:zipapp
echo "do::zipapp"
cd %DIR_CACHE%
zip -r apps.zip apps
move apps.zip %ZIP_HOME%/apps.zip
cd %ZIP_HOME%
rm -rf *.zip.*
split -d -b 3m apps.zip apps.zip.
ping -n 1 127.0.0.1>nul
rm -rf apps.zip
goto:eof

:unzipapp
echo "do::unzipapp"
cd %ZIP_HOME%
dir
cat *.zip.* > apps.zip
unzip apps.zip
ping -n 1 127.0.0.1>nul
rm -rf apps.zip
move apps ../
goto:eof

:pushapp
echo "do::pushapp"
cd %ZIP_HOME%
rem rm -f apps.zip
call:zipapp
call:push
goto:eof

:getapp
echo "do::getapp"
if not exist %APP_HOME% (
  
  if exist %ZIP_HOME% (
		echo apps-zip ok!
		cd $ZIP_HOME
		git pull
		call:unzipapp
    )
	else (
		echo apps-zip missing!
		cd $ZIP_HOME/../
		git clone https://github.com/damon-kwok/my-emacs-apps.git %ZIP_HOME%
		call:unzipapp
  )
  move apps ../
)
goto:eof

:test
echo %1%
echo %2%
goto:eof

:install-toolchain
pacman -Syyu
pacman -S base-devel coreutils diffutils zsh wget curl zip unzip git subversion camke mingw-w64-x86_64-ag
pacman -S python2-pip perl rubygems mingw-w64-x86_64-gcc mingw-w64-x86_64-nodejs
pacman -S mingw-w64-x86_64-ocaml ttf-bitstream-vera #mingw-w64-x86_64-zeromq mingw-w64-x86_64-ghostscript

rem install: lien
cd %DIR_CACHE%/bin
curl -O https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein.bat
curl -O https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
chmod +x ./lein

rem install: cargo

rem install: elixir && erlang-nox

rem rebar3
rem cd %DIR_CACHE%/bin
rem wget https://s3.amazonaws.com/rebar3/rebar3 && chmod +x rebar3

rem oh-my-zsh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

rem pip
pip install ipython jupyter rope jedi flake8 importmagic autopep8 yapf

cd %SHAMAN_ROOT%
goto:eof

:ask-blog
echo please enter your choice:
echo    1) pull-blog
echo    2) push-blog
echo    3) commit-workspace
echo    s) shell
echo --------------------------
echo    r) return

set /p c=please enter your choice:
echo loading...
if /i "%c%"=="1" call:pull-blog
if /i "%c%"=="2" call:push-blog
if /i "%c%"=="3" (
   cd %DIR_WORKSPACE%
   call:svn-commit
)
if /i "%c%"=="s" zsh
if /i "%c%"=="r" call:ask-menu

call:ask-menu
goto:eof

:ask-repl
echo please enter your choice:
echo    1) clojure
echo    2) haskell
echo    3) elixir
echo    4) erlang
echo --------------------------
echo    r) return

set /p c=please enter your choice:
echo loading...
if /i "%c%"=="1" echo abort with "^C | ^D | (exit) | (quit)" && lein repl
if /i "%c%"=="2" echo abort with "^D :quit" && stack repl
if /i "%c%"=="3" echo abort with "^C" && iex
if /i "%c%"=="4" echo abort with "^C | ^G | q()." && erl
if /i "%c%"=="r" call:ask-menu
goto:eof

:ask-menu
echo ==============================
echo hello %username%, what's up?
rem echo do::ask-menu
cd %SHAMAN_ROOT%
rem echo    0) ask-blog
echo    1) pull
echo    2) push
rem echo    2) getapp
rem echo    3) pushapp
rem echo    4) zipapp
rem echo    5) unzipapp
echo    e) emacs
echo    n) emacs-nw
echo    i) install toolchain
REM echo    c) complie-elc
echo    l) link init.el
echo    d) delete-elc
echo --------------------------
echo    m) register menu
echo    z) REPL
echo    s) shell
echo    r) return
echo    q) quit

set /p c=please enter your choice:
if /i "%c%"=="0" call:ask-blog
if /i "%c%"=="1" call:pull
if /i "%c%"=="2" call:push
if /i "%c%"=="3" call:push-a
rem if /i "%c%"=="2" call:getapp
rem if /i "%c%"=="3" call:pushapp
rem if /i "%c%"=="4" call:zipapp
rem if /i "%c%"=="5" call:unzipapp
if /i "%c%"=="i" call:install-toolchain
if /i "%c%"=="e" goto:emacs
if /i "%c%"=="n" call:emacs-nw
REM if /i "%c%"=="c" call:compile-elc
if /i "%c%"=="l" call:link-init-el
if /i "%c%"=="d" call:delete-elc

if /i "%c%"=="m" call:reg-open-menu
if /i "%c%"=="z" call:ask-repl
if /i "%c%"=="s" call:shell
if /i "%c%"=="r" call:eof
if /i "%c%"=="q" exit
echo your input is invalid
call:ask-menu

:main
rem echo do::main
call:ask-menu

:quit
cd %SHAMAN_ROOT%

