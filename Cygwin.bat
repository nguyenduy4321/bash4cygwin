@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

SET pathcurrent=%__CD__%
SET home=%~dp0home\%USERNAME%
SET cdrun=/!pathcurrent:%home%=!

IF exist %home% (

	IF  /%pathcurrent%==%cdrun% (
		SET cdrun=/cygdrive%cdrun::=%
		SET cdrun=cd !cdrun:\=/!
	) ELSE (
		SET cdrun=cd ~
	)
	
	IF EXIST %~dp0home\%USERNAME%\.cdrun DEL /Q %~dp0home\%USERNAME%\.cdrun
	ECHO | SET /P=!cdrun!>>%~dp0home\%USERNAME%\.cdrun

	FIND /I ". /home/%USERNAME%/.cdrun" %~dp0home\%USERNAME%\.bashrc >NUL
	IF NOT !ERRORLEVEL! EQU 0 ECHO | SET /P=". /home/%USERNAME%/.cdrun">>%~dp0home\%USERNAME%\.bashrc
	
	SET TERM=
	CD /D "%~dp0bin" 
	bash --login -i
) ELSE (
	SET TERM=
	CD /D "%~dp0bin" 
	bash --login -i -c "echo;read -p 'Press [ENTER] to complete setup.'"
)

