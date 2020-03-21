#!/bin/bash

# Open a terminal and run:
# jsilently_build_all_deploy_and_run_EN.sh

export FIREFOX_HOME=/usr/lib/firefox/
export CHROME_HOME=/opt/google/chrome/
export M2_HOME=/root/.m2/repository/
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
# export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export MAVEN_HOME=/opt/maven/maven-3.6.3
# export MAVEN_OPTS="-XX:PermSize=128m -XX:MaxPermSize=512m"
export MAVEN_OPTS="-Xmx2048m -XX:PermSize=512m"
export JAVA_OPTS=-Dhttps.protocols=TLSv1.2
export USER_NAME_SILENT_IN_CONFIG=gandarych
export ENV_HOME="/opt/"
export JRE_HOME=${JAVA_HOME}
export PATH=${PATH};${MAVEN_HOME}/bin;${JAVA_HOME}/bin;

echo "####################### SETTING ENVIRONMENT VARIABLES of the user. 2 ######################"
echo "####################### Build: APPLICATION SPECIFIC... ####################################"
export APPLICATION_NAME="signs"
# git clone https://gandarych@bitbucket.org/gandarych/signs.git
export GIT_DIRECTORY=master
export GIT_DIRECTORY_PATH_SILENT=/home/kris/KD/_KDPROJ/JAVA/_gitor/signs/${GIT_DIRECTORY}
export APPLICATION_VERSION="1.0.2-SNAPSHOT"
export CALLING_REST_METHOD=hello
export CALLING_REST_SUFFIX=?name=Amy

echo "####################### Run: APPLICATION SPECIFIC... ######################################"
export MAVEN_RUN="${MAVEN_HOME}/bin/mvn"
export MAVEN_RUN_YES_TO_VERBOSE_MODE=N
export MAVEN_RUN_SKIP_TESTS_MODE=Y
# etc/hosts  "127.0.0.1 localhost"
export IF_SSL_PROTOCOL=http
export APPLICATION_IP=localhost
export PORT=8080
export DEBUG_PORT=8000
export ENVIRONMENT_NAME=TST1

echo "####################### SETTING THE REST OF ENVIRONMENT VARIABLES. 3 ######################"
export SOURCE_TOMCAT_PATH_SILENT=/opt/tomcat/apache-tomcat-KEEPOUT/
export RUN_TOMCAT_PATH_SILENT=/opt/tomcat/apache-tomcat-9.0.33/
export PASSWORDS_PATH_SILENT=/home/kris/KD/_KDPROJ/JAVA/_runn/passwd/${ENVIRONMENT_NAME}

if [[ $ENVIRONMENT_NAME == "TST1" ]]
then
	export USER_NAME_ON_ENV_SILENT_PROFILE='${USER_NAME_SILENT_IN_CONFIG}-on-${ENVIRONMENT_NAME}'
fi

export CERTS_KEY_STORE_FILE_PATH=/home/kris/KD/_KDPROJ/JAVA/_runn/certs
export LICENCIES_KEY_STORE_FILE_PATH=/home/kris/KD/_KDPROJ/JAVA/_runn/licencies

export JAVA_HOME=${JAVA_HOME}
export JRE_HOME=${JAVA_HOME}

echo "Have you saved changes [[Save All ]]?"
echo "Did you turn off the server [[Server Shutdown ]], closing the CLI session cmd?"

echo "####################### SUMMARY OF ENVIRONMENT VARIABLES. 4 ######################"
echo ENVIRONMENT_NAME=${ENVIRONMENT_NAME}
echo SOURCE_TOMCAT_PATH_SILENT=${SOURCE_TOMCAT_PATH_SILENT}
echo RUN_TOMCAT_PATH_SILENT=${RUN_TOMCAT_PATH_SILENT}
echo GIT_DIRECTORY=${GIT_DIRECTORY}
echo PASSWORDS_PATH_SILENT=${PASSWORDS_PATH_SILENT}
echo GIT_DIRECTORY_PATH_SILENT=${GIT_DIRECTORY_PATH_SILENT}
echo CERTS_KEY_STORE_FILE_PATH=${CERTS_KEY_STORE_FILE_PATH}
echo LICENCIES_KEY_STORE_FILE_PATH=${LICENCIES_KEY_STORE_FILE_PATH}
echo MAVEN_OPTS=${MAVEN_OPTS}

