@echo off

cd /d %~dp0%
call env.bat

set HOME=%EMACS_CONFIG_HOME%
cd %HOME%

%EMACS_BIN%\emacs.exe -debug-init -nw -l ..\config\init.el
REM %EMACS_BIN%\emacs.exe -debug-init -nw -batch -f batch-byte-compile ..\config\*.el -q -l ..\config\init.el
