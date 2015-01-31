#!/bin/bash

#install ruby rbenv

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

currentUser=`whoami`

sudo $aptbin -y update
sudo $aptbin -y dist-upgrade

sudo $aptbin -y install curl git bash bash-completion patch diffutils build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion libcurl4-openssl-dev
#sudo $aptbin -y install mysql-client mysql-server libmysqlclient-dev
#sudo $aptbin -y install postgresql libpq-dev
#sudo $aptbin -y install apache2-mpm-worker libapache2-mod-fcgid apache2-suexec-custom apache2-threaded-dev
sudo $aptbin -y install apache2-utils curl postfix
sudo $aptbin -y install imagemagick libmagickcore-dev libmagickwand-dev


git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

if [ -f ~/.zshrc ]; then
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(rbenv init -)"' >> ~/.zshrc
    source ~/.zshrc
fi

if [ -f ~/.bashrc ]; then
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    source ~/.bashrc
fi

currentShell=`ps -p $$ | tail -1 | awk '{print $NF}'`

if [ "$currentShell" = "bash" ];then
    source ~/.bashrc
elif [ "$currentShell" = "zsh" ]; then
    source ~/.zshrc
fi

type rbenv

rbenv install 2.1.5
rbenv rehash
rbenv global 2.1.5
rbenv shell 2.1.5
rbenv local 2.1.5

gem update --system
gem install bundler redcarpet rails rake passenger compass