echo CATALINA_HOME=${CATALINA_HOME}
echo USER_NAME_ON_ENV_SILENT_PROFILE=${USER_NAME_ON_ENV_SILENT_PROFILE}
echo ENV_HOME=${ENV_HOME}
echo MAVEN_HOME=${MAVEN_HOME}
echo PATH=${PATH}


echo "####################### CLEANING DIRECTORIES ######################"
echo It cleans the content ${RUN_TOMCAT_PATH_SILENT}
#sudo bash rm -r ${RUN_TOMCAT_PATH_SILENT}
#sudo bash mkdir ${RUN_TOMCAT_PATH_SILENT}

echo "####################### COMPILING AND BUILDING ########################"
cd ${GIT_DIRECTORY_PATH_SILENT}
echo "${MAVEN_RUN} -e -X -Dmaven.test.skip=true clean install. It starts WITH DEBUG VERBOSE MODE -----------------"
echo "I switch off tests because of spring-cloud-starter-contract-stub-runner: stubs are not prepared yet. -----------------"

if [[ $MAVEN_RUN_SKIP_TESTS_MODE == "N" ]]
then
  if [[ $MAVEN_RUN_YES_TO_VERBOSE_MODE == "Y" ]]
  then
    bash $MAVEN_RUN -X -T 4 -Dmaven.test.skip=true clean install
  fi
  if [[ $MAVEN_RUN_YES_TO_VERBOSE_MODE == "N" ]]
  then
    bash $MAVEN_RUN -T 4 -Dmaven.test.skip=true clean install
  fi
fi

if [[ $MAVEN_RUN_SKIP_TESTS_MODE == "Y" ]]
then
  if [[ $MAVEN_RUN_YES_TO_VERBOSE_MODE == "Y" ]]
  then
    bash $MAVEN_RUN -e -X clean install
  fi
  if [[ $MAVEN_RUN_YES_TO_VERBOSE_MODE == "N" ]]
  then
    bash $MAVEN_RUN clean install
  fi
fi

echo "${MAVEN_RUN} -e -X -Dmaven.test.skip=true clean install. Finished WITH DEBUG VERBOSE MODE! -----------------"

# echo "####################### CREATING AND UNPACKING A PACKAGE ###########################"
# cd $GIT_DIRECTORY_PATH_SILENT/
# echo $MAVEN_RUN clean package -Ppackage-local -Duser.name=$USER_NAME_ON_ENV_SILENT_PROFILE. It starts  -----------------
# bash $MAVEN_RUN clean package -Ppackage-local -Duser.name=$USER_NAME_ON_ENV_SILENT_PROFILE
# echo $MAVEN_RUN clean package -Ppackage-local -Duser.name=$USER_NAME_ON_ENV_SILENT_PROFILE. Finished! -----------------

# cd $GIT_DIRECTORY_PATH_SILENT/target
# echo It does to unzip and decompress javer-$USER_NAME_ON_ENV_SILENT_PROFILE.zip. It starts  -----------------
# "$JAVA_HOME/bin/jar" xf "$GIT_DIRECTORY_PATH_SILENT/target/javer-$USER_NAME_ON_ENV_SILENT_PROFILE.zip"
# echo Unzipping javer-$USER_NAME_ON_ENV_SILENT_PROFILE.zip is finished! -----------------

echo "########################################################################################################"
echo "############################ *** BUILD Process: Is it in progress now? *** #############################"
echo "########################################################################################################"

