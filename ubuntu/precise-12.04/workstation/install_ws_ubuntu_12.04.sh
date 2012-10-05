#!/bin/bash

#new repositories and gpg keys
#google chrome
sudo cp assets/etc/apt/sources.list.d/google-chrome.list /etc/apt/sources.list.d/
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

#opera browser
sudo cp assets/etc/apt/sources.list.d/opera.list /etc/apt/sources.list.d/
wget -q http://deb.opera.com/archive.key -O- | sudo apt-key add -

#virtualbox
sudo cp assets/etc/apt/sources.list.d/virtualbox.list /etc/apt/sources.list.d/
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 98AB5139

#medibuntu
sudo cp assets/etc/apt/sources.list.d/medibuntu.list /etc/apt/sources.list.d/
wget -q http://packages.medibuntu.org/medibuntu-key.gpg -O- | sudo apt-key add -

#grub customizer
sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
#ubuntu tweak
sudo add-apt-repository -y ppa:tualatrix/ppa
#gimp 2.8
sudo add-apt-repository -y ppa:otto-kesselgulasch/gimp

sudo apt-get -y update 
sudo apt-get -y upgrade 

sudo apt-get -y install openssh-server openssh-client openssh-blacklist openssh-blacklist-extra nano kate openssl openssl-blacklist openssl-blacklist-extra bash-completion zsh zsh-doc terminator vim vim-doc emacs vim-gnome trash-cli
sudo apt-get -y install gparted tree mc ttf-inconsolata ack-grep kdesdk-scripts nautilus-open-terminal cups-pdf gedit-plugins gedit-developer-plugins synaptic
sudo apt-get -y install samba samba-doc samba-tools
sudo apt-get -y install manpages-fr manpages-fr-dev manpages-fr-extra build-essential bison
sudo apt-get -y install p7zip p7zip-full p7zip-rar lzma unrar rar
sudo apt-get -y install curl filezilla ncftp lftp rsync subversion subversion-tools git git-cola git-core git-svn git-email git-gui git-doc mercurial mercurial-git hgsvn cvs cvs2svn screen tmux kdiff3 meld tofrodos diffutils colordiff patch dos2unix
sudo apt-get -y install firefox firefox-gnome-support firefox-locale-fr chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg thunderbird thunderbird-locale-fr thunderbird-gnome-support
sudo apt-get -y install openjdk-6-jdk icedtea-6-plugin openjdk-7-jdk icedtea-7-plugin
#sudo apt-get -y autoremove gimp gimp-plugin-registry
sudo apt-get -y install libreoffice graphviz gimp gnucash keepassx keepass2 keepass2-doc ooo-thumbnailer pidgin
sudo apt-get -y install clamav clamav-freshclam
sudo apt-get -y install gnome-shell gnome-panel ubuntu-tweak grub-customizer compizconfig-settings-manager compiz-plugins-extra ubuntu-restricted-extras
sudo apt-get -y install opera google-chrome-stable
sudo apt-get -y install virtualbox-4.1

# requirements for official skype 4
sudo apt-get -y install libqt4-core libqt4-dbus

# requirements for mysql workbench
sudo apt-get -y install mysql-common python-paramiko python-pysqlite2 libctemplate0 libgtkmm-2.4-1c2a

hasPkg1=`dpkg -l | grep -c 'libzip1'`
if [ $hasPkg1 == 0 ]; 
then
    wget https://launchpad.net/ubuntu/+source/libzip/0.9.3-1/+build/1728114/+files/libzip1_0.9.3-1_amd64.deb
    sudo dpkg -i libzip1_0.9.3-1_amd64.deb
    rm libzip1_0.9.3-1_amd64.deb
fi

hasPkg2=`dpkg -l | grep -c 'libmysqlclient16'`
if [ $hasPkg2 == 0 ]; 
then
    wget http://launchpadlibrarian.net/94808408/libmysqlclient16_5.1.58-1ubuntu5_amd64.deb
    sudo dpkg -i libmysqlclient16_5.1.58-1ubuntu5_amd64.deb
    rm libmysqlclient16_5.1.58-1ubuntu5_amd64.deb
fi

