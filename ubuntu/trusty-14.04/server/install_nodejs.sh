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

sudo $aptbin install -y curl build-essential git python libssl-dev 

curl -sL https://deb.nodesource.com/setup | sudo bash -

sudo $aptbin install -y nodejs

sudo npm update -g
sudo npm install -g less recess uglifycss uglify-js bower aglio

