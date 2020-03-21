#!/bin/bash

## 03_01_vi_tomcat_service on ubuntu
## create a Systemd Service File
## Copy the path of Tomcat’s home by running this command:
# sudo update-java-alternatives -l
## Output:
## java-1.11.0-openjdk-amd64      1101       /usr/lib/jvm/java-1.11.0-openjdk-amd64</b
## take the highlighted path and put it into your /etc/systemd/system/tomcat.service file, as the JAVA_HOME variable (shown below).
vi /etc/systemd/system/tomcat.service
## Create a unit file to run Tomcat as a service: for startup.sh and shutdown.sh files are located in the /bin directory of Tomcat.
## Be sure that your paths are the correct paths (:wq)
[Unit]
Description=Tomcat 9 servlet container
After=network.target
# After=syslog.target network.target
[Service]
Type=forking
User=tomcat
Group=tomcat
Environment="JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom -Djava.awt.headless=true"
Environment="CATALINA_BASE=/opt/tomcat/apache-tomcat-9.0.11"
Environment="CATALINA_HOME=/opt/tomcat/apache-tomcat-9.0.11"
Environment="CATALINA_PID=/opt/tomcat/apache-tomcat-9.0.11/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
WorkingDirectory=/opt/tomcat/apache-tomcat-9.0.33
ExecStart=/opt/tomcat/apache-tomcat-9.0.33/bin/startup.sh
ExecStop=/opt/tomcat/apache-tomcat-9.0.33/bin/shutdown.sh
# UMask=0007
# RestartSec=10
# Restart=always
[Install]
WantedBy=multi-user.target

