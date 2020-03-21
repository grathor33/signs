#!/bin/bash

## 03_02_systemctl_start_tomcat on ubuntu
## Reload the Systemd File
sudo systemctl daemon-reload
## Restart Tomcat
sudo systemctl start tomcat
## Note: If the Tomcat service fails to start use "journalctl -xn" as a way to know the exact errors that are occurring.
## Verify Tomcat is Running by the status
sudo systemctl status tomcat
## Output:
#### * tomcat.service - Apache Tomcat
#### Loaded: loaded (/etc/systemd/system/tomcat.service; enabled; vendor preset: enabled)
#### Active: active (running) since Thu 2019-04-04 14:33:04 EDT; 4min 29s ago
#### Process: 10912 ExecStart=/opt/tomcat/apache-tomcat-9.0.8/bin/startup.sh (code=exited, status=0/SUCCESS)
#### Main PID: 10930 (java)
#### Tasks: 47 (limit: 2157)
#### CGroup: /system.slice/tomcat.service
#### `-10930 /usr/lib/jvm/java-1.11.0-openjdk-amd64/bin/java -Djava.util.logging.config.file=/opt/tomcat/apache-tomcat-9.0.8/conf/logging.properties -#### Djava.util.logging.manage
## If correctly installed you’ll also be able to see the Tomcat default page by visiting http://Host_IP:8080 in your browser,
## replacing Host_IP with your server’s IP or hostname, followed by Tomcat’s port number 8080.

