#!/bin/bash

#new repositories
sudo cp assets/* /apt/apt/sources.list.d/
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
wget -q http://packages.medibuntu.org/medibuntu-key.gpg -O- | sudo apt-key add -
wget -q http://deb.opera.com/archive.key -O- | sudo apt-key add -

sudo add-apt-repository ppa:danielrichter2007/grub-customizer
sudo add-apt-repository ppa:tualatrix/ppa

sudo apt-get -y update 
sudo apt-get -y upgrade 

# requirements for mysql workbench

wget https://launchpad.net/ubuntu/+source/libzip/0.9.3-1/+build/1728114/+files/libzip1_0.9.3-1_amd64.deb
sudo dpkg -i libzip1_0.9.3-1_amd64.deb
rm libzip1_0.9.3-1_amd64.deb

wget http://launchpadlibrarian.net/94808408/libmysqlclient16_5.1.58-1ubuntu5_amd64.deb
sudo dpkg -i libmysqlclient16_5.1.58-1ubuntu5_amd64.deb
rm libmysqlclient16_5.1.58-1ubuntu5_amd64.deb
