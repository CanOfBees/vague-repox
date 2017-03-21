#!/usr/bin/env bash

# update our packages
sudo apt-get update

## add the following packages to our vm
sudo apt-get install --yes default-jdk
sudo apt-get install --yes maven
sudo apt-get install --yes tomcat8 tomcat8-admin tomcat8-common