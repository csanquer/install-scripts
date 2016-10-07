#/bin/bash


if [ ! -x "$(command -v lsb_release)" ]; then
    echo 'please install lsb release package'
    if [ -x "$(command -v apt-get)" ]; then
        sudo apt-get install -y lsb-release
    #elif [ -x "$(command -v yum)" ]; then
    #    sudo yum install -y lsb-release
    fi
fi

user=`whoami`

distId=`lsb_release -si`
distRelease=`lsb_release -sr`
distCodename=`lsb_release -sc`

if [ "$distId" = 'Debian' -o "$distId" = 'Ubuntu' ]; then
    sudo apt-get install -y build-essential libffi-dev libssl-dev python python-dev python-setuptools git
    sudo easy_install pip
    sudo pip install pycparser==2.13
    sudo pip install -U ansible
fi

ansible-galaxy install -r roles.txt -p roles

ansible-playbook main.yml --ask-become-pass -u $user
