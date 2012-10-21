#!/bin/bash

# install node.js (global system)

sudo aptitude install -y build-essential git python libssl-dev -y

git clone git://github.com/joyent/node.git
cd node
git checkout v0.9.1

./configure
make
sudo make install

sudo npm install less recess -g
