#!/usr/bin/bash

if [ ! -d './neovim/.git' ] ; then
    mkdir neovim
    git clone https://github.com/neovim/neovim
fi

cd neovim || exit
git switch master && git pull || echo "Non se puido actualizar o repo"
make distclean && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
