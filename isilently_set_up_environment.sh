#!/bin/bash

sudo bash 01_02_update_ubuntu.sh

sudo bash 02_01_install_openjdk.sh

sudo bash 02_02_install_maven.sh

sudo bash 02_03_install_tomcat.sh

sudo bash 02_04_add_tomcat_user.sh

## Modify the content of tomcat.service
cat 03_01_vi_tomcat_service.txt

## sudo bash 03_02_systemctl_start_tomcat.sh
