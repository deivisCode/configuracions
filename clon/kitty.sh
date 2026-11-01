#!/usr/bin/bash

if [ ! -d './kitty/.git' ] ; then
    mkdir kitty
    git clone --depth=1 https://github.com/kovidgoyal/kitty
fi

cd kitty || exit
git switch master && git pull || echo "Non se puido actualizar o repo"
./dev.sh build

cp kitty/launcher/kitty ~/.local/bin/
cp kitty/launcher/kitten ~/.local/bin/
