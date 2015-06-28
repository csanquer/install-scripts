#!/bin/bash

# install docker

dockerComposeVersion=1.3.1
dockerMachineVersion=0.3.0

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
sudo $aptbin -y install apt-transport-https
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

sudo docker --version

# install docker compose
curl -L https://github.com/docker/compose/releases/download/$dockerComposeVersion/docker-compose-`uname -s`-`uname -m` > docker-compose
sudo mv docker-compose /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

docker-compose --version

# docker compose bash completion
curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose --version | awk 'NR==1{print $NF}')/contrib/completion/bash/docker-compose > docker-compose-completion
sudo mv docker-compose-completion /etc/bash_completion.d/docker-compose

# docker compose zsh completion
mkdir -p ~/.zsh/completion
curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose --version | awk 'NR==1{print $NF}')/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose

echo 'fpath=(~/.zsh/completion $fpath)' >> ~/.zshrc
echo 'autoload -Uz compinit && compinit -i' >> ~/.zshrc
exec $SHELL -l

# install docker machine
curl -L https://github.com/docker/machine/releases/download/$dockerMachineVersion/docker-machine_`uname -s`-`uname -m` > docker-machine
sudo mv docker-machine /usr/local/bin/docker-machine
sudo chmod +x /usr/local/bin/docker-machine

docker-machine -v
