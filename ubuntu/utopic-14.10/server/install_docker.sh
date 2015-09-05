#!/bin/bash

# variables
dockerMachineVersion=0.4.1

# choose with package manager
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

# add official ubuntu docker repository
sudo $aptbin -y install apt-transport-https curl wget
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

echo "deb https://get.docker.com/ubuntu docker main" | sudo tee /etc/apt/sources.list.d/docker.list

sudo $aptbin -y update
sudo $aptbin -y dist-upgrade

# install apparmor and cgroup-lite  needed for docker (not installed by defaut on Linux mint)
sudo $aptbin -y install cgroup-lite apparmor

# install docker
sudo $aptbin -y install lxc-docker

# add current user to docker group to be able to run docker without sudo
sudo groupadd docker
sudo usermod -a -G docker ${USER}

sudo service docker restart

# install docker compose
sudo $aptbin -y install python python-pip python-setuptools
pip install docker-compose

# docker compose bash completion
curl -s -L https://raw.githubusercontent.com/docker/compose/$(docker-compose --version | awk 'NR==1{print $NF}')/contrib/completion/bash/docker-compose > docker-compose-completion
sudo mv docker-compose-completion /etc/bash_completion.d/docker-compose

# docker compose zsh completion
mkdir -p ~/.zsh/completion
curl -s -L https://raw.githubusercontent.com/docker/compose/$(docker-compose --version | awk 'NR==1{print $NF}')/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose

# install docker machine
echo "curl -L https://github.com/docker/machine/releases/download/v$dockerMachineVersion/docker-machine_`uname -s`-amd64 > docker-machine"
curl -s -L https://github.com/docker/machine/releases/download/v$dockerMachineVersion/docker-machine_`uname -s`-amd64 > docker-machine
sudo mv docker-machine /usr/local/bin/docker-machine
sudo chmod +x /usr/local/bin/docker-machine

sudo docker --version
docker-compose --version
docker-machine --version

# configure .zshrc
# echo 'fpath=(~/.zsh/completion $fpath)' >> ~/.zshrc
# echo 'autoload -Uz compinit && compinit -i' >> ~/.zshrc
FILE=~/.zshrc
# if [ -f "$FILE" ]; then
    LINE='fpath=(~/.zsh/completion $fpath)'
    grep -q "$LINE" "$FILE" || echo "$LINE" >> "$FILE"

    LINE='autoload -Uz compinit && compinit -i'
    grep -q "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
# fi
exec $SHELL -l
