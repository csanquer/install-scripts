#!/bin/bash

# install node.js (global system)

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

sudo $aptbin install -y build-essential git python libssl-dev 

if [ -d 'node' ]; then
    cd node
    git checkout master
    git fetch
    git merge origin/master
else
    echo clone NodeJS from Github
    git clone https://github.com/joyent/node.git
    cd node
    git checkout master
fi

lastTag=`git describe --abbrev=0 --tags`
echo use NodeJS $lastTag
git checkout $lastTag

./configure
make
sudo make install

sudo npm update -g
sudo npm install -g less recess uglifycss uglify-js bower
