#!/usr/bin/bash

if [ ! -d './listas-base/.git' ] ; then
    mkdir listas-base
    git clone --depth=1 https://github.com/meixome/listas-base
fi

cd listas-base || exit
git switch master && git pull || echo "Non se puido actualizar o repo"

cd volga || exit

rm thesaurus.txt || echo "Non existe thesaurus actual"

# o arquivo ese de sinonimos debe ser parseado. E mais facil esto que co de idx # e aff
qsv select -d ',' 1,4 -- sinonimos-totais.csv | \
    sed 's/=>//' | \
    sed 's/>//'  | \
    sed 's/,/ /' > th_gl.txt && echo "Formateouse con exito"

cp th_gl.txt "/home/david/.deivis_datos/recursos/codigo/thesaurus/" && \
    echo "Movéronse correctamente o arquivo thesaurus" || \
    echo "Non se puideron mover o arquivo thesaurus"
