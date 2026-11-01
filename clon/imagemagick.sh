#!/usr/bin/bash

if [ ! -d './imagemagick/.git' ] ; then
    mkdir imagemagick
    git clone --depth 1 https://github.com/ImageMagick/ImageMagick.git imagemagick
fi

cd imagemagick || exit
git switch main && git pull || echo "Non se puido actualizar o repo"

./configure
make
sudo make install
sudo ldconfig /usr/local/lib
