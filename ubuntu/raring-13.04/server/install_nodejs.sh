#!/bin/bash

# install node.js (global system)

aptbin=aptitude
#aptbin=apt-get

sudo $aptbin install -y build-essential git python libssl-dev -y

git clone https://github.com/joyent/node.git
cd node
git checkout v0.11.8

./configure
make
sudo make install

sudo npm install -g less recess uglifycss uglify-js 
