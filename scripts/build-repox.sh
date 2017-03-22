#!/usr/bin/env bash

# this script will clone repox, update its configuration.properties file, add
# the necessary config and data directories, build the application using maven,
# create the supporting relational database, move the application to tomcat, and
# then restart tomcat.

# grab the latest release from europeana's github repoxitory (ha ha ha)
git clone https://github.com/europeana/repox

# update the repox configuration file
cp "$SHARED_DIR"/config-files/configuration.properties repox/resource/src/main/resources/

# create repox data and configuration directories
sudo mkdir -p /data/repoxData/{repository,configuration,\[temp\]OAI-PMH_Requests,\[temp\]FTP_Requests,\[temp\]HTTP_Requests,export}
sudo chown -R tomcat8:tomcat8 /data

# build repox
cd repox || exit
mvn clean install -q -Pproduction

# create mysql database
/usr/bin/mysql --user=root --password=vagrant -e "CREATE DATABASE IF NOT EXISTS repoxdb; GRANT USAGE ON *.* TO repox@localhost IDENTIFIED BY 'repox'; GRANT ALL PRIVILEGES ON repoxdb.* TO repox@localhost; FLUSH PRIVILEGES;"

# stop tomcat
sudo systemctl stop tomcat8

# copy the repox war to tomcat
sudo cp repox/gui/target/repox.war /var/lib/tomcat8/webapps/
sudo chown -R tomcat8:tomcat8 /var/lib/tomcat8/webapps/repox.war

# (re)start tomcat
sudo systemctl start tomcat8