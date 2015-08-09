#!/bin/bash

sudo apt-get install git build-essential

ROOTPATH=/usr/local
VERSION=1.4.2
OS=linux
ARCH=amd64

# echo "export GOROOT=/usr/local/go
# export GOPATH=\$HOME/workspace/go
# export GOBIN=\$GOROOT/bin
# export PATH=\$PATH:\$GOROOT/bin
# " >> ~/.bashrc

# sudo git clone https://go.googlesource.com/go $goRootPath
# cd $goRootPath
# sudo git checkout go$goVersion
#
# cd $goRootPath/src
#
# sudo ./all.bash

if [ ! -f go$VERSION.$OS-$ARCH.tar.gz ]; then
    wget https://storage.googleapis.com/golang/go$VERSION.$OS-$ARCH.tar.gz
fi

sudo rm -rf $ROOTPATH/go
sudo tar -C $ROOTPATH -xzf go$VERSION.$OS-$ARCH.tar.gz

grep -q "export PATH=\$PATH:$ROOTPATH/go/bin" /etc/bash.bashrc
if [ $? -ne 0 ]; then
    echo "export PATH=\$PATH:$ROOTPATH/go/bin" | sudo tee -a /etc/bash.bashrc
fi

grep -q "export PATH=\$PATH:$ROOTPATH/go/bin" /etc/zsh/zshrc
if [ $? -ne 0 ]; then
    echo "export PATH=\$PATH:$ROOTPATH/go/bin" | sudo tee -a /etc/zsh/zshrc
fi

sudo GOPATH=~/workspace/go $ROOTPATH/go/bin/go get golang.org/x/tools/cmd/godoc
