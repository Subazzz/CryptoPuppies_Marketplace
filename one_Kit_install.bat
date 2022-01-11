@echo off
REM This is a sample script
ECHO======================================================================================
ECHO		Kandi kit installation process has begun
ECHO======================================================================================
ECHO 	This kit installer works only on Windows OS
ECHO 	Based on your network speed, the installation may take a while
ECHO======================================================================================
setlocal ENABLEDELAYEDEXPANSION
REM update below path if required
SET NODE_LOCATION="C:\Program Files\nodejs"
SET NODE_VERSION=14.17.3
SET NODE_DOWNLOAD_URL=https://nodejs.org/dist/v14.17.3/node-v14.17.3-x64.msi
SET REPO_DOWNLOAD_URL=https://github.com/Subazzz/CryptoPuppies_Marketplace/releases/download/v2.0/CryptoPuppies_Marketplace.zip
SET REPO_NAME=CryptoPuppies_Marketplace.zip
where /q node
IF ERRORLEVEL 1 (
	ECHO==========================================================================
    	ECHO Node wasn't found in PATH variable
	ECHO==========================================================================
	IF ERRORLEVEL 1 (
		CALL :Install_node_and_modules
	) ELSE (
		CALL :Download_repo

	)
) else (
			ECHO==========================================================================
			ECHO Nodejs was detected!
			ECHO==========================================================================
			
			CALL :Download_repo
			
		)	
	)
)
CALL :Download_repo
PAUSE

EXIT /B %ERRORLEVEL%

:Download_repo
bitsadmin /transfer repo_download_job /download %REPO_DOWNLOAD_URL% 
ECHO==========================================================================
ECHO 	The Kit has been installed successfully
ECHO==========================================================================
ECHO 	To run the kit, follow further instructions of the kit in kandi	
ECHO==========================================================================
EXIT /B 0

:Install_node_and_modules
ECHO==========================================================================
ECHO Downloading NodeJS%NODE_VERSION% ... 
ECHO==========================================================================
REM curl -o node-v%NODE_VERSION%-x64.msi %NODE_DOWNLOAD_URL%
bitsadmin /transfer nodeJS_download_job /download %NODE_DOWNLOAD_URL% "%cd%\node-v%NODE_VERSION%-x64.msi"
ECHO Installing node-v%NODE_VERSION% ...
node-v%NODE_VERSION%-x64.msi /quiet InstallAllUsers=0 PrependPath=1 Include_test=0 TargetDir=%NODE_LOCATION%
ECHO==========================================================================
ECHO Nodejs installed in path : %NODE_LOCATION%
ECHO==========================================================================
IF ERRORLEVEL 1 (
		ECHO==========================================================================
		ECHO There was an error while installing nodeJs!
		ECHO==========================================================================
		msiexec /i node-v%NODE_VERSION%-x64.msi /qr
		EXIT /B 1
)
EXIT /B 0
