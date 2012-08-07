#!/bin/bash
currentUser=`whoami`

echo "current RVM installation ..."
which rvm
if [ $? != 0 ] ;
then
    echo 'rvm is not installed or configured'
    echo "install rvm and make sure that the current user $currentUser has \"source /etc/profile.d/rvm.sh\" in his .bashrc or .bash_profile"
    exit 1
fi

rvmgroup=`groups $currentUser | grep -c rvm`
if [ $rvmgroup == 0 ] ;
then
    echo "the current user $currentUser is not a member of rvm group"
    echo "use \"sudo adduser $currentUser rvm\" and logout (from terminal and Xsession) then login again"
    exit 1
fi

groupWrite=`umask -S | grep -c 'g=r\?wx\?'`
if [ $groupWrite == 0 ];
then
   echo $groupWrite
   echo "the current user $currentUser has not group write umask"
   echo "use umask g+w"
fi

#umask g+w
#source /etc/profile.d/rvm.sh

rvm install 1.9.3
rvm use --default 1.9.3
rvm alias create default ruby-1.9.3-p194

rvm use 1.9.3

gem update --system
gem install bundler redcarpet rails rake passenger

rvmsudo passenger-install-apache2-module

sudo cp assets/etc/apache2/conf.d/rvm_passenger.conf /etc/apache2/conf.d/
sudo service apache2 restart
