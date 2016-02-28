@echo off
if not exist "%~dp0bin\gcc.exe" goto epicfail1
if not exist "%~dp0set_distro_paths.bat" goto epicfail2
cmd /k ""%~dp0set_distro_paths.bat" && title MinGW"
goto :eof

:epicfail1
set X_ERR1=ERROR: You must run %~nx0 from the root of the distro.
set X_ERR2=       Don't copy or move this batch file.
set X_ERR3=       However, it's okay to create a shortcut to this batch file.
cmd /t:4f /k "echo %X_ERR1% && echo %X_ERR2% && echo %X_ERR3% && title ERROR"
goto :eof

:epicfail2
set X_ERR1=ERROR: set_distro_paths.bat is missing from the root of the distro.
set X_ERR2=       Don't move or delete that batch file.
cmd /t:4f /k "echo %X_ERR1% && echo %X_ERR2% && title ERROR"
goto :eof
