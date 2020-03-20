@Echo on

REM DEFAULT_CONFIGURATION=N
SET DEFAULT_CONFIGURATION=Y

REM #Winkey + R then type cmd and run:
REM #jsilently_build_all_deploy_and_run_PL.bat

REM #MSDOS dir http://www.computerhope.com/dirhlp.htm
REM #MSDOS cmds http://www.computerhope.com/msdos.htm

ECHO "####################### DEFAULT SETTING OF DEFAULT ENVIRONMENT VARIABLES. 1 ######################
ECHO "It runs registerHost.bat. It starts  -----------------"
call registerHost.bat
ECHO "It runs registerHost.bat. Finished!  -----------------"

IF "%DEFAULT_CONFIGURATION%"=="N" (
REM SET JAVA_HOME=C:/KD/KDPF/Java/jdk1.7.0_21
SET JAVA_HOME=C:/KD/KDPF/Java/jdk1.8.0_161
REM SET JAVA_HOME=C:/KD/KDPF/Java/openjdk-9.0.4
REM SET JAVA_HOME=C:/KD/KDPF/Java/openjdk-13.0.1
SET MAVEN_HOME=C:/KD/KDPF/maven-3.5.2
REM SET MAVEN_OPTS=-XX:PermSize=128m -XX:MaxPermSize=512m
SET MAVEN_OPTS=-Xmx2048m -XX:PermSize=512m 
SET JAVA_OPTS=-Dhttps.protocols=TLSv1.2
SET USER_NAME_SILENT_IN_CONFIG=gandarych
SET ENV_HOME="C:/Program Files"
SET JRE_HOME=%JAVA_HOME%
SET PATH=C:/WINDOWS/system32;C:/WINDOWS;%MAVEN_HOME%/bin;%JAVA_HOME%/bin;
)

ECHO "####################### SETTING ENVIRONMENT VARIABLES of the user. 2 ######################
ECHO "####################### Build: APPLICATION SPECIFIC... ####################################
SET APPLICATION_NAME="signs"
REM #If I created it with a dot "git clone ssh://git@HHHHHHHHH.git ."
SET GIT_DIRECTORY=master
SET GIT_DIRECTORY_PATH_SILENT=C:/KD/_KDPROJ/JAVA/_gitor/signs/%GIT_DIRECTORY%
SET APPLICATION_VERSION="1.0.2-SNAPSHOT"
SET CALLING_REST_METHOD=hello
SET CALLING_REST_SUFFIX=?name=Amy

ECHO "####################### Run: APPLICATION SPECIFIC... ######################################
SET MAVEN_RUN="%MAVEN_HOME%/bin/mvn"
SET MAVEN_RUN_YES_TO_VERBOSE_MODE=N
SET MAVEN_RUN_SKIP_TESTS_MODE=Y
REM #C:/Windows/System32/drivers/etc/hosts  "127.0.0.1 localhost" 
SET IF_SSL_PROTOCOL=http
SET APPLICATION_IP=localhost
SET PORT=8080
SET DEBUG_PORT=8000
SET ENVIRONMENT_NAME=TST1

ECHO "####################### SETTING THE REST OF ENVIRONMENT VARIABLES. 3 ######################
SET SOURCE_TOMCAT_PATH_SILENT=C:/KD/TOMCAT_UWAGA/apache-tomcat-9.0.31
SET RUN_TOMCAT_PATH_SILENT=C:/KD/_KDPROJ/JAVA/_runn/_TOMCAT/apache-tomcat-9.0.31
SET PASSWORDS_PATH_SILENT=C:/KD/_KDPROJ/JAVA/_runn/passwd/%ENVIRONMENT_NAME%

IF "%ENVIRONMENT_NAME%"=="TST1" (
	SET USER_NAME_ON_ENV_SILENT_PROFILE=%USER_NAME_SILENT_IN_CONFIG%-on-%ENVIRONMENT_NAME%
)

@Echo off
SET CERTS_KEY_STORE_FILE_PATH=C:/KD/_KDPROJ/JAVA/_runn/certs
SET LICENCIES_KEY_STORE_FILE_PATH=C:/KD/_KDPROJ/JAVA/_runn/licencies

SET JAVA_HOME=%JAVA_HOME%
SET JRE_HOME=%JAVA_HOME%

@Echo on
ECHO "Have you saved changes [Save All]?"
ECHO "Did you turn off the server [Server Shutdown], closing the CLI session cmd?"

