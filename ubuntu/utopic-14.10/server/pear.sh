#!/bin/bash

#sudo $aptbin -y install phppgadmin

# configure PHP
for app in cli fpm
do
    sudo sed -i 's|;\(date.timezone =\)|\1 Europe\/Paris|' /etc/php5/$app/php.ini
    sudo sed -i 's/^\(error_reporting =\).*$/\1 E_ALL | E_STRICT/' /etc/php5/$app/php.ini 
    sudo sed -i 's/^\(display_errors =\).*$/\1 On/' /etc/php5/$app/php.ini 
done

for app in fpm
do
    sudo sed -i 's/^\(memory_limit =\).*$/\1 128M/' /etc/php5/$app/php.ini 
    sudo sed -i 's/^\(html_errors =\).*$/\1 On/' /etc/php5/$app/php.ini 
done

#sudo $aptbin -y remove libapache2-mod-php5 apache2-mpm-prefork
        
# configure mysql
sudo sed -i "/\[mysqld\]/ a\
# encoding and storage engine\n\
default-storage-engine=INNODB\n\
init-connect='SET NAMES utf8'\n\
# mysql 5.1\n\
#default-character-set=utf8\n\
#default-collation=utf8_unicode_ci\n\
\n\
#mysql 5.5\n\
character-set-server=utf8\n\
collation-server=utf8_unicode_ci\n\
" /etc/mysql/my.cnf

# Xdebug config
sudo sed -i '/zend_extension=.*/ a \
xdebug.remote_enable=On \
xdebug.remote_host="localhost" \
xdebug.remote_port=9001 \
xdebug.remote_handler="dbgp" \
xdebug.idekey=netbeans-xdebug \
xdebug.cli_color=2 \
xdebug.max_nesting_level=1000 \
xdebug.collect_params=2 \
xdebug.collect_return=On \
' /etc/php5/mods-available/xdebug.ini

sudo service nginx restart
sudo service php5-fpm restart
sudo service mysql restart

# PHP Tools
sudo mkdir /opt/composer
curl -s https://getcomposer.org/installer | sudo php -- --install-dir=/opt/composer
sudo chmod 755 /opt/composer/composer.phar
sudo ln -s /opt/composer/composer.phar /usr/local/bin/composer

sudo wget http://get.sensiolabs.org/php-cs-fixer.phar -O /usr/local/bin/php-cs-fixer
sudo chmod a+x /usr/local/bin/php-cs-fixer

sudo wget https://phar.phpunit.de/phpunit.phar -O /usr/local/bin/phpunit
sudo chmod a+x /usr/local/bin/phpunit

sudo pear config-set auto_discover 1
sudo pear update-channels
sudo pear upgrade
sudo pear install PHP_CodeSniffer

sudo pear channel-discover pear.phpmd.org 
sudo pear channel-discover pear.pdepend.org 
sudo pear install phpmd/PHP_PMD

sudo pear channel-discover pear.phpdoc.org
sudo pear install phpdoc/phpDocumentor
