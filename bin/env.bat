@echo off

cd /d %~dp0%

set ROOT=%CD%\..\
set APP_HOME=%ROOT%\cache\apps
REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM Emacs
REM set EMACS_HOME=%APP_HOME%\emacs-24.5-bin-i686-mingw32
REM set EMACS_HOME=%APP_HOME%\emacs-bin-w64-24.5-1
set EMACS_HOME=%APP_HOME%\emacs-bin-w64-25.0.91-O2
set EMACS_BIN=%EMACS_HOME%\bin

set EMACS_CONFIG_HOME=%ROOT%\cache
set ALTERNATE_EDITOR=%EMACS_BIN%\emacsclientw.exe
set EMACS_SERVER_FILE=%EMACS_CONFIG_HOME%\.emacs.d\server\emacs-server-file

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM MinGW
set MINGW_HOME=%APP_HOME%\MinGW
set MINGW_BIN=%MINGW_HOME%\bin

set PKG_CONFIG_BIN=%APP_HOME%\pkg-config_0.26-1_win32\bin
set PKG_CONFIG_PATH=%APP_HOME%\glib-dev_2.28.8-1_win32\lib\pkgconfig

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM Global
set GLOBAL_BIN=%APP_HOME%\glo652wb\bin
REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM Git
set GIT_HOME=%MINGW_HOME%\git
set GIT_BIN=%GIT_HOME%\bin
set GIT_CMD_BIN=%GIT_HOME%\mingw64\bin

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM Cmake
set CMAKE_HOME=%APP_HOME%\cmake-3.4.1-win32-x86
set CMAKE_BIN=%CMAKE_HOME%\bin

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM OpenSSL
set OPENSSL_BIN=%APP_HOME%\openssl-1.0.2.d-1\bin

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM Omnisharp
set OMNISHARP_HOME=%APP_HOME%\omnisharp-server
set OMNISHARP_BIN=%OMNISHARP_HOME%\bin
REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM MsBuild
set MSBUILD_HOME="C:\Program Files (x86)\MSBuild\14.0\Bin"
set MSBUILD_BIN=%MSBUILD_HOME%\Bin

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM Protobuf-net
set PROTOBUF_BIN=%APP_HOME%\protobuf

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set LLVM_HOME=%APP_HOME%\LLVM
set LLVM_BIN=%LLVM_HOME%\bin

set CLANG_HOME=%APP_HOME%\Clang\bin
set CLANG_BIN=%CLANG_HOME%\bin

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set PATH=%ROOT%\bin;%PATH%
set PATH=%GLOBAL_BIN%;%CMAKE_BIN%;%OPENSSL_BIN%;%PATH%
set PATH=%PKG_CONFIG_BIN%;%PKG_CONFIG_PATH%;%PATH%
set PATH=%MINGW_BIN%;%GIT_BIN%;%GIT_CMD_BIN%;%PATH%
set PATH=%MSBUILD_BIN%;%PROTOBUF_BIN%;%PATH%
set PATH=%LLVM_BIN%;%CLANG_BIN%;%PATH%
set PATH=%OMNISHARP_BIN%;%PATH%
REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
