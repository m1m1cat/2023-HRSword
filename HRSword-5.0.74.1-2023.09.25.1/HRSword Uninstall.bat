@ECHO OFF & PUSHD "%~DP0" && CD /D "%~DP0"
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
ver | find " 10.0." >NUL && goto Win10
if exist "%WinDir%\System32\drivers\sysdiag.sys" goto Athrow
if exist "%WinDir%\system32\drivers\hrwfpdrv.sys" goto Athrow
:next
net stop "sysdiag" >NUL
net stop "hrwfpdrv" >NUL
sc delete "hrwfpdrv" >NUL
sc delete "sysdiag" >NUL
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\hrwfpdr" /f >NUL
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\sysdiag" /f >NUL
del/f/q "%userprofile%\desktop\HRSword.lnk" >NUL
echo HRSwordж�سɹ�
pause
exit
:Athrow
msg * "����ʹ��HRSwordɾ���ں�����%WinDir%\System32\drivers\sysdiag hrwfpdrv���������Ժ������д˽ű�"
exit
:Win10
if exist "%WinDir%\System32\drivers\sysdiag_win10.sys" goto Athrow
if exist "%WinDir%\system32\drivers\hrwfpdrv_win10.sys" goto Athrow
goto next