@echo off

cd /d %~dp0%
call env.bat
call app-fetch.bat

copy /y %HOME%\config\.emacs %HOME%\.emacs
cd %HOME%
start %EMACS_BIN%\runemacs.exe --debug-init

REM -l %ROOT%\config\init.el
REM emacs -batch -f batch-byte-compile *.el
REM start %EMACS_BIN%\runemacs.exe -debug-init 
