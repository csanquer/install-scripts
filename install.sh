#/bin/bash

echo -n  "SUDO Password: "
stty -echo
read sudopassword
stty echo
echo

if [ ! -x "$(command -v lsb_release)" ]; then
    if [ -x "$(command -v apt-get)" ]; then
        echo 'installing lsb release'
        echo "$sudopassword\n" | sudo -S -p '' apt-get install -y lsb-release
    # elif [ -x "$(command -v yum)" ]; then
    #    echo "$sudopassword\n" | sudo -S -p '' yum install -y redhat-lsb
    fi
fi

user=`whoami`

distId=`lsb_release -si`
distRelease=`lsb_release -sr`
distCodename=`lsb_release -sc`


if [ "$distId" = 'Debian' -o "$distId" = 'Ubuntu' ]; then
    if [ ! -x "$(command -v pip)" ]; then
        echo "installing Python and build dependencies ..."
        echo "$sudopassword\n" | sudo -S -p '' apt-get install -y -q build-essential libffi-dev libssl-dev python python-dev python-pip git
    fi
    if [ ! -x "$(command -v ansible)" ]; then
        echo "installing Ansible ..."
        echo "$sudopassword\n" | sudo -S -p '' pip install -q -U ansible
    fi
fi

echo "installing ansible galaxy roles"
ansible-galaxy install -r roles.yml -p roles

playbook_options="-u $user $@"

if [ -f "vault/secrets.yml" ];then
    playbook_options="$playbook_options --ask-vault-pass"
fi

echo "running ansible playbook ..."
echo "command : ansible-playbook main.yml --ask-become-pass --extra-vars \"account_default_user=$user\" $playbook_options"
ansible-playbook main.yml --extra-vars "ansible_become_pass=$sudopassword account_default_user=$user" $playbook_options
