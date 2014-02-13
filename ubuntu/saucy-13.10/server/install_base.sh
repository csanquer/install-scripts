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

sudo $aptbin -y update 
sudo $aptbin -y dist-upgrade 

sudo $aptbin -y install openssh-server openssh-client openssh-blacklist openssh-blacklist-extra nano openssl openssl-blacklist openssl-blacklist-extra bash-completion zsh zsh-doc vim vim-doc emacs trash-cli tree mc acl ack-grep manpages-fr manpages-fr-dev manpages-fr-extra build-essential bison p7zip p7zip-full p7zip-rar lzma unrar rar unace curl ncftp lftp rsync subversion subversion-tools git git-extras git-core git-svn git-email git-doc mercurial mercurial-git hgsvn cvs cvs2svn screen tmux tofrodos diffutils colordiff patch dos2unix openjdk-7-jdk clamav clamav-freshclam
