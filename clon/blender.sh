#!/usr/bin/bash

if [ ! -d './blender-git/blender/.git' ] ; then
    mkdir blender-git/
    cd blender-git
    git clone --depth=1 https://projects.blender.org/blender/blender.git
fi

cd blender || exit
git switch main && git pull || echo "Non se puido actualizar o repo"
make update
make
