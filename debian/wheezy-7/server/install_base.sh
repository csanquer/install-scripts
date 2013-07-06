#!/bin/bash

aptbin=aptitude

# dotdeb.org repository (PHP 5.4 or 5.5)
sudo cp assets/etc/apt/sources.list.d/dotdeb.list /etc/apt/sources.list.d/
wget -q -O - http://www.dotdeb.org/dotdeb.gpg | sudo apt-key add -

# maria db ( mysql fork)
sudo cp assets/etc/apt/sources.list.d/mariadb.list /etc/apt/sources.list.d/
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db

# subversion 1.7
sudo cp assets/etc/apt/sources.list.d/svn.list /etc/apt/sources.list.d/
wget -q -O - http://opensource.wandisco.com/wandisco-debian.gpg | sudo apt-key add -

#new user base config files
sudo cp -R assets/etc/skel /etc/

sudo $aptbin -y update 
sudo $aptbin -y dist-upgrade 

sudo $aptbin -y install openssh-server openssh-client openssh-blacklist openssh-blacklist-extra nano openssl openssl-blacklist openssl-blacklist-extra bash-completion zsh zsh-doc vim vim-doc emacs  tree mc acl ack-grep manpages-fr manpages-fr-dev manpages-fr-extra build-essential bison p7zip p7zip-full p7zip-rar lzma unrar rar curl ncftp lftp rsync subversion subversion-tools git git-core git-svn git-email git-doc mercurial mercurial-git hgsvn cvs cvs2svn screen tmux tofrodos diffutils colordiff patch dos2unix clamav clamav-freshclam openjdk-7-jdk python-software-properties ntpdate fail2ban ufw locales tzdata ntpdate

sudo dpkg-reconfigure tzdata
sudo dpkg-reconfigure locales

