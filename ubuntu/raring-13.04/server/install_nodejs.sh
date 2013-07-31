#!/bin/bash

# install node.js (global system)

aptbin=aptitude
#aptbin=apt-get

sudo $aptbin install -y build-essential git python libssl-dev -y

git clone https://github.com/joyent/node.git
cd node
git checkout v0.9.1

./configure
make
sudo make install

sudo npm install less recess -g
