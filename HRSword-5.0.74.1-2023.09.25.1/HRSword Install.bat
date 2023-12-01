@ECHO OFF & PUSHD "%~DP0" && CD /D "%~DP0"
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
ver | find " 10.0." >NUL && goto Win10
if /i %PROCESSOR_IDENTIFIER:~0,3%==x86 (
copy /y "drivers x32\usysdiag.exe" "%~dp0\" >NUL
copy /y "drivers x32\sysdiag.sys" "%WinDir%\System32\drivers\" >NUL
copy /y "drivers x32\hrwfpdrv.sys" "%WinDir%\System32\drivers\" >NUL
rd /s /q "drivers x64"
) else (
copy /y "drivers x64\usysdiag.exe" "%~dp0\" >NUL
copy /y "drivers x64\sysdiag.sys" "%WinDir%\System32\drivers\" >NUL
copy /y "drivers x64\hrwfpdrv.sys" "%WinDir%\System32\drivers\" >NUL
)
sc create hrwfpdrv binpath= "%WinDir%\System32\drivers\hrwfpdrv.sys" type= kernel >NUL
sc create sysdiag binpath= "%WinDir%\System32\drivers\sysdiag.sys" type= kernel depend= FltMgr group= "PNP_TDI" >NUL
reg add "HKLM\SYSTEM\CurrentControlSet\Services\sysdiag" /f /v "ImagePath" /t REG_EXPAND_SZ /d "system32\DRIVERS\sysdiag.sys" >NUL
reg add "HKLM\SYSTEM\CurrentControlSet\Services\hrwfpdr" /f /v "ImagePath" /t REG_EXPAND_SZ /d "system32\DRIVERS\hrwfpdrv.sys" >NUL
:next
reg add "HKLM\SYSTEM\CurrentControlSet\Services\sysdiag" /f /v "Start" /t reg_dword /d "1" >NUL
reg add "HKLM\SYSTEM\CurrentControlSet\Services\hrwfpdr" /f /v "Start" /t reg_dword /d "1" >NUL
reg add "HKLM\SYSTEM\CurrentControlSet\Services\sysdiag" /f /v "Group" /d "PNP_TDI" >NUL
reg add "HKLM\SYSTEM\CurrentControlSet\Services\sysdiag\Instances" /f /v "DefaultInstance" /d "sysdiag" >NUL
reg add "HKLM\SYSTEM\CurrentControlSet\Services\sysdiag\Instances\sysdiag" /f /v "Altitude" /d "368330" >NUL
reg add "HKLM\SYSTEM\CurrentControlSet\Services\sysdiag\Instances\sysdiag" /f /v "Flags" /t reg_dword /d "0" >NUL
sc start sysdiag >NUL
sc start hrwfpdrv >NUL
set "exe=HRSword.exe"
set "lnk=HRSword"
mshta VBScript:Execute("Set a=CreateObject(""WScript.Shell""):Set b=a.CreateShortcut(a.SpecialFolders(""Desktop"") & ""\%lnk%.lnk""):b.TargetPath=""%~dp0%exe%"":b.WorkingDirectory=""%~dp0"":b.Save:close")
echo Successfully installed HRsword!!!
pause
exit
:Win10
if /i %PROCESSOR_IDENTIFIER:~0,3%==x86 (
copy /y "drivers x32\usysdiag.exe" "%~dp0\" >NUL
copy /y "drivers x32\sysdiag_win10.sys" "%WinDir%\System32\drivers\" >NUL
copy /y "drivers x32\hrwfpdrv_win10.sys" "%WinDir%\System32\drivers\" >NUL
rd /s /q "drivers x64"
) else (
copy /y "drivers x64\usysdiag.exe" "%~dp0\" >NUL
copy /y "drivers x64\sysdiag_win10.sys" "%WinDir%\System32\drivers\" >NUL
copy /y "drivers x64\hrwfpdrv_win10.sys" "%WinDir%\System32\drivers\" >NUL
)
sc create hrwfpdrv binpath= "%WinDir%\System32\drivers\hrwfpdrv_win10.sys" type= kernel >NUL
sc create sysdiag binpath= "%WinDir%\System32\drivers\sysdiag_win10.sys" type= kernel depend= FltMgr group= "PNP_TDI" >NUL
reg add "HKLM\SYSTEM\CurrentControlSet\Services\sysdiag" /f /v "ImagePath" /t REG_EXPAND_SZ /d "system32\DRIVERS\sysdiag_win10.sys" >NUL
reg add "HKLM\SYSTEM\CurrentControlSet\Services\hrwfpdr" /f /v "ImagePath" /t REG_EXPAND_SZ /d "system32\DRIVERS\hrwfpdrv_win10.sys" >NUL
goto next