ECHO "####################### SUMMARY OF ENVIRONMENT VARIABLES. 4 ######################
ECHO ENVIRONMENT_NAME = %ENVIRONMENT_NAME%
ECHO SOURCE_TOMCAT_PATH_SILENT = %SOURCE_TOMCAT_PATH_SILENT%
ECHO RUN_TOMCAT_PATH_SILENT = %RUN_TOMCAT_PATH_SILENT%
ECHO GIT_DIRECTORY = %GIT_DIRECTORY%
ECHO PASSWORDS_PATH_SILENT = %PASSWORDS_PATH_SILENT%
ECHO GIT_DIRECTORY_PATH_SILENT = %GIT_DIRECTORY_PATH_SILENT%
ECHO BINARY_PDF_STORE_FILES_DIR = %BINARY_PDF_STORE_FILES_DIR%
ECHO CERTS_KEY_STORE_FILE_PATH = %CERTS_KEY_STORE_FILE_PATH%
ECHO LICENCIES_KEY_STORE_FILE_PATH = %LICENCIES_KEY_STORE_FILE_PATH%
ECHO MAVEN_OPTS = %MAVEN_OPTS%"

ECHO CATALINA_HOME = %CATALINA_HOME%
ECHO USER_NAME_ON_ENV_SILENT_PROFILE = %USER_NAME_ON_ENV_SILENT_PROFILE%
ECHO ENV_HOME = %ENV_HOME%"
ECHO MAVEN_HOME = %MAVEN_HOME%"
ECHO PATH = %PATH%"


ECHO "####################### CLEANING DIRECTORIES ######################
ECHO It cleans the content %RUN_TOMCAT_PATH_SILENT%
CALL RMDIR /S /Q "%RUN_TOMCAT_PATH_SILENT%/"
CALL MKDIR "%RUN_TOMCAT_PATH_SILENT%/"

ECHO "####################### COMPILING AND BUILDING ########################"
CD %GIT_DIRECTORY_PATH_SILENT%
ECHO "%MAVEN_RUN% -e -X -Dmaven.test.skip=true clean install. It starts WITH DEBUG VERBOSE MODE -----------------"
ECHO "I switch off tests because of spring-cloud-starter-contract-stub-runner: stubs are not prepared yet. -----------------"

IF "%MAVEN_RUN_SKIP_TESTS_MODE%"=="Y" (
  IF "%MAVEN_RUN_YES_TO_VERBOSE_MODE%"=="Y" (
    CALL %MAVEN_RUN% -X -T 4 -Dmaven.test.skip=true clean install
  )
  IF "%MAVEN_RUN_YES_TO_VERBOSE_MODE%"=="N" (
    CALL %MAVEN_RUN% -T 4 -Dmaven.test.skip=true clean install
  )
)

IF "%MAVEN_RUN_SKIP_TESTS_MODE%"=="N" (
  IF "%MAVEN_RUN_YES_TO_VERBOSE_MODE%"=="Y" (
    CALL %MAVEN_RUN% -e -X clean install
  )
  IF "%MAVEN_RUN_YES_TO_VERBOSE_MODE%"=="N" (
    CALL %MAVEN_RUN% clean install
  )
)

ECHO "%MAVEN_RUN% -e -X -Dmaven.test.skip=true clean install. Finished WITH DEBUG VERBOSE MODE! -----------------"

REM ECHO "####################### CREATING AND UNPACKING A PACKAGE ###########################
REM CD %GIT_DIRECTORY_PATH_SILENT%/
REM ECHO %MAVEN_RUN% clean package -Ppackage-local -Duser.name=%USER_NAME_ON_ENV_SILENT_PROFILE%. It starts  -----------------
REM CALL %MAVEN_RUN% clean package -Ppackage-local -Duser.name=%USER_NAME_ON_ENV_SILENT_PROFILE%
REM ECHO %MAVEN_RUN% clean package -Ppackage-local -Duser.name=%USER_NAME_ON_ENV_SILENT_PROFILE%. Finished! -----------------

REM CD %GIT_DIRECTORY_PATH_SILENT%/target
REM ECHO It does to unzip and decompress javer-%USER_NAME_ON_ENV_SILENT_PROFILE%.zip. It starts  -----------------
REM "%JAVA_HOME%/bin/jar" xf "%GIT_DIRECTORY_PATH_SILENT%/target/javer-%USER_NAME_ON_ENV_SILENT_PROFILE%.zip"
REM ECHO Unzipping javer-%USER_NAME_ON_ENV_SILENT_PROFILE%.zip is finished! -----------------

