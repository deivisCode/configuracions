#!/usr/bin/bash

if [ ! -d './thes_gl_volga/.git' ] ; then
    mkdir thes_gl_volga
    git clone --depth=1 https://github.com/meixome/thes_gl_volga
fi

cd thes_gl_volga || exit
git switch master && git pull || echo "Non se puido actualizar o repo"

cp thesaurus_gl.* "/home/david/.deivis_datos/recursos/codigo/thesaurus/" && \
    echo "Movéronse correctamente os arquivos de thesaurus" || \
    echo "Non se puideron mover os arquivos de thesaurus"
# Ollo, esto non xera os thesaurus. Fai falta fedellar nos arquivos e limpalos
