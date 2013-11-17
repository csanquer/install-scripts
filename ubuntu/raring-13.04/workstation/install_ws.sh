#!/bin/bash

PS3='Package Manager to use : '
options=("apt-get" "aptitude")
select opt in "${options[@]}"
do
    case $opt in
        "apt-get")
            aptbin=apt-get
            break;;
        "aptitude")
            aptbin=aptitude
            break;;
        *)
        echo invalid option
        break;;
    esac
done

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

#videolan libdvdcss
sudo cp assets/etc/apt/sources.list.d/videolan-libdvdcss.list /etc/apt/sources.list.d/
wget -q ftp://ftp.videolan.org/pub/debian/videolan-apt.asc -O- | sudo apt-key add -
#grub customizer
sudo add-apt-repository ppa:danielrichter2007/grub-customizer

#chromium
#sudo add-apt-repository -y ppa:chromium-daily/stable

sudo $aptbin -y update 
sudo $aptbin -y upgrade 

sudo $aptbin -y install synaptic
sudo $aptbin -y install acl openssh-server openssh-client openssh-blacklist openssh-blacklist-extra nano  openssl openssl-blacklist openssl-blacklist-extra bash-completion zsh zsh-doc terminator vim vim-doc emacs vim-gnome trash-cli ctags zsh
sudo $aptbin -y install gparted tree mc ttf-inconsolata ack-grep nautilus-open-terminal cups-pdf gedit-plugins gedit-developer-plugins synaptic ttf-inconsolata
sudo $aptbin -y install samba samba-doc samba-tools
sudo $aptbin -y install manpages-fr manpages-fr-dev manpages-fr-extra build-essential bison
sudo $aptbin -y install p7zip p7zip-full p7zip-rar lzma unrar rar unace
sudo $aptbin -y install curl filezilla ncftp lftp rsync subversion subversion-tools git git-cola git-core git-svn git-email git-gui git-doc mercurial mercurial-git hgsvn cvs cvs2svn screen tmux meld tofrodos diffutils colordiff patch dos2unix
sudo $aptbin -y install firefox firefox-gnome-support firefox-locale-fr chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg thunderbird thunderbird-locale-fr thunderbird-gnome-support webaccounts-chromium-extension unity-chromium-extension
sudo $aptbin -y install openjdk-6-jdk icedtea-6-plugin openjdk-7-jdk icedtea-7-plugin
#sudo $aptbin -y autoremove gimp gimp-plugin-registry
sudo $aptbin -y install libreoffice graphviz gimp inkscape keepassx keepass2 keepass2-doc ooo-thumbnailer pidgin
sudo $aptbin -y install gnucash
sudo $aptbin -y install clamav clamav-freshclam
sudo $aptbin -y install ubuntu-restricted-extras libdvdcss2
sudo $aptbin -y install opera google-chrome-stable
sudo $aptbin -y install virtualbox-4.3
sudo $aptbin -y install grub-customizer 
read -p "Install kate kdiff3 and kdesdk-scripts ? " yn
case $yn in
    [YyOo]* ) 
        sudo $aptbin -y install kate kdiff3 kdesdk-scripts;
        ;;
    [Nn]* ) 
        ;;
esac
read -p "Install compizconfig-settings-manager compiz-plugins-extra ? " yn
case $yn in
    [YyOo]* ) 
        sudo $aptbin -y install compizconfig-settings-manager compiz-plugins-extra ;
        ;;
    [Nn]* ) 
        ;;
esac
read -p "Install gnome shell and gnome panel ? " yn
case $yn in
    [YyOo]* ) 
        sudo $aptbin -y install gnome-shell gnome-panel;
        ;;
    [Nn]* ) 
        ;;
esac

read -p "Install numlockx ? " yn
case $yn in
    [YyOo]* ) 
        sudo $aptbin -y install numlockx;
        ;;
    [Nn]* ) 
        ;;
esac

#sudo cp assets/etc/lightdm/lightdm.conf /etc/lightdm/
#sudo cp assets/etc/rc.local /etc/

