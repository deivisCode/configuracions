#!/usr/bin/bash

if [ ! -d './asymptote/.git' ] ; then
    mkdir asymptote
    git clone --depth=1 https://github.com/vectorgraphics/asymptote
fi

cd asymptote || exit
git switch master && git pull || echo "Non se puido actualizar o repo"
./autogen.sh
./configure
make all
make install
