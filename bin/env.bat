@echo off

cd /d %~dp0%

set ROOT=%CD%\..\
set CACHE=%ROOT%\cache
set APP_HOME=%CACHE%\apps

IF NOT EXIST %CACHE% (
   mkdir %CACHE%
)
REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM emacs
set EMACS_HOME=%APP_HOME%\emacs-bin-w64-25.0.91-O2
set EMACS_BIN=%EMACS_HOME%\bin

set EMACS_CONFIG_HOME=%ROOT%\cache
set ALTERNATE_EDITOR=%EMACS_BIN%\emacsclientw.exe
set EMACS_SERVER_FILE=%EMACS_CONFIG_HOME%\.emacs.d\server\emacs-server-file

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM msys2
set MSYS_HOME=%APP_HOME%\msys32
set MSYS_BIN=%MSYS_HOME%\usr\bin

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM mingw
rem set MINGW_HOME=%APP_HOME%\MinGW
rem set MINGW_BIN=%MINGW_HOME%\bin

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM git
rem set GIT_HOME=%MINGW_HOME%\git
rem set GIT_BIN=%GIT_HOME%\mingw64\bin
rem set GIT_USR_BIN=%GIT_HOME%\usr\bin
REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM cmake
rem set CMAKE_HOME=%APP_HOME%\cmake-3.4.1-win32-x86
rem set CMAKE_BIN=%CMAKE_HOME%\bin

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM openssl
rem set OPENSSL_BIN=%APP_HOME%\openssl-1.0.2.d-1\bin

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM global
rem set GLOBAL_BIN=%APP_HOME%\glo652wb\bin

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM pkg-config
rem set PKG_CONFIG_BIN=%APP_HOME%\pkg-config_0.26-1_win32\bin
rem set PKG_CONFIG_PATH=%APP_HOME%\glib-dev_2.28.8-1_win32\lib\pkgconfig
REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM MsBuild
rem set MSBUILD_HOME="C:\Program Files (x86)\MSBuild\14.0\Bin"
rem set MSBUILD_BIN=%MSBUILD_HOME%\Bin

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM omnisharp
set OMNISHARP_HOME=%APP_HOME%\omnisharp-server
set OMNISHARP_BIN=%OMNISHARP_HOME%\bin


REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM protobuf-net
set PROTOBUF_BIN=%APP_HOME%\protobuf

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem set LLVM_HOME=%APP_HOME%\LLVM
rem set LLVM_BIN=%LLVM_HOME%\bin

rem set CLANG_HOME=%APP_HOME%\Clang\bin
rem set CLANG_BIN=%CLANG_HOME%\bin

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set PATH=%EMACS_BIN%;%PATH%
set PATH=%MSYS_BIN%;%PATH%
rem set PATH=%GLOBAL_BIN%;%CMAKE_BIN%;%OPENSSL_BIN%;%PATH%
rem set PATH=%PKG_CONFIG_BIN%;%PKG_CONFIG_PATH%;%PATH%
rem set PATH=%MINGW_BIN%;%GIT_BIN%;%GIT_USR_BIN%;%PATH%
rem set PATH=%MSBUILD_BIN%;%PROTOBUF_BIN%;%PATH%
rem set PATH=%LLVM_BIN%;%CLANG_BIN%;%PATH%
set PATH=%OMNISHARP_BIN%;%PATH%
REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
