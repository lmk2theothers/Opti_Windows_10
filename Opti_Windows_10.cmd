@echo off 
net session >nul
if %errorlevel% neq 0 goto elevate >nul
goto :start

:elevate
cd /d %~dp0
mshta "javascript: var shell = new ActiveXObject('shell.application'); shell.ShellExecute('%~nx0', '', '', 'runas', 1);close();" >nul
exit

:start
rem Elevation of "As an Admin" privileges

echo.
echo [+] This program will repair your hard drive and disable Windows 10 services.
timeout /t 3 > nul
echo.

rem Creation of a system restoration point 
echo [+] Creating a System Restore Point...
Wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "%DATE%", 100, 7 > nul
echo.

rem Deactivation of unnecessary services
echo [+] Disabling Services...
echo.

echo [+] Disabling MapsBroker...
sc stop MapsBroker > nul
sc config MapsBroker start=disabled > nul
echo [+] Disabling WSearch...
sc stop WSearch > nul
sc config WSearch start=demand > nul
echo [+] Disabling SSDPSRV...
sc stop SSDPSRV > nul
sc config SSDPSRV start=disabled > nul 
echo [+] Disabling lfsvc...
sc stop lfsvc > nul
sc config lfsvc start=disabled > nul
echo [+] Disabling AXInstSV...
sc stop AXInstSV > nul
sc config AXInstSV start=disabled > nul
echo [+] Disabling AJRouter...  
sc stop AJRouter > nul 
sc config AJRouter start=disabled > nul
echo [+] Disabling AppReadiness...
sc stop AppReadiness > nul 
sc config AppReadiness start=disabled > nul
echo [+] Disabling HomeGroupListener...
sc stop HomeGroupListener > nul
sc config HomeGroupListener start=disabled > nul
echo [+] Disabling HomeGroupProvider...
sc stop HomeGroupProvider > nul
sc config HomeGroupProvider start=disabled > nul
echo [+] Disabling SharedAccess...  
sc stop SharedAccess > nul 
sc config SharedAccess start=disabled > nul
echo [+] Disabling lltdsvc...
sc stop lltdsvc > nul 
sc config lltdsvc start=disabled > nul 
echo [+] Disabling wlidsvc...
sc stop wlidsvc > nul
sc config wlidsvc start=disabled > nul
echo [+] Disabling SmsRouter...
sc stop SmsRouter > nul 
sc config SmsRouter start=disabled > nul 
echo [+] Disabling NcdAutoSetup...
sc stop NcdAutoSetup > nul
sc config NcdAutoSetup start=disabled > nul 
echo [+] Disabling PNRPsvc...
sc stop PNRPsvc > nul 
sc config PNRPsvc start=disabled > nul 
echo [+] Disabling p2psvc...
sc stop p2psvc > nul  
sc config p2psvc start=disabled > nul
echo [+] Disabling p2pimsvc
sc stop p2pimsvc > nul 
sc config p2pimsvc start=disabled > nul
echo [+] Disabling PNRPAutoReg... 
sc stop PNRPAutoReg > nul 
sc config PNRPAutoReg start=disabled > nul
echo [+] Disabling WalletService...
sc stop WalletService > nul 
sc config WalletService start=disabled > nul
echo [+] Disabling WMPNetworkSvc...
sc stop WMPNetworkSvc > nul
sc config WMPNetworkSvc start=disabled > nul
echo [+] Disabling icssvc...
sc stop icssvc > nul 
sc config icssvc start=disabled > nul
echo [+] Disabling XblAuthManager... 
sc stop XblAuthManager > nul
sc config XblAuthManager start=disabled > nul
echo [+] Disabling XblGameSave... 
sc stop XblGameSave > nul 
sc config XblGameSave start=disabled > nul
echo [+] Disabling XboxNetApiSvc...
sc stop XboxNetApiSvc > nul 
sc config XboxNetApiSvc start=disabled > nul
echo [+] Disabling DmEnrollmentSvc...
sc stop DmEnrollmentSvc > nul
sc config DmEnrollmentSvc start=disabled > nul 
echo [+] Disabling RetailDemo...
sc stop RetailDemo > nul
sc config RetailDemo start=disabled > nul
echo [+] Disabling SysMain...
sc stop SysMain > nul
sc config SysMain start=disabled > nul
echo [+] Disabling stisvc...
sc stop stisvc > nul
sc config stisvc start=disabled > nul
echo [+] Disabling WpcMonSvc...
sc stop WpcMonSvc > nul
sc config WpcMonSvc start=disabled > nul 
echo [+] Disabling DiagTrack...
sc stop DiagTrack > nul
sc config DiagTrack start=disabled > nul
echo.

rem Hard drive repair
echo [+] Starting Defrag Your Hard Drive... 
defrag.exe C: /U /V > nul
echo.

echo [+] Enabling Optimal Performances of Windows 10
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 > nul
echo.

rem Clean Hard Drive
echo [+] Cleaning your Hard Drive...
cleanmgr /sagerun:65535 

rem Scanning System Files
echo [+] SFC Scan...
sfc /scannow > nul
echo. 

echo [+] Finished Please Reboot Your Computer Press a Key to Exit
pause > nul
exit