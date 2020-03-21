#!/bin/bash

###### 05_01_install_ansible on ubuntu

sudo pip install ansible

ansible --version

###  write "inventory" file:
#[all:vars]
#ansible_user=dev
#[server22]
#192.168.1.22

###  and then:

#ansible -m ping -i hosts all

###  Let's create sample nginx.yml:
#
#- hosts: all
#  become: yes
#  tasks:
#    - name: Install nginx
#      apt: pkg=nginx state=present update_cache=true

###  And run the command now:

#ansible-playbook -i hosts -l nginx.yml
