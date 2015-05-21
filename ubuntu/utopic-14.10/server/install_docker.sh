#!/bin/bash

# install docker

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

echo "docker version"
sudo docker --version

# install docker compose
curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > docker-compose
sudo mv docker-compose /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# docker compose bash completion
curl -L https://raw.githubusercontent.com/docker/compose/1.2.0/contrib/completion/bash/docker-compose > docker-compose-completion
sudo mv docker-compose-completion /etc/bash_completion.d/docker-compose

echo "docker-compose version"
sudo docker-compose --version
