@echo off

cd /d %~dp0%
call env.bat

set HOME=%EMACS_CONFIG_HOME%
copy /y %ROOT%\config\templates\.emacs %HOME%\.emacs

cd %HOME%
start %EMACS_BIN%\runemacs.exe -debug-init -l %ROOT%\config\init.el

REM emacs -batch -f batch-byte-compile *.el
REM start %EMACS_BIN%\runemacs.exe -debug-init 


