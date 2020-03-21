@Echo on

REM DEFAULT_CONFIGURATION=N
SET DEFAULT_CONFIGURATION=Y

REM #Winkey + R then type cmd and run:
REM #jsilently_build_all_deploy_and_run_PL.bat

REM #MSDOS dir http://www.computerhope.com/dirhlp.htm
REM #MSDOS cmds http://www.computerhope.com/msdos.htm

ECHO "####################### DOMYSLNE USTAWIENIE domyslnych ZMIENNYCH SRODOWISKOWYCH. 1 #####################"
ECHO "Uruchamiam registerHost.bat. Rozpoczynam  -----------------"
call registerHost.bat
ECHO "Uruchamiam registerHost.bat. Zakonczone!  -----------------"

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

ECHO "####################### USTAWIENIE ZMIENNYCH SRODOWISKOWYCH uzytkownika. 2 ################"
ECHO "####################### Build: APPLICATION SPECIFIC... ####################################
SET APPLICATION_NAME="signs"
REM #Jesli stworzylem git clone z kropka "git clone ssh://git@HHHHHHHHH.git ."
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

ECHO "####################### USTAWIENIE RESZTY ZMIENNYCH SRODOWISKOWYCH. 3 ######################"
SET SOURCE_TOMCAT_PATH_SILENT=C:/KD/TOMCAT_UWAGA/apache-tomcat-9.0.31
SET RUN_TOMCAT_PATH_SILENT=C:/KD/_KDPROJ/JAVA/_runn/_TOMCAT/apache-tomcat-9.0.31
SET PASSWORDS_PATH_SILENT=C:/KD/_KDPROJ/JAVA/_runn/passwd/%ENVIRONMENT_NAME%

IF "%ENVIRONMENT_NAME%"=="TST1" (
	SET USER_NAME_ON_ENV_SILENT_PROFILE=%USER_NAME_SILENT%-on-%ENVIRONMENT_NAME%
)

@Echo off
SET CERTS_KEY_STORE_FILE_PATH=C:/KD/_KDPROJ/JAVA/_runn/certs
SET LICENCIES_KEY_STORE_FILE_PATH=C:/KD/_KDPROJ/JAVA/_runn/licencies

SET JAVA_HOME=%JAVA_HOME%
SET JRE_HOME=%JAVA_HOME%

@Echo on
ECHO "Czy zapisales zmiany [Save All]?"
ECHO "Czy wylaczyles serwer [Server Shutdown] zamykajac sesje w CLI cmd?"

ECHO "###################### PODSUMOWANIE ZMIENNYCH SRODOWISKOWYCH. 4 #######################"
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


ECHO "###################### CZYSZCZENIE KATALOGOW #####################"
ECHO Czyszcze zawartosc %RUN_TOMCAT_PATH_SILENT%
CALL RMDIR /S /Q "%RUN_TOMCAT_PATH_SILENT%/"
CALL MKDIR "%RUN_TOMCAT_PATH_SILENT%/"

ECHO "###################### KOMPILOWANIE I BUDOWANIE #######################"
CD %GIT_DIRECTORY_PATH_SILENT%
ECHO "%MAVEN_RUN% -e -X -Dmaven.test.skip=true clean install. Rozpoczynam w DEBUG VERBOSE MODE -----------------"
ECHO "Testy wylaczamy przez spring-cloud-starter-contract-stub-runner: stubs nie sa jeszcze gotowe. -----------------"

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

ECHO "%MAVEN_RUN% clean install. Zakonczone w DEBUG VERBOSE MODE! -----------------"

ECHO "####################### TWORZENIE I ROZPAKOWANIE PACZKI ########################"
CD %GIT_DIRECTORY_PATH_SILENT%/
ECHO "%MAVEN_RUN%" clean package -Ppackage-local -Duser.name=%USER_NAME_ON_ENV_SILENT_PROFILE%. Rozpoczynam  -----------------
REM CALL "%MAVEN_RUN%" clean package -Ppackage-local -Duser.name=%USER_NAME_ON_ENV_SILENT_PROFILE%
ECHO "%MAVEN_RUN%" clean package -Ppackage-local -Duser.name=%USER_NAME_ON_ENV_SILENT_PROFILE%. Zakonczone! -----------------

CD %GIT_DIRECTORY_PATH_SILENT%/target
ECHO Dekompresuje javer-%USER_NAME_ON_ENV_SILENT_PROFILE%.zip. Rozpoczynam  -----------------
REM "%JAVA_HOME%/bin/jar" xf "%GIT_DIRECTORY_PATH_SILENT%/target/javer-%USER_NAME_ON_ENV_SILENT_PROFILE%.zip"
ECHO Dekompresja javer-%USER_NAME_ON_ENV_SILENT_PROFILE%.zip zakonczona! -----------------

