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

sudo apt-get -y update 
sudo apt-get -y upgrade 

sudo apt-get -y install acl openssh-server openssh-client openssh-blacklist openssh-blacklist-extra nano kate openssl openssl-blacklist openssl-blacklist-extra bash-completion zsh zsh-doc terminator vim vim-doc emacs vim-gnome trash-cli
sudo apt-get -y install gparted tree mc ttf-inconsolata ack-grep kdesdk-scripts nautilus-open-terminal cups-pdf gedit-plugins gedit-developer-plugins synaptic numlockx
sudo apt-get -y install samba samba-doc samba-tools
sudo apt-get -y install manpages-fr manpages-fr-dev manpages-fr-extra build-essential bison
sudo apt-get -y install p7zip p7zip-full p7zip-rar lzma unrar rar
sudo apt-get -y install curl filezilla ncftp lftp rsync subversion subversion-tools git git-cola git-core git-svn git-email git-gui git-doc mercurial mercurial-git hgsvn cvs cvs2svn screen tmux kdiff3 meld tofrodos diffutils colordiff patch dos2unix
sudo apt-get -y install firefox firefox-gnome-support firefox-locale-fr chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg thunderbird thunderbird-locale-fr thunderbird-gnome-support
sudo apt-get -y install openjdk-6-jdk icedtea-6-plugin openjdk-7-jdk icedtea-7-plugin
#sudo apt-get -y autoremove gimp gimp-plugin-registry
sudo apt-get -y install libreoffice graphviz gimp gnucash keepassx keepass2 keepass2-doc ooo-thumbnailer pidgin
sudo apt-get -y install clamav clamav-freshclam
sudo apt-get -y install gnome-shell gnome-panel grub-customizer compizconfig-settings-manager compiz-plugins-extra ubuntu-restricted-extras
sudo apt-get -y install opera google-chrome-stable
sudo apt-get -y install virtualbox-4.2

# requirements for official skype 4
sudo apt-get -y install libqt4-core libqt4-dbus

sudo cp assets/etc/lightdm/lightdm.conf /etc/lightdm/
sudo cp assets/etc/rc.local /etc/

