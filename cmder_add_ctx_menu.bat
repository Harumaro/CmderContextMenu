SET CMDERPATH=%cd%
SET CMDERPATHREG=%CMDERPATH:\=\\%
SET ADDREGFILE=%CMDERPATH%\cmder_set_ctx_menu.reg
SET DELREGFILE=%CMDERPATH%\cmder_unset_ctx_menu.reg
SET CMDERBAT=%CMDERPATH%\Cmder.bat

type %ADDREGFILE%
echo Windows Registry Editor Version 5.00 > %ADDREGFILE%
echo. >> %ADDREGFILE%
echo [HKEY_CLASSES_ROOT\directory\background\shell\Cmder] >> %ADDREGFILE%
echo "Icon"="\"%CMDERPATHREG%\\Cmder.exe\"" >> %ADDREGFILE%
echo @="Open Cmder" >> %ADDREGFILE%
echo. >> %ADDREGFILE%
echo [HKEY_CLASSES_ROOT\directory\background\shell\Cmder\command] >> %ADDREGFILE%
echo @="wscript.exe \"%CMDERPATHREG%\\invis.vbs\" \"%CMDERPATHREG%\\Cmder.bat %%V\"" >> %ADDREGFILE%
echo. >> %ADDREGFILE%
echo [HKEY_CLASSES_ROOT\directory\shell\Cmder] >> %ADDREGFILE%
echo "Icon"="\"%CMDERPATHREG%\\Cmder.exe\"" >> %ADDREGFILE%
echo @="Open Cmder" >> %ADDREGFILE%
echo. >> %ADDREGFILE%
echo [HKEY_CLASSES_ROOT\directory\shell\Cmder\command] >> %ADDREGFILE%
echo @="wscript.exe \"%CMDERPATHREG%\\invis.vbs\" \"%CMDERPATHREG%\\Cmder.bat %%V\"" >> %ADDREGFILE%

type %DELREGFILE%
echo Windows Registry Editor Version 5.00 > %DELREGFILE%
echo. >> %DELREGFILE%
echo [-HKEY_CLASSES_ROOT\directory\background\shell\Cmder] >> %DELREGFILE%
echo [-HKEY_CLASSES_ROOT\directory\shell\Cmder] >> %DELREGFILE%

(
    echo SET CMDERPATH=%CMDERPATH%
    echo SET FILENAME=%%CMDERPATH%%\config\user-startup.cmd
    echo SET OLDNAME=%%CMDERPATH%%\config\user-startup.old
    echo move /y %%FILENAME%% %%OLDNAME%%
    echo echo @cd /d %%1 ^>^> %%FILENAME%%
    echo echo cls ^>^> %%FILENAME%%
    echo %%CMDERPATH%%\Cmder.exe
    echo timeout /t 3 /nobreak ^> NUL
    echo move /y %%OLDNAME%% %%FILENAME%%
) > %CMDERBAT%

regedit /s %ADDREGFILE%
