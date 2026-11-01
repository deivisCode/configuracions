#!/usr/bin/bash

if [ ! -d './newsboat/.git' ] ; then
    mkdir fzf
    git clone https://github.com/newsboat/newsboat
fi

cd newsboat || exit
git switch master && git pull || echo "Non se puido actualizar o repo"

make
sudo make install
