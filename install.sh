#/bin/bash

if [ ! -x "$(command -v lsb_release)" ]; then
    if [ -x "$(command -v apt-get)" ]; then
        echo 'installing lsb release'
        sudo apt-get install -y lsb-release
    # elif [ -x "$(command -v yum)" ]; then
    #    sudo yum install -y redhat-lsb
    fi
fi

user=`whoami`

distId=`lsb_release -si`
distRelease=`lsb_release -sr`
distCodename=`lsb_release -sc`

if [ "$distId" = 'Debian' -o "$distId" = 'Ubuntu' ]; then
    if [ ! -x "$(command -v pip)" ]; then
        echo "installing Python and build dependencies ..."
        sudo apt-get install -y -q build-essential libffi-dev libssl-dev python python-dev python-setuptools git
        sudo easy_install -q pip
    fi
    echo "installing Ansible ..."
    sudo pip install -q -U ansible
fi

echo "installing ansible galaxy roles"
ansible-galaxy install -r roles.txt -p roles

playbook_options="-u $user --ask-become-pass $@"

if [ -f "vault/secrets.yml" ];then
    playbook_options="$playbook_options --ask-vault-pass"
fi

echo "running ansible playbook ..."
echo "command : 'ansible-playbook main.yml $playbook_options"
ansible-playbook main.yml $playbook_options
