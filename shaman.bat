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
cd /d %~dp0%
set ROOT=%CD%
set PATH=%ROOT%;%PATH%

set CACHE=%ROOT%\cache
set APP_HOME=%CACHE%\apps
set ZIP_HOME=%CACHE%\apps-zip

set PATH=%CACHE%\bin;%PATH%

if not exist %CACHE% (
   mkdir %CACHE%
)

rem set HOME=%USERPATH%
set HOME=%ROOT%

set PROJECT_BLOG=damon-kwok.github.io

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem emacs
set EMACS_HOME=%APP_HOME%\emacs
set EMACS_BIN=%EMACS_HOME%\bin
set PATH=%EMACS_BIN%;%PATH%
rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem msys2
REM set MSYS_HOME=c:\msys64
REM set MSYS_BIN=%MSYS_HOME%\usr\bin

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
if not exist %APPDATA%\stack\config.yaml ( copy /y %CACHE%\bin\config.yaml %APPDATA%\stack\ )
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

set JAVA_VERSION=131
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
rem set HOME=%ROOT%
rem set ALTERNATE_EDITOR=%EMACS_BIN%\emacsc.exe
rem set EMACS_SERVER_FILE=%HOME%\.emacs.d\server\emacs-server-file
copy /y %ROOT%\emacs-config\init.el %HOME%\.emacs
goto:eof

:open
rem set HOME=%ROOT%
rem set ALTERNATE_EDITOR=%EMACS_BIN%\emacsc.exe
rem set EMACS_SERVER_FILE=%HOME%\.emacs.d\server\emacs-server-file
rem goto:%1
rem start %EMACS_BIN%\runemacs.exe --debug-init %1
"%ROOT%/cache/apps/emacs/bin/emacsclientw.exe" --server-file "%ROOT%/.emacs.d/server/server" --no-wait --alternate-editor="%ROOT%/cache/apps/emacs/bin/runemacs.exe" %1
exit

:reg-open-menu
rem set HOME=%ROOT%
rem set ALTERNATE_EDITOR=%EMACS_BIN%\emacsc.exe
rem set EMACS_SERVER_FILE=%HOME%\.emacs.d\server\emacs-server-file

call:got-admin-auth
rem regedit.exe /S %ROOT%/emacs.reg
rem reg import %ROOT%/emacs.reg
rem REG ADD "HKEY_CLASSES_ROOT\*\shell\Edit with Emacs\command" /ve /t REG_SZ /d "\"%ROOT%\cache\apps\emacs\bin\emacsclientw.exe\" --no-wait --server-file \"%ROOT%\.emacs.d\server\server\" --alternate-editor=\"%ROOT%\cache\apps\emacs\bin\runemacs.exe\" \"%%1\"" /f
REG ADD "HKEY_CLASSES_ROOT\*\shell\Edit with Emacs\command" /ve /t REG_SZ /d "\"%ROOT%\shaman.bat\" \"%%1\"" /f
goto:eof

:emacs
rem set HOME=%ROOT%
rem set ALTERNATE_EDITOR=%EMACS_BIN%\emacsc.exe
rem set EMACS_SERVER_FILE=%HOME%\.emacs.d\server\emacs-server-file
if not exist %HOME%\.emacs (
   copy /y %ROOT%\emacs-config\init.el %HOME%\.emacs
)
cd %HOME%
start %EMACS_BIN%\runemacs.exe --debug-init
rem call %EMACS_BIN%\emacs.exe -Q -l ~/emacs-config/profile-dotemacs.el -f profile-dotemacs ~/emacs-config/init.el
exit

:emacs-nw
rem set HOME=%ROOT%
rem set ALTERNATE_EDITOR=%EMACS_BIN%\emacsc.exe
rem set EMACS_SERVER_FILE=%HOME%\.emacs.d\server\emacs-server-file
if not exist %HOME%\.emacs (
   copy /y %ROOT%\emacs-config\init.el %HOME%\.emacs
)
cd %HOME%
%EMACS_BIN%\emacs.exe -nw --debug-init
goto:eof

