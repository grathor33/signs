#!/bin/bash

# 02_02_install_maven on ubuntu
# remove old if exists:
cd /opt/
sudo rm -r /opt/maven-3.6.3/
# download the latest stable version of Apache Maven from the official website:
sudo wget https://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
# extract the downloaded archive:
sudo tar -xvzf apache-maven-3.6.3-bin.tar.gz
# rename the extracted directory:
sudo mkdir /opt/maven/
sudo mv /opt/apache-maven-3.6.3 /opt/maven/maven-3.6.3
cd /opt/maven/maven-3.6.3
sudo rm /opt/apache-maven-3.6.3-bin.tar.gz
