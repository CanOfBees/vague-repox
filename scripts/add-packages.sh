#!/usr/bin/env bash

# update our packages
sudo apt-get update

## add the following packages to our vm
sudo apt-get install --yes --quiet default-jdk
sudo apt-get install --yes --quiet maven
sudo apt-get install --yes --quiet tomcat8 tomcat8-admin tomcat8-common
sudo apt-get install --yes --quiet mysql-server mysql-client