ECHO "###########################################"
ECHO "########################## *** Czy sie buduje? *** #############################"
ECHO "###########################################"

ECHO "####################### DEPLOYOWANIE PACZKI ####################################"
ECHO "Deployowanie. Rozpoczynam  -----------------"
ECHO ----- Kopiuje katalogi i pliki z %SOURCE_TOMCAT_PATH_SILENT%/ -----------------
ECHO ----------------- Kopiuje katalogi i pliki do %RUN_TOMCAT_PATH_SILENT%/ ...
@Echo off
CALL XCOPY "%SOURCE_TOMCAT_PATH_SILENT%\*.*" "%RUN_TOMCAT_PATH_SILENT%\" /E /q
REM CALL XCOPY "%GIT_DIRECTORY_PATH_SILENT%\target\*.*" "%RUN_TOMCAT_PATH_SILENT%" /E /q
CALL XCOPY "%GIT_DIRECTORY_PATH_SILENT%\target\%APPLICATION_NAME%-%APPLICATION_VERSION%" "%RUN_TOMCAT_PATH_SILENT%/webapps" /E /q

@Echo on
ECHO Kopiuje pliki...
ECHO f | CALL XCOPY /f /y "%PASSWORDS_PATH_SILENT%\javer-%USER_NAME_ON_ENV_SILENT_PROFILE%.properties" "%RUN_TOMCAT_PATH_SILENT%\javer-%USER_NAME_ON_ENV_SILENT_PROFILE%.properties"

ECHO Kopiuje plik z haslami %PASSWORDS_PATH_SILENT%\passw.properties -----------------
ECHO f | CALL XCOPY /f /y "%PASSWORDS_PATH_SILENT%\passw.properties" "%RUN_TOMCAT_PATH_SILENT%\passw.properties"
ECHO "Deployowanie. Zakonczone! -----------------"

ECHO "######################## USTAWIENIE KONFIGURACJI ##########################"
ECHO Kopiuje plik z ustawieniami -----------------
ECHO f | CALL XCOPY /f /y "%PASSWORDS_PATH_SILENT%\context.xml" "%RUN_TOMCAT_PATH_SILENT%\conf\context.xml"
ECHO f | CALL XCOPY /f /y "%PASSWORDS_PATH_SILENT%\server.xml" "%RUN_TOMCAT_PATH_SILENT%\conf\server.xml"

ECHO "######################### URUCHOMIENIE PRZEGLADARKI #######################"
ECHO "Uruchamiam chrome.exe. Rozpoczynam  -----------------"
cd "C:/Program Files (x86)/Google/Chrome/Application"
IF "%ENVIRONMENT_NAME%"=="TST1" (
    CALL start chrome.exe -incognito --new-window "%IF_SSL_PROTOCOL%://%APPLICATION_IP%:%PORT%/%CALLING_REST_METHOD%"
    CALL start chrome.exe -incognito --new-window "%IF_SSL_PROTOCOL%://%APPLICATION_IP%:%PORT%/%CALLING_REST_METHOD%%CALLING_REST_SUFFIX%"
)

ECHO "Uruchamiam chrome.exe. Zakonczone! -----------------"

ECHO "Uruchamiam firefox.exe. Rozpoczynam  -----------------"
cd "C:/Program Files/Mozilla Firefox"
IF "%ENVIRONMENT_NAME%"=="TST1" (
    CALL start firefox.exe -private -new-window "%IF_SSL_PROTOCOL%://%APPLICATION_IP%:%PORT%/%CALLING_REST_METHOD%"
    CALL start firefox.exe -private -new-window "%IF_SSL_PROTOCOL%://%APPLICATION_IP%:%PORT%/%CALLING_REST_METHOD%%CALLING_REST_SUFFIX%"
)

ECHO "Uruchamiam firefox.exe. Zakonczone! -----------------"

ECHO "Teraz mozna sie podlaczyc w trybie DEBUG w IDE na porcie %DEBUG_PORT%. -----------------"

ECHO "####################################################################
ECHO "######################## ZALOGUJ SIE DO APLIKACJI ##################"
ECHO "Wpisz login i haslo... -----------------"

ECHO "######################## URUCHOMIENIE APLIKACJI ###########################"
ECHO "Uruchamiam aplikacje. Rozpoczynam  -----------------"
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
