@echo off
cls

SETLOCAL

SET baseFileName=CRUFL_SIVSAUcl

SET regasm2FilePathx86=%SystemRoot%\Microsoft.NET\Framework\v2.0.50727\regasm.exe
SET regasm2FilePathx64=%SystemRoot%\Microsoft.NET\Framework64\v2.0.50727\regasm.exe
SET regasm4FilePathx86=%SystemRoot%\Microsoft.NET\Framework\v4.0.30319\regasm.exe
SET regasm4FilePathx64=%SystemRoot%\Microsoft.NET\Framework64\v4.0.30319\regasm.exe

FOR /D %%I IN (%0) DO SET BATDIR=%%~dpI

CALL :check_admin
if %ERRORLEVEL% NEQ 0 ( EXIT /B %ERRORLEVEL% )

CALL :check_regasm
IF %ERRORLEVEL%==50 ( EXIT /B %ERRORLEVEL% ) 

CALL :check_regasm64
IF %ERRORLEVEL%==50 ( SET x64=0 ) ELSE (SET x64=1) 

SET %ERRORLEVEL%=0



	IF EXIST %regasm4FilePathx86% (
		echo Attempting to install 32-bit version for .NET Framework 4.0 or newer
		CALL :com_register %regasm4FilePathx86%, "net40"
		IF %x64% EQU 1 ( 
			echo Attempting to install 64-bit version for .NET Framework 4.0 or newer
			CALL :com_register %regasm4FilePathx64%, "net40" )
		)
	)



pause
EXIT /B %ERRORLEVEL%



:com_register
	SET fullpath=%BATDIR%%~2\%baseFileName%
	echo %~1 "%fullpath%.dll" /codebase /nologo 
	%~1 "%fullpath%.dll" /codebase /nologo 
EXIT /B %ERRORLEVEL%

:check_regasm
	IF NOT EXIST %regasm2FilePathx86% (
		IF NOT EXIST %regasm4FilePathx86% (
			echo -----------------------	
			echo INSTALLATION ERROR
			echo RegAsm.exe not found. Please install .NET Framework.
			echo -----------------------   
			pause 
			EXIT /B 50
		)
	)  
EXIT /B %ERRORLEVEL%

:check_regasm64
	IF NOT EXIST %regasm2FilePathx64% (
		IF NOT EXIST %regasm4FilePathx64% (
			:: 64-bit not present
			EXIT /B 50
		)
	)  
EXIT /B 0

:check_admin
    net session >nul 2>&1
    if %ERRORLEVEL% NEQ 0 (
		echo -----------------------	
		echo INSTALLATION ERROR
		echo Install with Administrator Privileges: Right-click %~n0%~x0 and select "Run as administrator"
		echo -----------------------       
		pause
    )
EXIT /B %ERRORLEVEL%