#!/usr/bin/env bash

# update our packages
sudo apt-get --quiet update

## preconfigure our mysql passwords
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password vagrant'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password vagrant'

## add the following packages to our vm
# checking for java
if hash java 2>/dev/null; then
	echo "** java is installed **"
else
	echo "** installing java **"
	sudo apt-get install --yes --quiet default-jdk
fi

# checking for maven
if hash mvn 2>/dev/null; then
    echo "** maven is installed **"
else
    echo "** installing maven **"
	sudo apt-get install --yes --quiet maven
fi

# checking for tomcat8
if [ -d "/var/lib/tomcat8" ]; then
    echo "** tomcat8 is installed **"
else
    echo "** installing tomcat8 **"
	sudo apt-get install --yes --quiet tomcat8 tomcat8-admin tomcat8-common
fi

# checking for mysql
if hash mysql 2>/dev/null; then
    echo "** mysql is installed **"
else
    echo "** installing mysql **"
	sudo apt-get install --yes --quiet mysql-server mysql-client
fi
