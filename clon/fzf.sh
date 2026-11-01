#!/usr/bin/bash

echo "Hai que rular ./install a man ao acabar"

if [ ! -d './fzf/.git' ] ; then
    mkdir fzf
    git clone https://github.com/junegunn/fzf
fi

cd fzf || exit
git switch master && git pull || echo "Non se puido actualizar o repo"

./install

mv ./bin/fzf $HOME/.local/bin \
    && echo "Moveuse correctamente a .local/bin/" \
    || echo "Algo fallou ao mover"