echo "####################### DEPLOYING A PACKAGE #############################"
echo "DEPLOYING. It starts  -----------------"
echo ----- It copies directories and files from ... ${SOURCE_TOMCAT_PATH_SILENT}/ -----------------
echo ----------------- It copies directories and files to ... ${RUN_TOMCAT_PATH_SILENT}/ ...

# bash cp -i -r "$SOURCE_TOMCAT_PATH_SILENT\*.*" "${RUN_TOMCAT_PATH_SILENT}\"
# bash cp -i -r "$GIT_DIRECTORY_PATH_SILENT\target\*.*" "${RUN_TOMCAT_PATH_SILENT}"
# bash cp -i -r "$GIT_DIRECTORY_PATH_SILENT\target\$APPLICATION_NAME-$APPLICATION_VERSION" "$RUN_TOMCAT_PATH_SILENT/webapps"


echo Copying files...
echo f | bash cp -i -r "${PASSWORDS_PATH_SILENT}/javer-${USER_NAME_ON_ENV_SILENT_PROFILE}.properties" "${RUN_TOMCAT_PATH_SILENT}/"

echo It copies the password file ${PASSWORDS_PATH_SILENT}/passw.properties -----------------
echo f | bash cp -i -r "${PASSWORDS_PATH_SILENT}/passw.properties" "${RUN_TOMCAT_PATH_SILENT}/"
echo "DEPLOYING. Finished! -----------------"

echo "####################### CONFIGURATION SETTING ##########################"
echo It copies file with settings... -----------------
echo f | bash cp -i -r "${PASSWORDS_PATH_SILENT}/context.xml" "${RUN_TOMCAT_PATH_SILENT}/conf/"
echo f | bash cp -i -r "${PASSWORDS_PATH_SILENT}/server.xml" "${RUN_TOMCAT_PATH_SILENT}/conf/"

echo "####################### STARTING THE BROWSER ########################"
echo "It runs chrome.exe. It starts  -----------------"
cd $CHROME_HOME
if [[ $ENVIRONMENT_NAME == "TST1" ]]
then
    sudo bash chrome -incognito --new-window "${IF_SSL_PROTOCOL}://${APPLICATION_IP}:}PORT}/${CALLING_REST_METHOD}"
    sudo bash chrome -incognito --new-window "${IF_SSL_PROTOCOL}://${APPLICATION_IP}:}PORT}/${CALLING_REST_METHOD}}CALLING_REST_SUFFIX}"
fi

echo "It runs chrome.exe. Finished! -----------------"

echo "It runs firefox.exe. It starts  -----------------"
cd $FIREFOX_HOME
if [[ $ENVIRONMENT_NAME == "TST1" ]]
then
    sudo bash firefox.sh -private -new-window "${IF_SSL_PROTOCOL}://${APPLICATION_IP}:}PORT}/${CALLING_REST_METHOD}"
    sudo bash firefox.sh -private -new-window "${IF_SSL_PROTOCOL}://${APPLICATION_IP}:}PORT}/${CALLING_REST_METHOD}}CALLING_REST_SUFFIX}"
fi

echo "It runs firefox.exe. Finished! -----------------"

echo "Now You can connect in DEBUG mode in the IDE tool to the port ${DEBUG_PORT}. -----------------"

echo "##########################################################################"
echo "####################### ENTER CREDENTIALS AT THE APPLICATION #############"
echo "Enter login and password ... -----------------"

echo "####################### STARTING THE APPLICATION ###########################"
echo "It runs the application. It starts  -----------------"
cd ${GIT_DIRECTORY_PATH_SILENT}

if [[ $MAVEN_RUN_YES_TO_VERBOSE_MODE == "Y" ]]
then
  bash ${MAVEN_RUN} -X spring-boot:run
fi
if [[ $MAVEN_RUN_YES_TO_VERBOSE_MODE == "N" ]]
then
  bash ${MAVEN_RUN} spring-boot:run
fi

cd ${RUN_TOMCAT_PATH_SILENT}/bin
# bash catalina jpda start


