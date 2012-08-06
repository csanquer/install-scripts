#!/bin/bash

sudo apt-get -y update 
sudo apt-get -y upgrade 

sudo apt-get -y install mysql-client mysql-server
sudo apt-get -y install apache2-mpm-worker apache2-utils libapache2-mod-fcgid apache2-suexec-custom
sudo apt-get -y install php5 php-apc php-pear php5-cgi php5-cli php5-fpm php5-dev php5-curl php5-gd php5-imagick php5-imap php5-intl php5-mcrypt php5-mysql php5-sqlite php5-xdebug php5-xmlrpc php5-xsl

sudo cp -R assets/etc/apache2/* /etc/apache2/
sudo cp -R assets/var/www/* /var/www/
sudo cp -R assets/home/www-data /home
chown -R www-data:www-data /home/www-data