:compile-elc
rem set HOME=%ROOT%
rem set ALTERNATE_EDITOR=%EMACS_BIN%\emacsc.exe
rem set EMACS_SERVER_FILE=%HOME%\.emacs.d\server\emacs-server-file

cd %ROOT%\emacs-config\modules
%EMACS_BIN%\emacs.exe -Q -batch -f batch-byte-compile *.el
REM emacs --batch --eval '(byte-recompile-directory "~/.emacs.d")'
REM emacs --batch --eval '(byte-compile-file "your-elisp-file.el")'
REM emacs -Q --batch -f batch-byte-compile *.el foo/*.el
REM %EMACS_BIN%\emacs.exe --batch --eval "(byte-recompile-directory  \"~/emacs-config/modules\" 0)"
REM copy /y %ROOT%\emacs-config\comp.el %HOME%\.emacs
cd %ROOT%
goto:eof

:delete-elc
cd %ROOT%\emacs-config\modules
rm -rf *.elc
cd %ROOT%
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

:pull
echo "do::pull"
git pull
goto:eof

:push
echo "do::push"
rem rm -f .git/index.lock
git reset
git add .
git status
set /p msg=please input commit message:
echo commit: %msg%
git commit -m "%msg%"
git push -u origin master
goto:eof

:push-a
echo "do::push-a"
git reset
git add .
git status
git commit -m "upgrade by "%computername%
git push -u origin master
goto:eof

:zipapp
echo "do::zipapp"
cd %CACHE%
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
pacman -S base-devel zsh wget curl zip unzip git svn coreutils diffutils camke
pacman -S perl rubygems mingw-w64-x86_64-nodejs mingw-w64-x86_64-ocaml mingw-w64-x86_64-zeromq mingw-w64-x86_64-ghostscript

rem install: lien
cd %CACHE%/bin
curl -O https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein.bat
curl -O https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
chmod +x ./lein

rem install: cargo

rem install: elixir && erlang-nox

rem oh-my-zsh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

rem rebar3
cd %ROOT%
wget https://s3.amazonaws.com/rebar3/rebar3 && chmod +x rebar3

goto:eof

:ask-repl
echo please choose your need:
echo    1) clojure
echo    2) haskell
echo    3) elixir
echo    4) erlang

set /p c=please input your choice:
echo loading...
if /i "%c%"=="1" echo abort with "^C | ^D | (exit) | (quit)" && lein repl
if /i "%c%"=="2" echo abort with "^D :quit" && stack repl
if /i "%c%"=="3" echo abort with "^C" && iex
if /i "%c%"=="4" echo abort with "^C | ^G | q()." && erl
if /i "%c%"=="r" call:ask
goto:eof

:ask
echo hello %username%, what's up?
rem echo do::ask
cd %ROOT%
echo    1) push
echo    2) getapp
echo    3) pushapp
echo    4) zipapp
echo    5) unzipapp
echo    e) emacs
echo    n) emacs-nw
echo    i) install toolchain
REM echo    c) complie-elc
echo    l) link init.el
echo    d) delete-elc
echo    s) shell
echo    m) register right open menu
echo    z) REPL
echo    r) return
echo    q) quit

set /p c=please input your choice:
if /i "%c%"=="1" call:push
if /i "%c%"=="2" call:getapp
if /i "%c%"=="3" call:pushapp
if /i "%c%"=="4" call:zipapp
if /i "%c%"=="5" call:unzipapp
if /i "%c%"=="i" call:install-toolchain
if /i "%c%"=="e" goto:emacs
if /i "%c%"=="n" call:emacs-nw
REM if /i "%c%"=="c" call:compile-elc
if /i "%c%"=="l" call:link-init-el
if /i "%c%"=="d" call:delete-elc
if /i "%c%"=="s" call:shell
if /i "%c%"=="m" call:reg-open-menu
if /i "%c%"=="z" call:ask-repl
if /i "%c%"=="r" call:eof
if /i "%c%"=="q" exit
REM echo your input is not invalid:(
call:ask

:main
rem echo do::main
call:ask

:quit
cd %ROOT%
