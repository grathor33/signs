#!/bin/bash

## 02_03_install_tomcat on ubuntu
## remove old if exists:
sudo rm -r /opt/tomcat/
sudo mkdir /opt/tomcat
## https://medium.com/@madeeshafernando/installing-apache-tomcat-on-ubuntu-18-04-8cf8bc63993d
cd /tmp
sudo wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.33/bin/apache-tomcat-9.0.33.tar.gz
## extract downloaded the Tomcat archive and move it to the /opt/tomcat directory.
sudo tar xf /tmp/apache-tomcat-9*.tar.gz -C /opt/tomcat
sudo rm /tmp/apache-tomcat-9*.tar.gz
sudo mkdir /opt/tomcat/apache-tomcat-KEEPOUT
sudo cp -i -r /opt/tomcat/apache-tomcat-9.0.33/* /opt/tomcat/apache-tomcat-KEEPOUT
cd /opt/tomcat/apache-tomcat-9.0.33