ECHO "##########################################
ECHO "############################ *** BUILD Process: Is it in progress now? *** #############################
ECHO "##########################################

ECHO "####################### DEPLOYING A PACKAGE #############################"
ECHO "DEPLOYING. It starts  -----------------"
ECHO ----- It copies directories and files from ... %SOURCE_TOMCAT_PATH_SILENT%/ -----------------
ECHO ----------------- It copies directories and files to ... %RUN_TOMCAT_PATH_SILENT%/ ...
@Echo off
REM CALL XCOPY "%SOURCE_TOMCAT_PATH_SILENT%\*.*" "%RUN_TOMCAT_PATH_SILENT%\" /E /q
REM CALL XCOPY "%GIT_DIRECTORY_PATH_SILENT%\target\*.*" "%RUN_TOMCAT_PATH_SILENT%" /E /q
REM CALL XCOPY "%GIT_DIRECTORY_PATH_SILENT%\target\%APPLICATION_NAME%-%APPLICATION_VERSION%" "%RUN_TOMCAT_PATH_SILENT%/webapps" /E /q

@Echo on
ECHO Copying files...
ECHO f | CALL XCOPY /f /y "%PASSWORDS_PATH_SILENT%/javer-%USER_NAME_ON_ENV_SILENT_PROFILE%.properties" "%RUN_TOMCAT_PATH_SILENT%/javer-%USER_NAME_ON_ENV_SILENT_PROFILE%.properties"

ECHO It copies the password file %PASSWORDS_PATH_SILENT%/passw.properties -----------------
ECHO f | CALL XCOPY /f /y "%PASSWORDS_PATH_SILENT%/passw.properties" "%RUN_TOMCAT_PATH_SILENT%/passw.properties"
ECHO "DEPLOYING. Finished! -----------------"

ECHO "####################### CONFIGURATION SETTING ##########################"
ECHO It copies file with settings... -----------------
ECHO f | CALL XCOPY /f /y "%PASSWORDS_PATH_SILENT%/context.xml" "%RUN_TOMCAT_PATH_SILENT%/conf/context.xml"
ECHO f | CALL XCOPY /f /y "%PASSWORDS_PATH_SILENT%/server.xml" "%RUN_TOMCAT_PATH_SILENT%/conf/server.xml"

ECHO "####################### STARTING THE BROWSER ########################"
ECHO "It runs chrome.exe. It starts  -----------------"
cd "C:/Program Files (x86)/Google/Chrome/Application"
IF "%ENVIRONMENT_NAME%"=="TST1" (
    CALL start chrome.exe -incognito --new-window "%IF_SSL_PROTOCOL%://%APPLICATION_IP%:%PORT%/%CALLING_REST_METHOD%"
    CALL start chrome.exe -incognito --new-window "%IF_SSL_PROTOCOL%://%APPLICATION_IP%:%PORT%/%CALLING_REST_METHOD%%CALLING_REST_SUFFIX%"
)

ECHO "It runs chrome.exe. Finished! -----------------"

ECHO "It runs firefox.exe. It starts  -----------------"
cd "C:/Program Files/Mozilla Firefox"
IF "%ENVIRONMENT_NAME%"=="TST1" (
    CALL start firefox.exe -private -new-window "%IF_SSL_PROTOCOL%://%APPLICATION_IP%:%PORT%/%CALLING_REST_METHOD%"
    CALL start firefox.exe -private -new-window "%IF_SSL_PROTOCOL%://%APPLICATION_IP%:%PORT%/%CALLING_REST_METHOD%%CALLING_REST_SUFFIX%"
)

ECHO "It runs firefox.exe. Finished! -----------------"

ECHO "Now You can connect in DEBUG mode in the IDE tool to the port %DEBUG_PORT%. -----------------"

ECHO "##########################################################################
ECHO "####################### ENTER CREDENTIALS AT THE APPLICATION #############"
ECHO "Enter login and password ... -----------------"

ECHO "####################### STARTING THE APPLICATION ###########################"
ECHO "It runs the application. It starts  -----------------"
CD %GIT_DIRECTORY_PATH_SILENT%

IF "%MAVEN_RUN_YES_TO_VERBOSE_MODE%"=="Y" (
CALL %MAVEN_RUN% -X spring-boot:run
)
IF "%MAVEN_RUN_YES_TO_VERBOSE_MODE%"=="N" (
CALL %MAVEN_RUN% spring-boot:run
)

CD %RUN_TOMCAT_PATH_SILENT%/bin
REM CALL catalina jpda start

@Echo off
