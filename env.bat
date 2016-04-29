@echo off

cd /d %~dp0%

set ROOT=%CD%
set CACHE=%ROOT%\home
set APP_HOME=%CACHE%\apps
set ZIP_HOME=%CACHE%\apps-zip

IF NOT EXIST %CACHE% (
   mkdir %CACHE%
)
rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem emacs
set EMACS_HOME=%APP_HOME%\emacs-bin-w64-25.0.92-O2
rem set EMACS_HOME=%APP_HOME%\emacs-25-20160331T094545Z-bin-i686-mingw32
set EMACS_BIN=%EMACS_HOME%\bin

set HOME=%ROOT%\home
set ALTERNATE_EDITOR=%EMACS_BIN%\emacsc.exe
set EMACS_SERVER_FILE=%HOME%\.emacs.d\server\emacs-server-file

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem msys2
set MSYS_HOME=%APP_HOME%\msys32
set MSYS_BIN=%MSYS_HOME%\usr\bin

set MSYS_HOME2=c:\msys32
set MSYS_BIN2=%MSYS_HOME2%\usr\bin

set MSYS_HOME3=d:\msys32
set MSYS_BIN3=%MSYS_HOME3%\usr\bin

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem mingw
rem set MINGW_HOME=%APP_HOME%\MinGW
rem set MINGW_BIN=%MINGW_HOME%\bin

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem git
rem set GIT_HOME=%MINGW_HOME%\git
rem set GIT_BIN=%GIT_HOME%\mingw64\bin
rem set GIT_USR_BIN=%GIT_HOME%\usr\bin
rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem cmake
rem set CMAKE_HOME=%APP_HOME%\cmake-3.4.1-win32-x86
rem set CMAKE_BIN=%CMAKE_HOME%\bin

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem openssl
rem set OPENSSL_BIN=%APP_HOME%\openssl-1.0.2.d-1\bin

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem global
rem set GLOBAL_BIN=%APP_HOME%\glo652wb\bin

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem pkg-config
rem set PKG_CONFIG_BIN=%APP_HOME%\pkg-config_0.26-1_win32\bin
rem set PKG_CONFIG_PATH=%APP_HOME%\glib-dev_2.28.8-1_win32\lib\pkgconfig
rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem MsBuild
rem set MSBUILD_HOME="C:\Program Files (x86)\MSBuild\14.0\Bin"
rem set MSBUILD_BIN=%MSBUILD_HOME%\Bin

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem omnisharp
set OMNISHARP_HOME=%APP_HOME%\omnisharp-server
set OMNISHARP_BIN=%OMNISHARP_HOME%\bin


rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem protobuf-net
set PROTOBUF_BIN=%APP_HOME%\protobuf

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem set LLVM_HOME=%APP_HOME%\LLVM
rem set LLVM_BIN=%LLVM_HOME%\bin

rem set CLANG_HOME=%APP_HOME%\Clang\bin
rem set CLANG_BIN=%CLANG_HOME%\bin

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set PATH=%MSYS_BIN%;%MSYS_BIN2%;%MSYS_BIN3%;%PATH%
rem set PATH=%GLOBAL_BIN%;%CMAKE_BIN%;%OPENSSL_BIN%;%PATH%
rem set PATH=%PKG_CONFIG_BIN%;%PKG_CONFIG_PATH%;%PATH%
rem set PATH=%MINGW_BIN%;%GIT_BIN%;%GIT_USR_BIN%;%PATH%
rem set PATH=%MSBUILD_BIN%;%PROTOBUF_BIN%;%PATH%
rem set PATH=%LLVM_BIN%;%CLANG_BIN%;%PATH%
set PATH=%OMNISHARP_BIN%;%PATH%
set PATH=%EMACS_BIN%;%PATH%
set PATH=%ROOT%\bin;%PATH%
rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
