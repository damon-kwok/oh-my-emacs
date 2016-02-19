@echo off

set year=%date:~0,4%
set month=%date:~5,2%
set day=%date:~8,2%
set week=%date:~10,6%
set hour=%time:~0,2%
set minute=%time:~3,2%
set second=%time:~6,2%
set ms=%time:~9,2%

tools\7z a -v30m -t7z "caches\applications-%year%-%month%-%day%--%hour%-%minute%.7z" "applications\*"