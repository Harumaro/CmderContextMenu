@echo off

IF "%1" == "" (SET CMDERPATH=%cd%) ELSE (SET CMDERPATH=%1)

SET CMDERPATHREG=%CMDERPATH:\=\\%
SET INVISFILE=%CMDERPATH%\invis.vbs
SET ADDREGFILE=%~dp0cmder_set_ctx_menu.reg
SET CMDERBAT=%CMDERPATH%\Cmder.bat
SET CMDERCTXUNINS=%~dp0cmder_remove_ctx_menu.bat

(
    echo Windows Registry Editor Version 5.00 
    echo.
    echo [HKEY_CLASSES_ROOT\directory\background\shell\Cmder]
    echo "Icon"="\"%CMDERPATHREG%\\Cmder.exe\""
    echo @="Open Cmder"
    echo.
    echo [HKEY_CLASSES_ROOT\directory\background\shell\Cmder\command]
    echo @="wscript.exe \"%CMDERPATHREG%\\invis.vbs\" \"%CMDERPATHREG%\\Cmder.bat %%V\""
    echo.
    echo [HKEY_CLASSES_ROOT\directory\shell\Cmder]
    echo "Icon"="\"%CMDERPATHREG%\\Cmder.exe\""
    echo @="Open Cmder"
    echo.
    echo [HKEY_CLASSES_ROOT\directory\shell\Cmder\command]
    echo @="wscript.exe \"%CMDERPATHREG%\\invis.vbs\" \"%CMDERPATHREG%\\Cmder.bat %%V\""
) > %ADDREGFILE%

echo CreateObject("Wscript.Shell")^.Run "" ^& WScript.Arguments(0) ^& "", 0, False > %INVISFILE%

(
    echo ^@echo off
    echo.
    echo set CMDERPATH=%CMDERPATH%
    echo set FILENAME=%%CMDERPATH%%\config\user-startup.cmd
    echo set OLDNAME=%%CMDERPATH%%\config\user-startup.old
    echo.
    echo move /y %%FILENAME%% %%OLDNAME%%
    echo.
    echo echo @cd /d %%1 ^>^> %%FILENAME%%
    echo echo cls ^>^> %%FILENAME%%
    echo %%CMDERPATH%%\Cmder.exe
    echo.
    echo timeout /t 3 /nobreak ^> NUL
    echo move /y %%OLDNAME%% %%FILENAME%%
) > %CMDERBAT%

(
    echo ^@echo off
    echo SET DELREGFILE=%%~dp0cmder_unset_ctx_menu.reg
    echo set INVISFILE=%INVISFILE%
    echo set CMDERBAT=%CMDERBAT%
    echo.
    echo ^(
    echo echo Windows Registry Editor Version 5.00
    echo echo.
    echo echo [-HKEY_CLASSES_ROOT\directory\background\shell\Cmder]
    echo echo [-HKEY_CLASSES_ROOT\directory\shell\Cmder]
    echo ^) ^> %%DELREGFILE%%
    echo.
    echo regedit /s %%DELREGFILE%%
    echo del /f %%DELREGFILE%%
    echo del /f %%INVISFILE%%
    echo del /f %%CMDERBAT%%
    echo del %%~f0
) > %CMDERCTXUNINS%

regedit /s %ADDREGFILE%
del /f %ADDREGFILE%
del %~f0