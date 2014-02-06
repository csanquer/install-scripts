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
    git fetch
else
    git clone https://github.com/joyent/node.git
    cd node
fi

git checkout v0.11.11

./configure
make
sudo make install

sudo npm install -g less recess uglifycss uglify-js 
