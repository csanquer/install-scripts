#!/bin/bash

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


sudo $aptbin -y update 
sudo $aptbin -y dist-upgrade 

sudo $aptbin -y install postgresql postgresql-doc postgresql-client postgresql-contrib
sudo $aptbin -y install php5-pgsql

read -p "Install phppgadmin ? " yn
case $yn in
    [YyOo]* ) 
        sudo $aptbin -y install phppgadmin;
        ;;
    [Nn]* ) 
        ;;
esac

read -p "Install pgadmin3 ? " yn
case $yn in
    [YyOo]* ) 
        sudo $aptbin -y install pgadmin3;
        ;;
    [Nn]* ) 
        ;;
esac
