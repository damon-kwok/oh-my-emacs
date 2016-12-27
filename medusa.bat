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
set PATH=%ROOT%\bin;%PATH%

set CACHE=%ROOT%\home
set APP_HOME=%CACHE%\apps
set ZIP_HOME=%CACHE%\apps-zip

if not exist %CACHE% (
   mkdir %CACHE%
)
rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem emacs
set EMACS_HOME=%APP_HOME%\emacs
rem set EMACS_HOME=%APP_HOME%\emacs-25-20160331T094545Z-bin-i686-mingw32
set EMACS_BIN=%EMACS_HOME%\bin
set PATH=%EMACS_BIN%;%PATH%

set HOME=%ROOT%\home
set ALTERNATE_EDITOR=%EMACS_BIN%\emacsc.exe
set EMACS_SERVER_FILE=%HOME%\.emacs.d\server\emacs-server-file
rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem msys2
REM set MSYS_HOME=%APP_HOME%\msys64
REM set MSYS_BIN=%MSYS_HOME%\usr\bin

set MSYS_HOME=d:\msys64
set MSYS_BIN=%MSYS_HOME%\usr\bin

REM set MSYS_HOME2=c:\msys32
REM set MSYS_BIN2=%MSYS_HOME2%\usr\bin

REM set MSYS_HOME3=d:\msys32
REM set MSYS_BIN3=%MSYS_HOME3%\usr\bin

set PATH=%PATH%;%MSYS_BIN%;%MSYS_BIN2%;%MSYS_BIN3%
rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem MsBuild
rem set MSBUILD_HOME="C:\Program Files (x86)\MSBuild\14.0\Bin"
rem set MSBUILD_BIN=%MSBUILD_HOME%\Bin

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem omnisharp
set OMNISHARP_HOME=%APP_HOME%\omnisharp-server
set OMNISHARP_BIN=%OMNISHARP_HOME%\bin
set PATH=%OMNISHARP_BIN%;%PATH%

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem protobuf-net
set PROTOBUF_BIN=%APP_HOME%\protobuf
set PATH=%PROTOBUF_BIN%;%PATH%

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem irony-server
set IRONY_BIN=%APP_HOME%\irony-server\bin
set PATH=%IRONY_BIN%;%PATH%

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem set LLVM_HOME=%APP_HOME%\LLVM
rem set LLVM_BIN=%LLVM_HOME%\bin

rem set CLANG_HOME=%APP_HOME%\Clang\bin
rem set CLANG_BIN=%CLANG_HOME%\bin
rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rem set PATH=%MSBUILD_BIN%;%PATH%
rem set PATH=%LLVM_BIN%;%CLANG_BIN%;%PATH%
rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

goto:main

if %1==env (
	goto:quit
)

if %1==main (
	goto:main
)

:sleep
ping -n %arg1% 127.0.0.1>nul
goto:eof

:fetch
echo do::fetch
git fetch
goto:eof

:push
echo do::push
rem rm -f .git/index.lock
git reset
git add *
git status
set /p msg=please input commit message:
echo commit: %msg%
git commit -m "%msg%"
git push -u origin master
goto:eof

:push-a
echo do::push-a
git reset
git add *
git status
git commit -m "update module"
git push -u origin master
goto:eof

:zipapp
echo do::zipapp
cd %ROOT%/home
zip -r apps.zip apps
move apps.zip %ZIP_HOME%/apps.zip
cd %ZIP_HOME%
rm -rf *.zip.*
split -d -b 3m apps.zip apps.zip.
ping -n 1 127.0.0.1>nul
rm -rf apps.zip
goto:eof

:unzipapp
echo do::unzipapp
cd %ZIP_HOME%
dir
cat *.zip.* > apps.zip
unzip apps.zip
ping -n 1 127.0.0.1>nul
rm -rf apps.zip
move apps ../
goto:eof

:pushapp
echo do::pushapp
cd $ZIP_HOME
rem rm -f apps.zip
call:zipapp
call:push
goto:eof

:getapp
echo do::getapp
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

:ask
echo do::ask
echo    1) push-medusa
echo    2) getapp
echo    3) pushapp
echo    4) zipapp
echo    5) unzipapp
echo    r) return
set /p c=please input your choice:

if /i "%c%"=="1" call:push
if /i "%c%"=="2" call:getapp
if /i "%c%"=="3" call:pushapp
if /i "%c%"=="4" call:zipapp
if /i "%c%"=="5" call:unzipapp
if /i "%c%"=="r" goto:eof
echo error-input
call:ask

:main
echo do::main
rem call:test 111 222
call:ask
goto:quit

:quit
echo quit
cd %ROOT%
REM
REM medusa.bat ends here
