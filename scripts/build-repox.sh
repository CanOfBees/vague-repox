#!/usr/bin/env bash

# this script will clone repox, update its configuration.properties file, add
# the necessary config and data directories, build the application using maven,
# create the supporting relational database, move the application to tomcat, and
# then restart tomcat.

# grab the latest release from europeana's github repoxitory (ha ha ha)
echo "** checking repox **"
if [ ! -d "~/repox" ]; then
    echo "** cloning repox **"
	git clone https://github.com/europeana/repox
else
	echo "** we already have repox -- let's update it **"
	cd ~/repox || exit
	git pull
	cd ~
fi

# update the repox configuration file
echo "** updating configuration.properties **"
cp /vagrant/config-files/configuration.properties ~/repox/resources/src/main/resources/

echo "** updating Swagger UI username and password **"
cp /vagrant/config-files/security.xml ~/repox/server/rest-jersey/src/main/webapp/WEB-INF/

# create repox data and configuration directories
echo "** adding new directories **"
sudo mkdir -p /data/repoxData/{repository,configuration,\[temp\]OAI-PMH_Requests,\[temp\]FTP_Requests,\[temp\]HTTP_Requests,export}
sudo cp /vagrant/config-files/metadataSchemas.xml /data/repoxData/configuration/metadataSchemas.xml
sudo chown -R tomcat8:tomcat8 /data

# build repox
echo "** building repox **"
cd repox || exit
mvn clean install -q -Pproduction
cd ~

# create mysql database
echo "** creating a repox database **"
/usr/bin/mysql --user=root --password=vagrant -e "CREATE DATABASE IF NOT EXISTS repoxdb; GRANT USAGE ON *.* TO repox@localhost IDENTIFIED BY 'repox'; GRANT ALL PRIVILEGES ON repoxdb.* TO repox@localhost; FLUSH PRIVILEGES;"

# stop tomcat
echo "** stopping tomcat **"
sudo systemctl stop tomcat8

# copy the repox war to tomcat
echo "** copying repox to tomcat **"
sudo cp repox/gui/target/repox.war /var/lib/tomcat8/webapps/
sudo chown -R tomcat8:tomcat8 /var/lib/tomcat8/webapps/repox.war

# set environmental variable
echo "set environmental variables"
sudo cp /vagrant/config-files/setenv.sh /usr/share/tomcat8/bin/
sudo chmod 777 /usr/share/tomcat8/bin/setenv.sh

# (re)start tomcat
echo "** starting tomcat **"
sudo systemctl start tomcat8
