# Vague-REPOX

A Vagrant-based REPOX testing environment for DLTN.

**Note: ** not intended for production!

## Requirements
* Vagrant
* VirtualBox

## Use

1. git clone https://github.com/can-of-bees/vague-repox
2. cd vague-repox
3. vagrant up

## Connect

[Repox Interface](http://localhost:8080/repox):

* username: admin
* password: admin

SSH:

* Option 1:
	* vagrant ssh
* Option 2:
	* ssh -p 2222 vagrant@localhost
	* password: vagrant

MySQL:

* connect: jdbc:mysql://localhost:3306/repoxdb
* username: repox
* password: repox

[Swagger APIs](http://localhost:8080/repox/gui/index.html):

* username: admin
* password: admin

