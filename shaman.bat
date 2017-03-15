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
rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem emacs
set EMACS_HOME=%APP_HOME%\emacs
set EMACS_BIN=%EMACS_HOME%\bin
set PATH=%EMACS_BIN%;%PATH%

set HOME=%ROOT%
set ALTERNATE_EDITOR=%EMACS_BIN%\emacsc.exe
set EMACS_SERVER_FILE=%HOME%\.emacs.d\server\emacs-server-file
rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem msys2
REM set MSYS_HOME=c:\msys64
REM set MSYS_BIN=%MSYS_HOME%\usr\bin

set MSYS32_BIN=c:\msys32\usr\bin;d:\msys32\usr\bin;e:\msys32\usr\bin;f:\msys32\usr\bin;
set MSYS64_BIN=c:\msys64\usr\bin;d:\msys64\usr\bin;e:\msys64\usr\bin;f:\msys64\usr\bin;
set MINGW32_BIN=c:\msys32\mingw32\bin;d:\msys32\mingw32\bin;e:\msys32\mingw32\bin;f:\msys32\mingw32\bin;
set MINGW64_BIN=c:\msys64\mingw64\bin;d:\msys64\mingw64\bin;e:\msys64\mingw64\bin;f:\msys64\mingw64\bin;
set PATH=%MSYS32_BIN%;%MSYS64_BIN%;%MINGW32_BIN%;%MINGW64_BIN%;%PATH%
rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem MsBuild
rem set MSBUILD_HOME="C:\Program Files (x86)\MSBuild\14.0\Bin"
rem set MSBUILD_BIN=%MSBUILD_HOME%\Bin

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem ocaml
set OCAML_HOME=C:\OCaml
set OCAML_BIN=%OCAML_HOME%\bin
set OCAMLLIB=%OCAML_HOME%\lib
set PATH=%OCAML_BIN%;%PATH%

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
rem bash shaman
rem goto:quit

if "%1"=="" (
goto:main
)else (
goto:%1
)

:env
goto:quit

:link-init-el
copy /y %ROOT%\emacs-config\init.el %HOME%\.emacs
goto:eof

:emacs
if not exist %HOME%\.emacs (
   copy /y %ROOT%\emacs-config\init.el %HOME%\.emacs
)
cd %HOME%
start %EMACS_BIN%\runemacs.exe --debug-init
rem call %EMACS_BIN%\emacs.exe -Q -l ~/emacs-config/profile-dotemacs.el -f profile-dotemacs ~/emacs-config/init.el
exit

:emacs-nw
if not exist %HOME%\.emacs (
   copy /y %ROOT%\emacs-config\init.el %HOME%\.emacs
)
cd %HOME%
%EMACS_BIN%\emacs.exe -nw --debug-init
goto:eof

:compile-elc
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
goto:eof

:sleep
echo "sleep %arg1%s"
ping -n %arg1% 127.0.0.1>nul
goto:eof

:download-lein
cd %CACHE%/bin
curl -O https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein.bat
rem curl -O https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
chmod +x ./lein
goto:eof

:fetch
echo "do::fetch"
git fetch
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
git commit -m "update module"
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
		git fetch
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
pacman -Syu
pacman -S curl zip unzip git svn perl
REM pacman -S base-devel curl zip unzip git svn cmake mingw-w64-x86_64-gcc
goto:eof

:ask
cd %ROOT%
echo do::ask
echo    1) push
echo    2) getapp
echo    3) pushapp
echo    4) zipapp
echo    5) unzipapp
echo    6) download-leiningen
echo    e) emacs
echo    n) emacs-nw
echo    i) install-chain
REM echo    c) complie-elc
echo    l) link init.el
echo    d) delete-elc
echo    s) shell
echo    r) return
echo    q) quit

set /p c=please input your choice:
if /i "%c%"=="1" call:push
if /i "%c%"=="2" call:getapp
if /i "%c%"=="3" call:pushapp
if /i "%c%"=="4" call:zipapp
if /i "%c%"=="5" call:unzipapp
if /i "%c%"=="6" call:download-lein
if /i "%c%"=="i" call:install-toolchain
if /i "%c%"=="e" goto:emacs
if /i "%c%"=="n" call:emacs-nw
REM if /i "%c%"=="c" call:compile-elc
if /i "%c%"=="l" call:link-init-el
if /i "%c%"=="d" call:delete-elc
if /i "%c%"=="s" call:shell
if /i "%c%"=="r" call:eof
if /i "%c%"=="q" exit
REM echo your input is not invalid:(
call:ask

:main
echo do::main
call:ask

:quit
cd %ROOT%

