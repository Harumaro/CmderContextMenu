SET FILENAME="PATH_TO_CMDER\config\user-startup.cmd"
echo @cd /d %cd% >> %FILENAME%
echo cls >> %FILENAME%
"PATH_TO_CMDER\Cmder.exe"