#!/usr/bin/bash

if [ ! -d './rdrview/.git' ] ; then
    mkdir rdrview
    git clone --depth=1 https://github.com/eafer/rdrview
fi

cd rdrview || exit
git switch master && git pull || echo "Non se puido actualizar o repo"
make
sudo make install
