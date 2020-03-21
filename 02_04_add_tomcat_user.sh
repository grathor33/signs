#!/bin/bash

## 02_04_add_tomcat_user on ubuntu
## https://medium.com/@madeeshafernando/installing-apache-tomcat-on-ubuntu-18-04-8cf8bc63993d
## https://www.liquidweb.com/kb/how-to-install-apache-tomcat-9-on-ubuntu-18-04/

## tomcat user = user will be the one who has group ownership to the Tomcat files
sudo useradd -r -m -U -d /opt/tomcat -s /bin/false tomcat
##lub## sudo groupadd tomcat
##lub## sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

## update permissions to Tomcat - for some of the directories of Tomcat.
sudo chown -RH tomcat: /opt/tomcat/apache-tomcat-9.0.33
chgrp -R tomcat /opt/tomcat
cd /opt/tomcat/apache-tomcat-9.0.33
chmod -R g+r conf
chmod g+x conf
chown -R tomcat webapps/ work/ temp/ logs/

## Copy the path of Tomcat’s home by running this command:
sudo update-java-alternatives -l
## Output:
## java-1.11.0-openjdk-amd64      1101       /usr/lib/jvm/java-1.11.0-openjdk-amd64</b
## take the highlighted path and put it into your /etc/systemd/system/tomcat.service file, as the JAVA_HOME variable (shown below).
