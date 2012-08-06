#!/bin/bash

sudo apt-get -y update 
sudo apt-get -y upgrade 

sudo apt-get -y install mysql-client mysql-server
sudo apt-get -y install postgresql 
sudo apt-get -y install apache2-mpm-worker apache2-utils libapache2-mod-fcgid apache2-suexec-custom
sudo apt-get -y install php5 php-apc php-pear php5-cgi php5-cli php5-fpm php5-dev php5-curl php5-gd php5-imagick php5-imap php5-intl php5-mcrypt php5-mysql php5-sqlite php5-xdebug php5-xmlrpc php5-xsl php5-pgsql 

sudo cp -R assets/etc/apache2/* /etc/apache2/
sudo cp -R assets/var/www/* /var/www/
sudo cp -R assets/home/www-data /home
sudo chown -R www-data:www-data /home/www-data

sudo sed -i '/ServerRoot \"\/etc\/apache2\"/ aServerName workstation.local' /etc/apache2/apache2.conf 
sudo a2enmod actions alias fcgid headers vhost_alias suexec  rewrite 
sudo service apache2 restart

sudo apt-get -y install phpmyadmin phppgadmin pgadmin3
