#!/bin/bash

############### 01_01 UBUNTU ##############################
## 01_01_install_UBUNTU 18.04.4 LTS
## Installing "Ubuntu 18.04.4 LTS (Bionic Beaver)"

############### 01_02 UPDATE UBUNTU #######################
## Update Ubuntu (+ adding google-chrome-stable_current_amd64.deb, etc.)
## 01_02_update_your_system to the latest stable version
sudo apt-get update -y
sudo apt-get upgrade -y

cd /tmp
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
## CHECK if chrome is installed here:   CHROME_HOME=/opt/google/chrome/

## To make an environment persistent for a user's environment, we export the variable from the user's profile script.
## Open the current user's profile into a text editor (open the terminal):

# sudo vi ~/.bash_profile

## Add the export command for every environment variable you want to persist:

# export JAVA_HOME=/opt/openjdk11
# export USER=kris

## ... etc. Save your changes.

## To enable silent mode of installation and avoid every "Do you want to continue? [Y/n] y"
## read https://libre-software.net/ubuntu-automatic-updates/ and ...
## ... install the unattended-upgrades package on your UBUNTU
## ... or try "sudo apt install -y ... " with "-y" mode if it is eassier and possible.

sudo apt install -y unattended-upgrades
### >> enter the password
### >> Pay attention for every "Do you want to continue? [Y/n]".

## Configure automatic updates according to advices on https://libre-software.net/ubuntu-automatic-updates/

# sudo vi /etc/apt/apt.conf.d/50unattended-upgrades

## ... or try "sudo apt-get install -y ... " if it is eassier and possible.
## Notice that:
## apt-get may be considered as lower-level and "back-end", and we must know exactly what to use.
## apt is designed for end-users (human) and its output may be changed between versions.
